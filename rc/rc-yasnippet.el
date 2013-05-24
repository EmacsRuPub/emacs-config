;;; rc-yasnippet.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(require 'yasnippet) ;; not yasnippet-bundle

(require 'defun-yasnippet)

(setq yas/next-field-key '("<backtab>" "<S-tab>"))
(setq yas/prev-field-key '("<C-tab>"))
(setq yas/snippet-dirs custom/yasnippet-dir)
(yas/initialize)
(yas/load-directory custom/yasnippet-dir)

(yasnippet-unbind-trigger-key)

(setq yas/prompt-functions '(
                             yas/ido-prompt
                             yas/completing-prompt
                             yas/x-prompt
                             yas/no-prompt))

;; Wrap around region
(setq yas/wrap-around-region t)

;; hook for automatic reloading of changed snippets
(defun update-yasnippets-on-save ()
  (when (string-match "/resources/yasnippet" buffer-file-name)
    (yas/load-directory custom/yasnippet-dir)))
(add-hook 'after-save-hook 'update-yasnippets-on-save)

;; Jump to end of snippet definition
(define-key yas/keymap (kbd "<return>") 'yas/exit-all-snippets)
(define-key yas/keymap (kbd "C-e") 'yas/goto-end-of-active-field)
(define-key yas/keymap (kbd "C-a") 'yas/goto-start-of-active-field)
;; (key-chord-define-global "p=" 'yas-safer-expand)
(key-chord-define-global "p=" 'yas/expand)
;; (define-key iy-map (kbd "M-/") 'yas-ido-insert-snippets)

(provide 'rc-yasnippet)

;;; rc-yasnippet.el ends here
