(setq debug-on-error t)
(setq debug-on-quit t)

(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "https://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives
             '("org" . "http://orgmode.org/elpa/"))
(setf (cdr (assoc "gnu" package-archives))
      "https://elpa.gnu.org/packages/")
(package-initialize)

(require 'cl)

(setq use-package-verbose t)
(setq load-prefer-newer t)

(mapcar
 (lambda (package)
   (unless (package-installed-p package)
     (unless package-archive-contents
       (package-refresh-contents))
     (package-install package)))
 ;;base system packages for bootstrapping
 '(req-package el-get))

(require 'req-package)
(setq req-package-log-level 'trace)

(global-set-key (kbd "C-x C-.")
                (lambda ()
                  (interactive)
                  (switch-to-buffer "*Messages*")))

;; open literate config fast in case of emergency (and not only)
(req-package iqa
  :force t
  :init
  (setq iqa-user-init-file (concat user-emacs-directory "config.org"))
  :config
  (iqa-setup-default))

(req-package restart-emacs
  :force t
  :config
  (global-set-key (kbd "C-x C-c") 'restart-emacs))

(req-package exec-path-from-shell
  :force t
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))

(req-package org-plus-contrib
  :loader :elpa
  :force t)
(require 'org)

(setq org-contrib-base '(org-agenda org-archive org-attach org-bbdb
                         org-bibtex org-clock org-docview org-habit
                         org-id org-info org-inlinetask org-irc
                         org-mouse org-protocol org-timer org-w3m))
(setq org-contrib-extra '(org-bookmark org-checklist org-collector
                          org-drill org-expiry org-index org-interactive-query
                          org-man org-velocity))
(setq org-modules `(,@org-contrib-base ,@org-contrib-extra))

(req-package bug-hunter :disabled t)

(org-babel-load-file (concat (file-name-directory load-file-name) "config.org"))

(req-package-finish)

(setq debug-on-error nil)
(setq debug-on-quit nil)
