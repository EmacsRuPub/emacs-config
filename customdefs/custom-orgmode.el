;; -*- coding: utf-8 -*-
;;
;; Filename: custom-orgmode.el
;; Created: Ср июн 18 00:57:01 2014 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defvar last-scrum-timestamp nil)

(defun save-last-scrum-timestamp ()
  (interactive)
  (with-temp-buffer
    (call-interactively 'org-time-stamp)
    (setq last-scrum-timestamp
          (buffer-substring
           (- (point-max) 4)
           (1+ (point-min))))
    (write-string-to-file
     (elisp-var-printable 'last-scrum-timestamp)
     (concat config-basedir "last-scrum-timestamp"))))

(provide 'custom-orgmode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; custom-orgmode.el ends here
