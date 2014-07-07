;; -*- coding: utf-8 -*-
;;
;; Filename: rc-completion.el
;; Created: Вс май  4 23:17:16 2014 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(autoload 'auto-complete "auto-complete" "Autocompletion for Emacs." t)
(autoload 'yas-global-mode "yasnippet" "Yasnippet" t)

(eval-after-load "auto-complete"
  '(progn
     (require 'auto-complete-config)
     (require 'auto-complete-extension)
     (require 'auto-complete-emacs-lisp)
     (require 'auto-complete-latex)
     (require 'auto-complete-nxml)
     (require 'auto-complete-yasnippet)
     (require 'go-autocomplete)
     (require 'ac-slime) ;; add lisp autocomplete-support

     (ac-config-default)
     (global-auto-complete-mode t)
     (setq ac-auto-start nil)
     (add-to-list 'ac-modes 'slime-repl-mode)

     (add-hook 'slime-mode-hook 'set-up-slime-ac)
     (add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
     (add-hook 'nrepl-mode-hook 'set-auto-complete-as-completion-at-point-function)
     (add-hook 'nrepl-interaction-mode-hook 'set-auto-complete-as-completion-at-point-function)

     (global-set-key (kbd "C-<tab>") 'auto-complete)
     ))

(eval-after-load "yasnippet"
  '(progn
     ;; unset both to remove ALL translations
     (define-key yas-minor-mode-map [(tab)] nil)
     (define-key yas-minor-mode-map (kbd "TAB") nil)
     (setq yas/next-field-key '("<backtab>" "<S-tab>"))
     (setq yas/prev-field-key '("<C-tab>"))
     (setq yas-snippet-dirs nil)
     (push custom/yasnippet-dir yas-snippet-dirs)
     (push custom/yasnippet-private-dir yas-snippet-dirs)
     (yas--initialize)

     (setq yas/prompt-functions
           '(yas/ido-prompt
             yas/completing-prompt
             yas/x-prompt
             yas/no-prompt))
     ;; Wrap around region
     (setq yas/wrap-around-region t)

     (add-hook 'after-save-hook 'update-yasnippets-on-save)

     ;; Jump to end of snippet definition
     (define-key yas/keymap (kbd "<return>") 'yas/exit-all-snippets)
     (define-key yas/keymap (kbd "C-e") 'yas/goto-end-of-active-field)
     (define-key yas/keymap (kbd "C-a") 'yas/goto-start-of-active-field)
     (global-set-key (kbd "C-M-<return>") 'yas-ido-expand)
     ))

(setq-default abbrev-mode t) ;; ensure abbrev mode is always on
(setq save-abbrevs 'silently)      ;; do not bug me about saving my abbreviations

(global-set-key (kbd "C-S-<iso-lefttab>") 'dabbrev-expand)
(global-set-key (kbd "C-c C-y C-v") 'yas-visit-snippet-file)
(global-set-key (kbd "C-c C-y C-n") 'yas-insert-snippet)

(provide 'rc-completion)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-completion.el ends here
