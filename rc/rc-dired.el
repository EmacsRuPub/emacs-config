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
(require 'dired-toggle-sudo)

;; C-a is nicer in dired if it moves back to start of files
(defun dired-back-to-start-of-files ()
  (interactive)
  (backward-char (- (current-column) 2)))

;; M-up is nicer in dired if it moves to the third line - straight to the ".."
(defun dired-back-to-top ()
  (interactive)
  (beginning-of-buffer)
  (next-line 2)
  (dired-back-to-start-of-files))

;; M-down is nicer in dired if it moves to the last file
(defun dired-jump-to-bottom ()
  (interactive)
  (end-of-buffer)
  (next-line -1)
  (dired-back-to-start-of-files))

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

(defun open-in-external-app ()
  "Open the current file or dired marked files in external app.
Works in Microsoft Windows, Mac OS X, Linux."
  (interactive)
  (let (doIt
         (myFileList
          (cond
           ((string-equal major-mode "dired-mode") (dired-get-marked-files))
           (t (list (buffer-file-name))))))
    (setq doIt (if (<= (length myFileList) 5)
                   t
                 (y-or-n-p "Open more than 5 files?")))
    (when doIt
      (cond
       ((string-equal system-type "windows-nt")
        (mapc (lambda (fPath) (w32-shell-execute "open" (replace-regexp-in-string "/" "\\" fPath t t))) myFileList))
       ((string-equal system-type "darwin")
        (mapc (lambda (fPath) (let ((process-connection-type nil)) (start-process "" nil "open" fPath)))  myFileList))
       ((string-equal system-type "gnu/linux")
        (mapc (lambda (fPath) (let ((process-connection-type nil)) (start-process "" nil "xdg-open" fPath))) myFileList))))))

(defvar *directory-separator* '?/)

(define-obsolete-function-alias 'make-local-hook 'ignore "21.1")
(define-obsolete-variable-alias 'directory-sep-char '*directory-separator*)

;; Updated file system on all buffer switches if in dired mode
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


;; Additions to dired http://nflath.com/2009/07/dired/

(setq wdired-allow-to-change-permissions 'advanced)
(define-key dired-mode-map  (kbd "r") 'wdired-change-to-wdired-mode)

(eval-after-load 'tramp
  '(progn
     ;; Allow to use: /sudo:user@host:/path/to/file
     (add-to-list 'tramp-default-proxies-alist
                  '(".*" "\\`.+\\'" "/ssh:%h:"))))

(global-set-key (kbd "C-c x") 'direx:jump-to-directory)
(define-key dired-mode-map (kbd "C-c C-s") 'dired-toggle-sudo)

(provide 'rc-dired)

;;; emacs-rc-dired.el ends here
