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

(defun skip-to-next-blank-line ()
  (interactive)
  (let ((inhibit-changing-match-data t))
    (forward-char 1)
    (unless (search-forward-regexp "^\\s *$" nil t)
      (forward-char -1))))

(defun skip-to-previous-blank-line ()
  (interactive)
  (let ((inhibit-changing-match-data t))
    (forward-char -1)
    (unless (search-backward-regexp "^\\s *$" nil t)
      (forward-char 1))))

(provide 'defun-editing)

;;; defun-editing.el ends here
