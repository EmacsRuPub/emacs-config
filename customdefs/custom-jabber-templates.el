;;; defun-jabber-templates.el ---

;; Copyright (C) 2012 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:

;#############################################################################
;#   Jabber chat shortcuts
;############################################################################

;; TODO move to utility or extract to project
(defun concat-as-symbol (prefix suffix)
  (intern (downcase (concatenate 'string prefix suffix))))

;; TODO move to utility or extract to project
(defmacro custom/define-jabber-insertion (suffix str)
  `(defun ,(concat-as-symbol "custom-jabber/insert-" suffix) ()
     ,(format "Insert \"%s\" at cursor point." str)
     (interactive)
     (insert ,str)
     (backward-char ,(length str))))

(custom/define-jabber-insertion "inlove-smile" "*IN LOVE* ")
(custom/define-jabber-insertion "kiss-smile" ":-* ")
(custom/define-jabber-insertion "shy-smile" ":-[ ")
(custom/define-jabber-insertion "copyright-sign" " (c)")

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

(provide 'custom-jabber-templates)

;;; defun-jabber-templates.el ends here
