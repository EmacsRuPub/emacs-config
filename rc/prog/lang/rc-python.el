;;; emacs-rc-python.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

;#############################################################################
;#   Custom definitions
;############################################################################
(defun electric-pair ()
  "Insert character pair without sournding spaces"
  (interactive)
  (let (parens-require-spaces)
    (insert-pair)))


;#############################################################################
;#   Hooks
;############################################################################
(defun custom/python-mode-hook ()
  (auto-fill-mode 1)
  (eldoc-mode 1)
  (setq indent-tabs-mode t)
  (setq tab-width 2)
  (turn-on-eldoc-mode)
  (define-key python-mode-map "\"" 'electric-pair)
  (define-key python-mode-map "\'" 'electric-pair)
  (define-key python-mode-map "(" 'electric-pair)
  (define-key python-mode-map "[" 'electric-pair)
  (define-key python-mode-map "{" 'electric-pair)
  )

(add-hook 'python-mode-hook 'custom/python-mode-hook)
(add-hook 'python-mode-hook 'common-hooks/comment-hook)
(add-hook 'python-mode-hook 'common-hooks/show-prog-keywords)
(add-hook 'python-mode-hook 'flyspell-prog-mode)
(add-hook 'python-mode-hook 'common-hooks/newline-hook)

;;; emacs-rc-python.el ends here
