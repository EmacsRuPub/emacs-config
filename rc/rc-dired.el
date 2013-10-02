;;; emacs-rc-dired.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

;#############################################################################
;#   Load extension
;############################################################################

(require 'dired)
(require 'dired+)
(require 'wdired)
(require 'dired-x)
;; (require 'dash)
;; (require 'dired-details) ;; Make dired less verbose

(require 'defun-dired)


;#############################################################################
;#   Fonts
;############################################################################
;; TODO: check if this is not obsolete yet
(setq diredp-ignored-file-name 'green-face)
(setq diredp-other-priv 'white-face)
(setq diredp-rare-priv 'white-red-face)
(setq diredp-compressed-file-suffix 'darkyellow-face)
(setq dired-recursive-deletes 'top) ;; Allows recursive deletes

;; TODO: get rid of custom-set-faces below
(custom-set-faces '(diredp-display-msg
                    ((((type tty)) :foreground "blue")
                     (t :foreground "cornflower blue"))))
(custom-set-faces '(diredp-dir-heading
                    ((((type tty)) :foreground "yellow")
                     (t :foreground "goldenrod1"))))
(custom-set-faces '(diredp-executable-tag
                    ((((type tty)) :foreground "green")
                     (t :foreground "chartreuse"))))
(custom-set-faces '(diredp-dir-priv
                    ((((type tty)) :foreground "blue")
                     (t :foreground "SteelBlue3"))))
(custom-set-faces '(diredp-link-priv
                    ((((type tty)) :foreground "blue")
                     (t :foreground "LightSkyBlue4"))))
(custom-set-faces '(diredp-symlink
                    ((((type tty)) :foreground "blue")
                     (t :foreground "LightSkyBlue4"))))
(custom-set-faces '(diredp-read-priv
                    ((((type tty)) :foreground "yellow")
                     (t :foreground "yellow4"))))
(custom-set-faces '(diredp-write-priv
                    ((((type tty)) :foreground "red")
                     (t :foreground "IndianRed4"))))
(custom-set-faces '(diredp-exec-priv
                    ((((type tty)) :foreground "green")
                     (t :foreground "chartreuse"))))
(custom-set-faces '(diredp-file-name
                    ((((type tty)) :foreground "gray")
                     (t :foreground "gray60"))))
(custom-set-faces '(diredp-file-suffix
                    ((((type tty)) :foreground "gray")
                     (t :foreground "gray80"))))
(custom-set-faces '(diredp-compressed-file-suffix
                    ((((type tty)) :foreground "yellow")
                     (t :foreground "DarkOrange1"))))
(custom-set-faces '(diredp-inode+size
                    ((((type tty)) :foreground "yellow")
                     (t :foreground "gold3"))))


;#############################################################################
;#   Keybindings
;############################################################################
;; (global-set-key (kbd "C-c C-j") 'dired-jump)
(define-key dired-mode-map (kbd "C-a") 'dired-back-to-start-of-files)
(define-key dired-mode-map (vector 'remap 'beginning-of-buffer) 'dired-back-to-top)
(define-key dired-mode-map (vector 'remap 'smart-up) 'dired-back-to-top)
(define-key dired-mode-map (vector 'remap 'end-of-buffer) 'dired-jump-to-bottom)
(define-key dired-mode-map (vector 'remap 'smart-down) 'dired-jump-to-bottom)
(define-key dired-mode-map (kbd "C-x C-k") 'dired-do-delete) ;; Delete with C-x C-k to match file buffers and magit

(define-key dired-mode-map (kbd "C-o") 'open-in-external-app)


;#############################################################################
;#   Customizations
;############################################################################
(setq wdired-allow-to-change-permissions t)

(setq-default dired-details-hidden-string "--- ")
(dired-details-install)

;; Reload dired after making changes
(--each '(dired-do-rename
          dired-create-directory
          wdired-abort-changes)
        (eval `(defadvice ,it (after revert-buffer activate)
                 (revert-buffer))))
(eval-after-load "wdired"
  '(progn
     (define-key wdired-mode-map (kbd "C-a") 'dired-back-to-start-of-files)
     (define-key wdired-mode-map (vector 'remap 'beginning-of-buffer) 'dired-back-to-top)
     (define-key wdired-mode-map (vector 'remap 'end-of-buffer) 'dired-jump-to-bottom)))

;; ;; Additions to dired
;; ;; http://nflath.com/2009/07/dired/

(setq wdired-allow-to-change-permissions 'advanced)
(define-key dired-mode-map  (kbd "r") 'wdired-change-to-wdired-mode)

;;Updated file system on all buffer switches if in dired mode
(defadvice switch-to-buffer-other-window (after auto-refresh-dired (buffer &optional norecord) activate)
  (if (equal major-mode 'dired-mode)
      (revert-buffer)))
(defadvice switch-to-buffer (after auto-refresh-dired (buffer &optional norecord) activate)
  (if (equal major-mode 'dired-mode)
      (revert-buffer)))
(defadvice display-buffer (after auto-refresh-dired (buffer &optional not-this-window frame) activate)
  (if (equal major-mode 'dired-mode)
      (revert-buffer)))
(defadvice other-window (after auto-refresh-dired (arg &optional all-frame) activate)
  (if (equal major-mode 'dired-mode)
      (revert-buffer)))

(global-set-key (kbd "C-c x") 'direx:jump-to-directory)

(provide 'rc-dired)

;;; emacs-rc-dired.el ends here
