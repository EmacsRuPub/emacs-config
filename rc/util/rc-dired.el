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

(require 'dired+)


;#############################################################################
;#   Custom definitions
;############################################################################
(defun custom/dired-sort ()
  "Sort dired listings with directories first."
  (save-excursion
    (let (buffer-read-only)
      (forward-line 2) ;; beyond dir. header 
      (sort-regexp-fields t "^.*$" "[ ]*." (point) (point-max)))
    (set-buffer-modified-p nil)))

(defadvice dired-readin
  (after dired-after-updating-hook first () activate)
  "Sort dired listings with directories first before adding marks."
  (custom/dired-sort))


;#############################################################################
;#   Customizations
;############################################################################
(setq wdired-allow-to-change-permissions t)


;#############################################################################
;#   Fonts
;############################################################################
;; TODO: check if this is not obsolete yet
(setq diredp-ignored-file-name 'green-face)
(setq diredp-exec-priv 'darkred-face)
(setq diredp-other-priv 'white-face)
(setq diredp-no-priv 'darkmagenta-face)
(setq diredp-rare-priv 'white-red-face)
(setq diredp-compressed-file-suffix 'darkyellow-face)
;; (setq diredp-file-name 'darkred-face)
;; (setq diredp-file-suffix 'magenta-face)
;; (setq diredp-write-priv 'darkcyan-face)
;; (setq diredp-read-priv 'darkyellow-face)
;; (setq diredp-link-priv 'lightblue-face)
;; (setq diredp-symlink 'darkcyan-face)
;; (setq diredp-dir-priv 'beautiful-blue-face)

;; TODO: get rid of custom-set-faces below
(custom-set-faces '(diredp-display-msg
                    ((((type tty)) :foreground "blue")
                     (t :foreground "cornflower blue"))))
;; (custom-set-faces '(diredp-date-time
;;                     ((((type tty)) :foreground "yellow")
;;                      (t :foreground "goldenrod1"))))
;; (custom-set-faces '(diredp-dir-heading
;;                     ((((type tty)) :background "yellow" :foreground "blue")
;;                      (t :background "Pink" :foreground "DarkOrchid1"))))
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
;; (custom-set-faces '(diredp-exec-priv
;;                     ((((type tty)) :foreground "green")
;;                      (t :foreground "chartreuse"))))
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

;; TODO: check if properties below are useful being fontified
;; diredp-no-priv, diredp-other-priv, diredp-rare-priv
;; diredp-deletion, diredp-deletion-file-name, diredp-dir-heading, diredp-display-msg
;; diredp-executable-tag, diredp-flag-mark, diredp-flag-mark-line, diredp-get-file-or-dir-name, diredp-ignored-file-name


;#############################################################################
;#   Keybindings
;############################################################################
(global-set-key (kbd "C-c C-j") 'dired-jump)

;;; emacs-rc-dired.el ends here
