;;; emacs-rc-elisp.el --- Settings for Emacs Lisp editing

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(require 'erefactor)

(add-hook 'emacs-lisp-mode-hook
       (lambda ()
         (define-key emacs-lisp-mode-map "\C-c\C-v" erefactor-map)))

(defun custom/elisp-mode-hook ()
  (setq indent-tabs-mode t)
  (setq tab-width 2)
  (abbrev-mode 1)
  (auto-fill-mode 1)
  (turn-on-eldoc-mode)
  (paren-face-mode))

(add-hook 'emacs-lisp-mode-hook 'custom/elisp-mode-hook)

(add-hook 'emacs-lisp-mode-hook 'common-hooks/prog-helpers)
(add-hook 'emacs-lisp-mode-hook 'common-hooks/newline-hook)
(add-hook 'emacs-lisp-mode-hook 'custom/remove-elc-on-save)
(add-hook 'emacs-lisp-mode-hook 'ac-emacs-lisp-mode-setup)
(add-hook 'ielm-mode-hook 'custom/ielm-auto-complete)

(dolist (hook '(emacs-lisp-mode-hook ielm-mode-hook))
  (add-hook hook 'elisp-slime-nav-mode))

(provide 'rc-elisp)

;;; emacs-rc-elisp.el ends here
