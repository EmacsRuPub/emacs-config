;; -*- coding: utf-8 -*-
;;
;; Filename: custom-keymaps.el
;; Created: Ср июн  4 13:49:18 2014 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define-prefix-command 'custom-search-keymap)
(global-set-key (kbd "M-s") 'custom-search-keymap)

(global-unset-key (kbd "C-z"))
(define-prefix-command 'custom-edit-keymap)
(global-set-key (kbd "C-z") 'custom-edit-keymap)

(global-unset-key (kbd "C-q")) ;; was 'quoted-insert
(define-prefix-command 'custom-clients-keymap)
(global-set-key (kbd "C-q") 'custom-clients-keymap)

(define-prefix-command 'custom-mc-keymap)
(global-set-key (kbd "<f5>") 'custom-mc-keymap)

(provide 'custom-keymaps)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; custom-keymaps.el ends here
