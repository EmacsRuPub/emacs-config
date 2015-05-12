;;; defun-jabber-custom.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(defvar url-regexp "\\(http\\(s\\)*://\\)\\(www.\\)*\\|\\(www.\\)")
(defvar use-zenburn-in-jabber t "Paint jabber-el buffers with zenburn colors")

(defun custom/open-urls-in-region (beg end)
  "Open URLs between BEG and END."
  (interactive "r")
  (save-excursion
    (save-restriction
      (narrow-to-region beg end)
      (goto-char (point-min))
      (while (re-search-forward org-plain-link-re nil t)
        (org-open-at-point)))))

(provide 'custom-jabber)

;;; defun-jabber-custom.el ends here
