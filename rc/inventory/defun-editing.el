;; -*- coding: utf-8 -*-
;;
;; Filename: defun-editing.el
;; Created: Вт апр 29 22:50:43 2014 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ;; Smart beginning of the line
;; (defun x4-smarter-beginning-of-line ()
;;  "Move point to beginning-of-line or first non-whitespace character or first non-whitespace after a comment sign."
;;  (interactive "^")
;;  (let (
;;        (oldpos (point))
;;        (indentpos (progn
;;                     (back-to-indentation)
;;                     (point)
;;                     )
;;                   )
;;        (textpos (progn
;;                   (beginning-of-line-text)
;;                   (point)
;;                   )
;;                 )
;;        )
;;    (cond
;;     ((> oldpos textpos) (beginning-of-line-text))
;;     ((and (<= oldpos textpos) (> oldpos indentpos)) (back-to-indentation))
;;     ((and (<= oldpos indentpos) (> oldpos (line-beginning-position))) (beginning-of-line))
;;     (t (beginning-of-line-text))
;;     )
;;    )
;;  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; defun-editing.el ends here
