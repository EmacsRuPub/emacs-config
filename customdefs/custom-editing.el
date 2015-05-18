;; -*- coding: utf-8 -*-
;;
;; Filename: custom-editing.el
;; Created: Чт июн 19 23:30:55 2014 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define-namespace custom/

;; current date and time.
(defun insert-current-date-time()
  "Insert the current date and time at point."
  (interactive "*")
  (insert (format-time-string "[%d.%m.%Y - %H:%M]" (current-time))))

(defun comment-or-uncomment-region (arg)
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not mark-active)
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

(defun smarter-move-beginning-of-line (arg)
  "Move point back to indentation of beginning of line.

Move point to the first non-whitespace character on this line.
If point is already there, move to the beginning of the line.
Effectively toggle between the first non-whitespace character and
the beginning of the line.

If ARG is not nil or 1, move forward ARG - 1 lines first.  If
point reaches the beginning or end of the buffer, stop there."
  (interactive "^p")
  (setq arg (or arg 1))
  ;; Move lines first
  (when (/= arg 1)
    (let ((line-move-visual nil))
      (forward-line (1- arg))))
  (let ((orig-point (point)))
    (back-to-indentation)
    (when (= orig-point (point))
      (move-beginning-of-line 1))))

(defun copy-file-name-to-clipboard ()
  "Copy the current buffer file name to the clipboard."
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (kill-new filename)
      (message "Copied buffer file name '%s' to the clipboard." filename))))

(defun rename-file-and-buffer ()
  "Rename the current buffer and file it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (message "Buffer is not visiting a file!")
      (let ((new-name (read-file-name "New name: " filename)))
        (cond
         ((vc-backend filename) (vc-rename-file filename new-name))
         (t
          (rename-file filename new-name t)
          (set-visited-file-name new-name t t)))))))

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

(defadvice whole-line-or-region-kill-region
    (before whole-line-or-region-kill-read-only-ok activate)
  (interactive "p")
  (unless kill-read-only-ok (barf-if-buffer-read-only)))

;; When popping the mark, continue popping until the cursor actually moves
;; Also, if the last command was a copy - skip past all the expand-region cruft.
(defadvice pop-to-mark-command (around ensure-new-position activate)
  (let ((p (point)))
    (when (eq last-command 'save-region-or-current-line)
      ad-do-it
      ad-do-it
      ad-do-it)
    (dotimes (i 10)
      (when (= p (point)) ad-do-it))))

;; see http://emacs-fu.blogspot.ru/2010/01/duplicating-lines-and-commenting-them.html
(defun duplicate-line (arg)
  "comment line at point; if COMMENTFIRST is non-nil, comment the original"
  (interactive "P")
  (beginning-of-line)
  (push-mark)
  (end-of-line)
  (let ((str (buffer-substring (region-beginning) (region-end))))
    (when arg
      (comment-region (region-beginning) (region-end)))
    (insert-string
     (concat (if (= 0 (forward-line 1)) "" "\n") str "\n"))
    (forward-line -1)))

(defun eval-and-replace ()
  "Replace the preceding sexp with its value."
  (interactive)
  (backward-kill-sexp)
  (condition-case nil
      (prin1 (eval (read (current-kill 0)))
             (current-buffer))
    (error (message "Invalid expression")
           (insert (current-kill 0)))))

(require 'helm-utils)
(defvar helm-source-portage-files
  `((name . "Portage files")
    (candidates . ,(helm-walk-directory "/etc/portage" :path 'full))
    (action . (lambda (candidate)
                (helm-find-file-as-root candidate)))))

(defun cite-region (arg)
  (clipboard-kill-ring-save (region-beginning) (region-end))
  (with-temp-buffer
    (let ((comment-start "> "))
      (yank)
      (comment-region (point-min) (point-max))
      (when (> arg 1)
        (beginning-of-buffer)
        (insert "\n"))
      (clipboard-kill-region (point-min) (point-max)))))

(defun strip-prefix (prefix lines)
  (s-join "\n"
          (mapcar (lambda (s) (s-chop-prefix prefix s))
                  (s-lines lines))))

)

(provide 'custom-editing)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; custom-editing.el ends here
