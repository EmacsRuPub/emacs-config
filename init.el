(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "https://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives
             '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives
             '("RSW-Packages" . "http://www.plasmas.biz/rswe/") t)
(setf (cdr (assoc "gnu" package-archives))
      "https://elpa.gnu.org/packages/")
(package-initialize)

(setq use-package-verbose t)
(setq load-prefer-newer t)

;; open literate config fast in case of emergency
(global-set-key (kbd "C-x C-g")
                (lambda ()
                  (interactive)
                  (find-file "/home/octocat/.emacs.d/config.org")))
(global-set-key (kbd "C-x C-.")
                (lambda ()
                  (interactive)
                  (switch-to-buffer "*Messages*")))

(mapcar
 (lambda (package)
   (unless (package-installed-p package)
     (unless package-archive-contents
       (package-refresh-contents))
     (package-install package)))
 ;;base system packages for bootstrapping
 '(req-package el-get))

(require 'req-package)

(req-package org-plus-contrib)
(setq org-contrib-base '(org-agenda org-archive org-attach org-bbdb
                         org-bibtex org-clock org-docview org-habit
                         org-id org-info org-inlinetask org-irc
                         org-mouse org-protocol org-timer org-w3m))
(setq org-contrib-extra '(org-bookmark org-checklist org-collector
                          org-drill org-expiry org-index org-interactive-query
                          org-man org-velocity))
(setq org-modules `(,@org-contrib-base ,@org-contrib-extra))

(org-babel-load-file (concat (file-name-directory load-file-name) "config.org"))

(req-package-finish)
