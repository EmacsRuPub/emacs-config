;;; sources-common.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(require 'package)
(add-to-list 'package-archives
       '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
       '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives
       '("elpa" . "http://tromey.com/elpa/"))
(add-to-list 'package-archives
       '("org" . "http://orgmode.org/elpa/"))
(package-initialize)

(mapcar
 (lambda (package)
   (unless (package-installed-p package)
     (package-install package)))
 ;;base system packages for bootstrapping
 '(bind-key diminish use-package f names))

(require 'use-package)
(setq use-package-verbose t)
(setq load-prefer-newer t)

(use-package auto-compile
  :ensure t
  :config
  (auto-compile-on-load-mode 1)
  (auto-compile-on-save-mode 1)
  (setq auto-compile-display-buffer nil)
  (setq auto-compile-mode-line-counter t))

(use-package f :ensure t)

(provide 'packages)

;;; sources-common.el ends here
