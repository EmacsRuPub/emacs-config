;;; rc-search.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(autoload 'wgrep-ag-setup "wgrep-ag")

(require 're-builder)
(require 'fuzzy)
(require 'ace-jump-mode)
(require 'ag)
(require 'wgrep-ag)

(defadvice ack-and-a-half-arguments-from-options (after search-text-files disable)
  (let ((current-arguments ad-return-value))
    (push "--text" current-arguments)
    (setf ad-return-value current-arguments)))

(defadvice ack-and-a-half-list-files (around list-text-files disable)
  (let ((arguments (ad-get-args 1)))
    (push "--text" arguments)
    (ad-set-args 1 arguments)
    (setq ad-return-value ad-do-it)))

(defun occur-and-switch (search)
  (interactive "sSearch for: ")
  (occur (regexp-quote search))
  (switch-to-buffer-other-window "*Occur*"))

(defun isearch-occur ()
  (interactive)
  (let ((case-fold-search isearch-case-fold-search))
    (occur-and-switch (if isearch-regexp isearch-string
             (regexp-quote isearch-string)))))

(defadvice occur-mode-goto-occurrence (after close-occur activate)
  (delete-other-windows))

(turn-on-fuzzy-isearch)

(setq speedbar-use-images nil)
(setq sr-speedbar-width-x 20)
(setq sr-speedbar-width-console 20)
(setq sr-speedbar-skip-other-window-p t)

(setq ag-highlight-search t)

(add-hook 'ag-mode-hook 'wgrep-ag-setup)

;#############################################################################
;#   Keybindings
;############################################################################
(define-prefix-command 'custom-search-keymap)
(define-key custom-search-keymap (kbd "m") 'multi-occur-in-matching-buffers)
(define-key custom-search-keymap (kbd "o") 'helm-occur)
(define-key custom-search-keymap (kbd "r") 'rgrep)
(define-key custom-search-keymap (kbd "l") 'locate)
(define-key custom-search-keymap (kbd "f") 'find-lisp-find-dired)
(define-key custom-search-keymap (kbd "s") 'find-lisp-find-dired-subdirectories)
(define-key custom-search-keymap (kbd "g") 'projectile-ag)
(define-key custom-search-keymap (kbd "p") 'ag-regexp-project-at-point)
(define-key custom-search-keymap (kbd "i") 'helm-swoop) ;; was ioccur
(define-key custom-search-keymap (kbd "b") 'helm-swoop-back-to-last-point)
(define-key custom-search-keymap (kbd "q") 'projectile-find-file)
(define-key custom-search-keymap (kbd "s") 'ido-goto-symbol)
(define-key custom-search-keymap (kbd "8") 'ace-jump-char-mode)
(define-key custom-search-keymap (kbd "9") 'ace-jump-word-mode)
(define-key custom-search-keymap (kbd "n") 'sr-speedbar-toggle)
(define-key custom-search-keymap (kbd "C-n") 'sr-speedbar-select-window)
(define-key custom-search-keymap (kbd "h") 'helm-mini)
(global-set-key (kbd "M-s") 'custom-search-keymap)

(global-unset-key (kbd "C-s"))
(global-unset-key (kbd "C-r"))
(global-unset-key (kbd "C-M-s"))
(global-unset-key (kbd "C-M-r"))
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)

(define-key isearch-mode-map (kbd "C-o") 'isearch-occur)
(define-key ag-mode-map (kbd "C-x C-s") 'wgrep-save-all-buffers)
(define-key grep-mode-map (kbd "C-x C-s") 'wgrep-save-all-buffers)

(global-set-key [(control f9)] (lambda () (interactive) (magit-status default-directory)))


(provide 'rc-search)

;;; rc-search.el ends here
