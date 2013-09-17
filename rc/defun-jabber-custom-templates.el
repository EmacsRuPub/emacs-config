;;; defun-jabber-templates.el ---

;; Copyright (C) 2012 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:

;#############################################################################
;#   Jabber chat shortcuts
;############################################################################
(defun custom-jabber/insert-inlove-smile ()
  "Insert *IN LOVE* at cursor point."
  (interactive)
  (insert "*IN LOVE* ")
  (backward-char 10))

(defun custom-jabber/insert-kiss-smile ()
  "Insert :-* at cursor point."
  (interactive)
  (insert ":-* ")
  (backward-char 4))

(defun custom-jabber/insert-shy-smile ()
  "Insert :-[ at cursor point."
  (interactive)
  (insert ":-[ ")
  (backward-char 4))

(defun custom-jabber/wrap-replace-regexp ()
  "Wraps current word in ed's 'replace' regexp"
  (interactive)
  (kill-ring-save (region-beginning) (region-end))
  (end-of-buffer)
  (yank)
  (beginning-of-line)
  (insert "s/")
  (end-of-line)
  (insert "/")
  (yank)
  (insert "/")
  (search-backward "/" nil nil 2)
  (forward-char 1))

(defun custom-jabber/wrap-misreading ()
  "Wraps current word in 'misreading' tag"
  (interactive)
  (kill-ring-save (region-beginning) (region-end))
  (end-of-buffer)
  (yank)
  (beginning-of-line)
  (insert "+ прочтение: \"")
  (end-of-line)
  (insert "\" -> \"\"")
  (backward-char 1))

(provide 'defun-jabber-custom-templates)

;;; defun-jabber-templates.el ends here
