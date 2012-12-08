;;; defun-joinlines.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

;#############################################################################
;#   Join lines definitions
;############################################################################
(defun circle-processing (arg function)
  "Circle call 'function' 'arg' times, default - once"
  (interactive)
  (progn
    (if arg
        (setq times arg)
      (setq times 1))
    (let (counter)
      (dotimes (counter times)
        (apply function nil)))))

(defun join-next-line-space ()
  "Joins next line with current with a space between them"
  (interactive)
  (progn
    (end-of-line)
    (next-line)
    (join-line)))

(defun join-next-line ()
  "Joins next line with current without space between them"
  (interactive)
  (progn
    (join-next-line-space)
    (delete-char 1)))

(defun join-next-line-semicolon ()
  "Joins next line with current with semicolon between them"
  (interactive)
  (progn
    (join-next-line)
    (insert ";")))

(defun join-next-line-space-n (&optional arg)
  "Joins number of next lines with current with a space between them"
  (interactive "P")
  (circle-processing arg 'join-next-line-space))

(defun join-next-line-n (&optional arg)
  "Joins number of  next lines with current without space between them"
  (interactive "P")
  (circle-processing arg 'join-next-line))

(defun join-next-line-semicolon-n (&optional arg)
  "Joins number of  next lines with current with semicolon between them"
  (interactive "P")
  (circle-processing arg 'join-next-line-semicolon))

;; (defun string-join (joiner strings)
;;   (string-join-accum joiner strings ""))

;; (defun string-join-accum (joiner strings accum)
;;   (cond ((not strings) accum)
;;         ((not (cdr strings)) (concat accum (car strings)))
;;         (t (string-join-accum joiner (cdr strings)
;;                               (concat accum (car strings) joiner)))))

(provide 'defun-joinlines)

;;; defun-joinlines.el ends here
