;; -*- coding: utf-8 -*-
;;
;; Filename: rc-completion.el
;; Created:  Sun May 4 23:57:55 2014 +0400
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package auto-complete
  :commands auto-complete
  :init
  (progn
    (use-package auto-complete-config)
    (use-package ac-helm))
  :config
  (progn
    (ac-config-default)
    (global-auto-complete-mode t)
    (diminish 'auto-complete-mode " α")
    (setq ac-auto-start nil)
    (setq ac-quick-help-delay 0.5)
    (setq ac-fuzzy-enable t)
    (add-to-list 'ac-modes 'slime-repl-mode)
    (add-hook 'slime-mode-hook 'set-up-slime-ac)
    (add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
    (add-hook 'auto-complete-mode-hook 'ac-common-setup)
    (define-key ac-complete-mode-map [next] 'custom/ac-page-next)
    (define-key ac-complete-mode-map [prior] 'custom/ac-page-previous)
    (define-key ac-complete-mode-map (kbd "C-s") 'ac-isearch)
    (global-set-key (kbd "C-<tab>") 'auto-complete)
    ;; TODO: bind lambda (setq ac-comphist nil) for emeregency completion history purge
    ))

(use-package yasnippet
  :init
  (use-package helm-c-yasnippet)
  :config
  (progn
    ;; unset both to remove ALL translations
    (define-key yas-minor-mode-map [(tab)] nil) ;FIXME: try using unbind-key
    (define-key yas-minor-mode-map (kbd "TAB") nil)
    (bind-key "C-M-<return>" 'helm-yas-complete)
    (setq yas/next-field-key '("<backtab>" "<S-tab>"))
    (setq yas/prev-field-key '("<C-tab>"))
    (setq yas-snippet-dirs nil)
    (setq helm-yas-space-match-any-greedy t)
    (push custom/yasnippet-dir yas-snippet-dirs)
    (push custom/yasnippet-private-dir yas-snippet-dirs)
    (yas-global-mode 1)
    (setq yas-prompt-functions
          '(yas-completing-prompt
            yas-x-prompt
            yas-no-prompt))
    ;; Wrap around region
    (setq yas/wrap-around-region t)
    (add-hook 'after-save-hook 'custom/update-yasnippets-on-save)
    ;; Jump to end of snippet definition
    (define-key yas/keymap (kbd "<return>") 'yas/exit-all-snippets) ;FIXME: try using bind-key
    (define-key yas/keymap (kbd "C-e") 'custom/yas-goto-end-of-active-field)
    (define-key yas/keymap (kbd "C-a") 'custom/yas-goto-start-of-active-field)
    ))

(defhydra hydra-yasnippet (:color teal)
  "
_c_reate auto snippet
_e_xpand auto snippet
_p_ersist auto snippet
_v_isit snippets file
_i_nsert snippet
"
  ("c" aya-create)
  ("e" aya-expand)
  ("p" aya-persist-snippet)
  ("v" yas-visit-snippet-file)
  ("i" yas-insert-snippet)
  ("q" nil))
(global-set-key (kbd "<f5>") 'hydra-yasnippet/body)

(global-set-key (kbd "C-S-<iso-lefttab>") 'hippie-expand)

(provide 'rc-completion)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-completion.el ends here
