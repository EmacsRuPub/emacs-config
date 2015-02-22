;; -*- coding: utf-8 -*-
;;
;; Filename: rc-dired.el
;; Created:  Fri May 24 22:41:54 2013 +0400
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'dired)
(require 'dired+)
(require 'dired-x)
(require 'dired-toggle-sudo)

;; TODO: check if this is not obsolete yet
(setq diredp-ignored-file-name 'green-face)
(setq diredp-other-priv 'white-face)
(setq diredp-rare-priv 'white-red-face)
(setq diredp-compressed-file-suffix 'darkyellow-face)
(setq dired-recursive-deletes 'top) ;; Allows recursive deletes
(setq dired-dwim-target t)
(setq dired-listing-switches "-lah1v --group-directories-first")

;; (global-set-key (kbd "C-c C-j") 'dired-jump)
(define-key dired-mode-map (kbd "C-a") 'dired-back-to-start-of-files)
(define-key dired-mode-map (vector 'remap 'beginning-of-buffer) 'dired-back-to-top)
(define-key dired-mode-map (vector 'remap 'smart-up) 'dired-back-to-top)
(define-key dired-mode-map (vector 'remap 'end-of-buffer) 'dired-jump-to-bottom)
(define-key dired-mode-map (vector 'remap 'smart-down) 'dired-jump-to-bottom)
(define-key dired-mode-map (kbd "C-x C-k") 'dired-do-delete) ;; Delete with C-x C-k to match file buffers and magit
(define-key dired-mode-map (kbd "`") 'dired-open-term)

;; Reload dired after making changes
(--each '(dired-do-rename
          dired-create-directory
          wdired-abort-changes)
        (eval `(defadvice ,it (after revert-buffer activate)
                 (revert-buffer))))

(use-package wdired
  :defer t
  :config
  (progn
    (setq wdired-allow-to-change-permissions 'advanced)
    (setq wdired-allow-to-change-permissions t)
    (bind-key "C-a" 'dired-back-to-start-of-files wdired-mode-map)
    (bind-key (vector 'remap 'beginning-of-buffer) 'dired-back-to-top wdired-mode-map)
    (bind-key (vector 'remap 'end-of-buffer) 'dired-jump-to-bottom wdired-mode-map)
    (bind-key "r" 'wdired-change-to-wdired-mode dired-mode-map)
    ))

(global-set-key (kbd "C-c x") 'direx:jump-to-directory)
(define-key dired-mode-map (kbd "C-c C-s") 'dired-toggle-sudo)
(define-key dired-mode-map (kbd "C-c C-m") 'custom/get-file-md5)
(define-key dired-mode-map (kbd "!") 'sudo-dired)

(provide 'rc-dired)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-dired.el ends here
