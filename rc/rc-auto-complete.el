;;; rc-auto-complete.el ---

;; Copyright (C) 2012 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:

(require 'auto-complete)
(require 'auto-complete-config)
(require 'auto-complete-extension)
(require 'auto-complete-emacs-lisp)
(require 'auto-complete-latex)
(require 'auto-complete-nxml)
(require 'auto-complete-yasnippet)
(require 'go-autocomplete)

(require 'defun-autocomplete)

(ac-config-default)
(global-auto-complete-mode t)

;; add lisp autocomplete-support
(require 'ac-slime)

(setq ac-auto-start nil)

(add-hook 'slime-mode-hook 'set-up-slime-ac)
(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
(eval-after-load "auto-complete" '(add-to-list 'ac-modes 'slime-repl-mode))

(add-hook 'nrepl-mode-hook 'set-auto-complete-as-completion-at-point-function)
(add-hook 'nrepl-interaction-mode-hook 'set-auto-complete-as-completion-at-point-function)

(global-set-key (kbd "C-<tab>") 'auto-complete)

(provide 'rc-auto-complete)

;;; rc-auto-complete.el ends here
