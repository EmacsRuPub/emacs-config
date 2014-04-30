;;; defun-align.el ---

;; Copyright (C) 2012 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:

(defun align-region-regexp (regexp)
  (interactive)
  (align-regexp (region-beginning) (region-end) regexp))

;; (defun align-on-comment-char ()
;;   (interactive)
;;   (align-regexp (region-beginning) (region-end) "#"))

;; (defun align-comment (beg end)
;;   (interactive "r")
;;   (align-regexp beg end (concat "\\(\\s-*\\)" comment-start))
;; )

;; (defun align-on-comment-char (beg end)
;;   (interactive "r")
;;   (align-regexp beg end "\\(\\s-*\\)#")
;; )

;; (defun align-members ()
;;   (interactive)
;;   (align-regexp " [^ ]+_"))

;; (defun align-members (BEG END)
;;   (interactive "r")
;;   (align-regexp BEG END " [^ ]+_"))

;; (defun align-members (BEG END)
;;   (interactive "r")
;;   (align-regexp BEG END "\\(\\s-*\\) [^ ]+_" 1 1))

(provide 'defun-align)

;;; defun-align.el ends here
