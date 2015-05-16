;; -*- coding: utf-8 -*-
;;
;; Filename: custom-dired.el
;; Created: Вс июн  1 21:02:47 2014 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define-namespace custom/

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

(defun dired-sort ()
  "Sort dired listings with directories first."
  (save-excursion
    (let (buffer-read-only)
      (forward-line 2) ;; beyond dir. header
      (sort-regexp-fields t "^.*$" "[ ]*." (point) (point-max)))
    (set-buffer-modified-p nil)))

(defadvice dired-readin
    (after dired-after-updating-hook first () activate)
  "Sort dired listings with directories first before adding marks."
  (dired-sort))

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

(defun dired-open-term ()
  "Open an `ansi-term' that corresponds to current directory."
  (interactive)
  (let ((current-dir (dired-current-directory)))
    (term-send-string
     (custom/terminal)
     (if (file-remote-p current-dir)
         (let ((v (tramp-dissect-file-name current-dir t)))
           (format "ssh %s@%s\n"
                   (aref v 1) (aref v 2)))
       (format "cd '%s'\n" current-dir)))))

(defun sudo-dired ()
  (interactive)
  (require 'tramp)
  (let ((dir (expand-file-name default-directory)))
    (if (string-match "^/sudo:" dir)
        (user-error "Already in sudo")
      (dired (concat "/sudo::" dir)))))

)

(provide 'custom-dired)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; custom-dired.el ends here
