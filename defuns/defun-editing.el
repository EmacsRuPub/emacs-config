;;; defun-editing.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

;#############################################################################
;#   Custom definitions
;############################################################################
;; current date and time.
(defun insert-current-date-time()
  "Insert the current date and time at point."
  (interactive "*")
  (insert (format-time-string "[%d.%m.%Y - %H:%M]" (current-time))))

;; untabify
(defun untabify-file ()
      (save-excursion
       (delete-trailing-whitespace)
       (untabify (point-min) (point-max))))

;:*========================
;:* VI-style matching parenthesis
;: From Eric Hendrickson edh @ med.umn.edu
;; BUG: switches to apostrophe sign instead of left paren when going to it
;; in strings like " '(delete-selection-mode t)"
(defun match-paren (arg)
  "Go to the matching parenthesis if on parenthesis otherwise insert %."
  (interactive "p")
  (cond ((looking-at "[([{]") (forward-sexp 1) (backward-char))
        ((looking-at "[])}]") (forward-char)
         (backward-sexp 1))
        (t (insert "%"))))

(defun match-paren-2 (arg)
  (interactive "p")
  (cond ((looking-at "\\s\(")
  (forward-list 1) (backward-char 1))
  ((looking-at "\\s\)")
  (forward-char 1) (backward-list 1))
  (t (self-insert-command (or arg1)))))

(defun custom/comment-or-uncomment-region (arg)
  (interactive "*P")
  (comment-normalize-vars)
  (if
      (and (not mark-active)
           (save-excursion (beginning-of-line) (not (looking-at "\\s-*$"))))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg)))

(defun uniq ()
  "Trying to leave only unique strings from selection"
  (interactive)
  (let ((beg (point))
        (end (mark))
        (hash (make-hash-table :test 'equal))
        )
    (if (not end)
        (error "Please, mark text to uniquify")
      (save-excursion
        (narrow-to-region beg end)
        (goto-char (point-min))
        ;; store strings in hash
        (while (not (eobp))
          (beginning-of-line)
          (puthash (buffer-substring (point) (point-at-eol)) 0 hash)
          (forward-line 1))
        (delete-region beg end)
        ;; insert strings from hash
        (maphash (lambda (key val)
                   (insert key "\n")
                   (message "%s" key))
                 hash)
        (widen)))))

;; (defun get-file-line ()
;;   "show (and set kill-ring) current file and line"
;;   (interactive)
;;   (unless (buffer-file-name)
;;     (error "No file for buffer %s" (buffer-name)))
;;   (let ((msg (format "%s:%d"
;;                      (file-truename (buffer-file-name))
;;                      (line-number-at-pos))))
;;     (kill-new msg)
;;     (message msg)))

(defun quote-string-with-period-and-nextline ()
  "Wraps current line in quotes, adds period and goes one down"
  (interactive)
  (beginning-of-line)
  (insert "\'")
  (end-of-line)
  (insert "\'\,")
  (next-line))

(defun double-quote-string-with-period-and-nextline ()
  "Wraps current line in quotes, adds period and goes one down"
  (interactive)
  (beginning-of-line)
  (insert "\"")
  (end-of-line)
  (insert "\"\,")
  (next-line))

;;; defun-editing.el ends here
