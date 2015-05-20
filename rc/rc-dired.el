;; -*- coding: utf-8 -*-
;;
;; Filename: rc-dired.el
;; Created:  Fri May 24 22:41:54 2013 +0400
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package dired
  :config
  (setq dired-recursive-deletes 'top) ;; Allows recursive deletes
  (setq dired-dwim-target t)
  (setq dired-listing-switches "-lah1v --group-directories-first")
  (global-set-key (kbd "C-c x") 'direx:jump-to-directory)
  ;; (global-set-key (kbd "C-c C-j") 'dired-jump)
  (bind-key "C-c C-s" 'dired-toggle-sudo dired-mode-map)
  (bind-key "C-c C-m" 'custom/get-file-md5 dired-mode-map)
  (bind-key "!" 'custom/sudo-dired dired-mode-map)
  (bind-key "C-a" 'custom/dired-back-to-start-of-files dired-mode-map)
  (bind-key "C-x C-k" 'dired-do-delete dired-mode-map) ;; Delete with C-x C-k to match file buffers and magit
  (bind-key "`" 'custom/dired-open-term dired-mode-map)
  (define-key dired-mode-map (vector 'remap 'beginning-of-buffer) 'custom/dired-back-to-top)
  (define-key dired-mode-map (vector 'remap 'smart-up) 'custom/dired-back-to-top)
  (define-key dired-mode-map (vector 'remap 'end-of-buffer) 'custom/dired-jump-to-bottom)
  (define-key dired-mode-map (vector 'remap 'smart-down) 'custom/dired-jump-to-bottom))

(use-package dired+
  :config
  ;; TODO: check if this is not obsolete yet
  (setq diredp-ignored-file-name 'green-face)
  (setq diredp-other-priv 'white-face)
  (setq diredp-rare-priv 'white-red-face)
  (setq diredp-compressed-file-suffix 'darkyellow-face))

(use-package wdired
  :defer t
  :config
  (progn
    (setq wdired-allow-to-change-permissions 'advanced)
    (setq wdired-allow-to-change-permissions t)
    (bind-key "C-a" 'custom/dired-back-to-start-of-files wdired-mode-map)
    (bind-key (vector 'remap 'beginning-of-buffer) 'custom/dired-back-to-top wdired-mode-map)
    (bind-key (vector 'remap 'end-of-buffer) 'custom/dired-jump-to-bottom wdired-mode-map)
    (bind-key "r" 'wdired-change-to-wdired-mode dired-mode-map)
    ))

(use-package dired-x)
(use-package dired-toggle-sudo)

;; Reload dired after making changes
(--each '(dired-do-rename
          dired-create-directory
          wdired-abort-changes)
        (eval `(defadvice ,it (after revert-buffer activate)
                 (revert-buffer))))

(provide 'rc-dired)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-dired.el ends here
