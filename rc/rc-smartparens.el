;; -*- coding: utf-8 -*-
;;
;; Filename: rc-smartparens.el
;; Created: Вт апр  2 14:06:09 2013 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'smartparens-config)

(smartparens-global-mode 1)

(show-smartparens-global-mode t)

(setq sp-navigate-reindent-after-up nil)

(sp-pair "*" "*")

(sp-local-pair 'html-mode "{" nil :actions '(:rem insert))
(sp-with-modes '(html-mode web-mode)
  (sp-local-pair "<" ">")
  (sp-local-pair "{%" "%}")
  (sp-local-pair "{{" "}}")
  (sp-local-tag "%" "{% " " %}")
  (sp-local-tag "{" "{{ " " }}")
  (sp-local-tag "<" "<_>" "</_>" :transform 'sp-match-sgml-tags))

(defadvice turn-on-smartparens-mode (after sp-in-jabber-chat activate)
  (when (eq major-mode 'jabber-chat-mode)
    (smartparens-mode t)))

(add-hook 'jabber-chat-mode (lambda () (smartparens-mode)))

(define-key sp-keymap (kbd "C-M-f") 'sp-forward-sexp)
(define-key sp-keymap (kbd "C-M-b") 'sp-backward-sexp)

(define-key sp-keymap (kbd "C-M-d") 'sp-down-sexp)
(define-key sp-keymap (kbd "C-M-a") 'sp-backward-down-sexp)
;; (define-key sp-keymap (kbd "C-S-a") 'sp-beginning-of-sexp)
(define-key sp-keymap (kbd "C-S-d") 'sp-end-of-sexp)

(define-key sp-keymap (kbd "C-M-e") 'sp-up-sexp)
(define-key emacs-lisp-mode-map (kbd ")") 'sp-up-sexp)
(define-key sp-keymap (kbd "C-M-u") 'sp-backward-up-sexp)

(provide 'rc-smartparens)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-smartparens.el ends here
