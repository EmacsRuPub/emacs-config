;;; emacs-rc-elisp.el --- Settings for Emacs Lisp editing

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

;#############################################################################
;#   Hooks
;############################################################################
(defun custom/elisp-mode-hook ()
  (setq indent-tabs-mode t)
  (setq tab-width 2)
  (abbrev-mode 1)
  (auto-fill-mode 1)
  (turn-on-eldoc-mode)
  ;; (paredit-mode 1)
  (local-set-key [(control c) /] 'semantic-ia-complete-symbol)
  )

(add-hook 'emacs-lisp-mode-hook 'custom/elisp-mode-hook)
(add-hook 'emacs-lisp-mode-hook 'common-hooks/comment-hook)
(add-hook 'emacs-lisp-mode-hook 'common-hooks/show-prog-keywords)
(add-hook 'emacs-lisp-mode-hook 'common-hooks/newline-hook)

;;; emacs-rc-elisp.el ends here



