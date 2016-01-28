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

(setq use-package-verbose t)
(setq load-prefer-newer t)

(mapcar
 (lambda (package)
   (unless (package-installed-p package)
     (package-install package)))
 ;;base system packages for bootstrapping
 '(bind-key use-package))

(require 'use-package)

(use-package org-plus-contrib :ensure t)
(setq org-modules
      '(org-agenda org-archive org-attach org-bbdb org-bibtex org-bookmark
        org-checklist org-clock org-collector org-docview org-drill org-expiry
        org-habit org-id org-info org-inlinetask org-interactive-query org-irc
        org-man org-mouse org-protocol org-timer org-w3m))

(org-babel-load-file (concat (file-name-directory load-file-name) "config.org"))
