;; -*- coding: utf-8 -*-
;;
;; Filename: custom-orgmode.el
;; Created: Ср июн 18 00:57:01 2014 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defvar last-scrum-timestamp nil)

(defun save-last-scrum-timestamp ()
  (interactive)
  (setq last-scrum-timestamp
          (custom/strip-org-timestamp (custom/get-org-timestamp)))
  (write-string-to-file
   (elisp-var-printable 'last-scrum-timestamp)
   (concat config-basedir "last-scrum-timestamp")))

(defun custom/get-org-timestamp ()
  (with-temp-buffer
    (call-interactively 'org-time-stamp-inactive)
    (buffer-string)))

(defun custom/strip-org-timestamp (ts)
  (let ((tslen (length ts)))
    (substring ts 1 (- tslen 4))))

(defun custom/scrum-timestamp-as-tag ()
  (replace-regexp-in-string
   "\\:" "_" (symbol-value 'last-scrum-timestamp)))

;; TODO maybe squash functions below some way
(defun mark-with-finished-timestamp ()
  (interactive)
  (beginning-of-line)
  (org-beginning-of-line)
  (org-time-stamp-inactive)
  (insert " "))

(defun refile-job-done ()
  (interactive)
  (let ((org-refile-targets `((,(concat org-dir "/job/done.org") :level . 1))))
    (call-interactively 'org-refile)))

;; TODO some handle for getting 'done' tasks within particular time range
;; TODO some tag for those tasks not directly needed for job tasks (e.g. my own setups, ssh, etc)
;; TODO save done.org after refiling finished
;; TODO auto change status TODO --> DONE before refiling

(provide 'custom-orgmode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; custom-orgmode.el ends here
