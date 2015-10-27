;; -*- coding: utf-8 -*-
;;
;; Filename: rc-elisp.el
;; Created:  Thu May 1 16:30:43 2014 +0400
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package erefactor
  :config
  ;;TODO: investigate package
  (bind-key "C-c C-v" erefactor-map emacs-lisp-mode-map))

(defun custom/elisp-mode-hook ()
  (auto-fill-mode 1)
  (setq indent-tabs-mode t)
  (setq tab-width 2)
  (setq comment-start ";;")
  (turn-on-eldoc-mode))

(add-hook 'emacs-lisp-mode-hook 'custom/elisp-mode-hook)
(add-hook 'emacs-lisp-mode-hook 'common-hooks/prog-helpers)
(add-hook 'emacs-lisp-mode-hook 'common-hooks/newline-hook)
(add-hook 'emacs-lisp-mode-hook 'custom/remove-elc-on-save)
(add-hook 'emacs-lisp-mode-hook 'ac-emacs-lisp-mode-setup)
(add-hook 'ielm-mode-hook 'custom/ielm-auto-complete)
(dolist (hook '(emacs-lisp-mode-hook ielm-mode-hook))
  (add-hook hook 'elisp-slime-nav-mode))

(provide 'rc-elisp)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-elisp.el ends here
