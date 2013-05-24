;;; defun-org-mode.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

;#############################################################################
;#   Custom definitions
;############################################################################
(defun org-osd-display (min-to-app new-time msg)
  (osd-display msg msg -1 "center" "center" "Verdana 40"))

(defun custom/org-agenda-to-appt ()
  (interactive)
  (setq appt-time-msg-list nil)
  (org-agenda-to-appt))

;; on screen display
(defun org-osd-display (min-to-app new-time msg)
  (osd-display msg msg -1 "center" "center" "Verdana 40")
  )

;; on screen display
(defun org-osd-display (min-to-app new-time msg)
  (osd-display msg msg -1 "center" "center" "Verdana 40")
  )

(defun org-insert-src-markers ()
  (interactive)
  (insert "#+BEGIN_SRC\n")
  (insert "#+END_SRC\n"))

(defun org-enclose-region-in-src-block ()
    (interactive)
    (let* ((beg (if (region-active-p) (region-beginning) (point)))
           (end (if (region-active-p) (region-end) (point))))
      (goto-char end)
      (unless (eq (char-before) ?\n) (insert "\n"))
      (insert "#+END_SRC\n")
      (goto-char beg)
      (beginning-of-line)
      (insert "#+BEGIN_SRC\n")
      (backward-char)))

(provide 'defun-org-mode)

;;; defun-org-mode.el ends here
