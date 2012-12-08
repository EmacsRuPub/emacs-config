;;; defun-scheme.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

;#############################################################################
;#   Custom definitions
;############################################################################
(defun insert-balanced-comments (arg)
  "Insert a set of balanced comments around the s-expression
containing the point.  If this command is invoked repeatedly
(without any other command occurring between invocations), the
comment progressively moves outward over enclosing expressions."
  (interactive "*p")
  (save-excursion
    (when (eq last-command this-command)
      (when (search-backward "#|" nil t)
        (save-excursion
          (delete-char 2)
          (while (and (< (point) (point-max)) (not (looking-at " *|#")))
            (forward-sexp))
          (replace-match ""))))
    (while (> arg 0)
      (backward-char 1)
      (cond ((looking-at ")") (incf arg))
            ((looking-at "(") (decf arg))))
    (insert "#|")
    (forward-sexp)
    (insert "|#")))

(defun remove-balanced-comments ()
  "Remove a set of balanced comments enclosing point."
  (interactive "*")
  (save-excursion
    (when (search-backward "#|" nil t)
      (delete-char 2)
      (while (and (< (point) (point-max)) (not (looking-at " *|#")))
        (forward-sexp))
      (replace-match ""))))

(defun r5rs-call ()
  "Calls r5rs info for current symbol"
  (interactive)
  (ignore-errors
    (let ((symbol (thing-at-point 'symbol)))
      (info "(r5rs)")
      (Info-index symbol))))

(provide 'defun-scheme)

;;; defun-scheme.el ends here
