;;; rc-search.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(require 'highlight-symbol)
(require 're-builder)
(require 'ack-and-a-half)
(require 'fuzzy)
(require 'ace-jump-mode)
(require 'sr-speedbar)

(require 'defun-search)

(when (eq system-type 'darwin) ;; mac specific settings
  (setq locate-command "mdfind"))

(turn-on-fuzzy-isearch)

;; Create shorter aliases
(defalias 'ack 'ack-and-a-half)
(defalias 'ack-same 'ack-and-a-half-same)
(defalias 'ack-find-file 'ack-and-a-half-find-file)
(defalias 'ack-find-file-same 'ack-and-a-half-find-file-same)

(setq speedbar-use-images nil)
(setq sr-speedbar-width-x 20)
(setq sr-speedbar-width-console 20)
(setq sr-speedbar-skip-other-window-p t)

;#############################################################################
;#   Keybindings
;############################################################################
(define-prefix-command 'custom-search-keymap)
(define-key custom-search-keymap (kbd "m") 'multi-occur-in-matching-buffers)
(define-key custom-search-keymap (kbd "o") 'occur)
(define-key custom-search-keymap (kbd "r") 're-builder)
(define-key custom-search-keymap (kbd "l") 'locate)
(define-key custom-search-keymap (kbd "f") 'find-lisp-find-dired)
(define-key custom-search-keymap (kbd "s") 'find-lisp-find-dired-subdirectories)
(define-key custom-search-keymap (kbd "g") 'ack)
(define-key custom-search-keymap (kbd "k") 'ack-same)
(define-key custom-search-keymap (kbd "i") 'ioccur)
(define-key custom-search-keymap (kbd "h") 'highlight-symbol-at-point)
(define-key custom-search-keymap (kbd "<down>") 'highlight-symbol-next)
(define-key custom-search-keymap (kbd "<up>") 'highlight-symbol-prev)
(define-key custom-search-keymap (kbd "q") 'ack-find-file)
(define-key custom-search-keymap (kbd "s") 'ido-goto-symbol)
(define-key custom-search-keymap (kbd "8") 'ace-jump-char-mode)
(define-key custom-search-keymap (kbd "9") 'ace-jump-word-mode)
(define-key custom-search-keymap (kbd "n") 'sr-speedbar-toggle)
(define-key custom-search-keymap (kbd "C-n") 'sr-speedbar-select-window)
(global-set-key [(f3)] 'custom-search-keymap)

(global-unset-key (kbd "C-s"))
(global-unset-key (kbd "C-r"))
(global-unset-key (kbd "C-M-s"))
(global-unset-key (kbd "C-M-r"))
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)

(define-key isearch-mode-map (kbd "C-o") 'isearch-occur)

(global-set-key (kbd "C-c s a") (lambda ()
                                  (interactive)
                                  (ad-enable-advice 'ack-and-a-half-arguments-from-options 'after 'search-text-files)
                                  (ad-enable-advice 'ack-and-a-half-list-files 'around 'list-text-files)
                                  (ad-activate 'ack-and-a-half-arguments-from-options)
                                  (ad-activate 'ack-and-a-half-list-files)))
(global-set-key (kbd "C-c s d") (lambda ()
                                  (interactive)
                                  (ad-disable-advice 'ack-and-a-half-arguments-from-options 'after 'search-text-files)
                                  (ad-disable-advice 'ack-and-a-half-list-files 'around 'list-text-files)
                                  (ad-activate 'ack-and-a-half-arguments-from-options)
                                  (ad-activate 'ack-and-a-half-list-files)))

(global-set-key [(control f9)] (lambda () (interactive) (magit-status default-directory)))

(provide 'rc-search)

;;; rc-search.el ends here
