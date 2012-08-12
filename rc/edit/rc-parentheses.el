;;; rc-parentheses.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(autoload 'paredit-mode "paredit" "Minor mode for pseudo-structurally editing Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       (lambda () (paredit-mode +1)))
(add-hook 'lisp-mode-hook             (lambda () (paredit-mode +1)))
(add-hook 'lisp-interaction-mode-hook (lambda () (paredit-mode +1)))

(show-paren-mode t)

(defvar custom-programming-brackets-syntax-table
  (let ((table (make-syntax-table)))
    (modify-syntax-entry ?) "w" table)
    (modify-syntax-entry ?] "w" table)
    table))
;; TODO it fails to indent correctly. try to work it around by 'with'
;; when selecting region
;; (add-hook 'python-mode-hook (lambda () (set-syntax-table custom-programming-brackets-syntax-table)))
;; (add-hook 'php-mode-hook (lambda () (set-syntax-table custom-programming-brackets-syntax-table)))

(setq show-paren-style 'mixed)

(global-set-key (kbd "%") 'match-paren)

(provide 'rc-parentheses)

;;; rc-parentheses.el ends here
