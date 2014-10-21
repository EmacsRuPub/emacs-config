;; -*- coding: utf-8 -*-
;;
;; Filename: custom-orgmode.el
;; Created: Ср июн 18 00:57:01 2014 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun custom/org-todo-changed-hook ()
  "Remove :current: tag, when DONE"
  ;; TODO generalize
  (let ((tags (org-get-tags)))
    (when (and (equal org-state "DONE")
               (member "current" tags))
      (org-set-tags-to (delete "current" tags)))))

;; Remove empty CLOCK drawers on clock out
(defun custom/remove-empty-drawer-on-clock-out ()
  (interactive)
  (save-excursion
    (beginning-of-line 0)
    (org-remove-empty-drawer-at "CLOCK" (point))))

;; Exclude DONE state tasks from refile targets
(defun bh/verify-refile-target ()
  "Exclude todo keywords with a done state from refile targets"
  (not (member (nth 2 (org-heading-components)) org-done-keywords)))

(defun org-osd-display (min-to-app new-time msg)
  (osd-display msg msg -1 "center" "center" "Verdana 40"))

;; on screen display
(defun org-osd-display (min-to-app new-time msg)
  (osd-display msg msg -1 "center" "center" "Verdana 40"))

;; on screen display
(defun org-osd-display (min-to-app new-time msg)
  (osd-display msg msg -1 "center" "center" "Verdana 40"))

(defvar last-scrum-timestamp nil)

(defun save-last-scrum-timestamp ()
  (interactive)
  (setq last-scrum-timestamp
          (custom/strip-org-timestamp (custom/get-org-timestamp)))
  (write-string-to-file
   (elisp-var-printable 'last-scrum-timestamp)
   (at-config-basedir "last-scrum-timestamp")))

(defun custom/get-org-timestamp ()
  (with-temp-buffer
    (call-interactively 'org-time-stamp-inactive)
    (buffer-string)))

(defun custom/strip-org-timestamp (ts)
  (let ((tslen (length ts)))
    (substring ts 1 (- tslen 4))))

(defun custom/scrum-timestamp-as-tag ()
  (replace-regexp-in-string
   "[:-]" "_" (symbol-value 'last-scrum-timestamp)))

(defun custom/insert-scrum-timestamp-tag ()
  (interactive)
  (insert (custom/scrum-timestamp-as-tag)))

;; TODO maybe squash functions below some way
(defun mark-with-finished-timestamp ()
  (interactive)
  (beginning-of-line)
  (org-beginning-of-line)
  (org-time-stamp-inactive)
  (insert " "))

(defun refile-job-done ()
  (interactive)
  (let ((org-refile-targets `((,(at-org-dir "/job/done.org") :level . 1))))
    (call-interactively 'org-refile)))

(defun process-task-done ()
  (interactive)
  (org-todo 'done)
  (mark-with-finished-timestamp)
  (refile-job-done))

(defadvice browse-url-at-point (before org-position-url activate)
  (when (derived-mode-p 'org-mode)
    (let ((end nil))
      (save-excursion
        (org-back-to-heading t)
        (setq end (save-excursion (outline-next-heading) (point))))
      (org-back-to-heading t)
      (re-search-forward url-regexp end t))))

;; TODO some handle for getting 'done' tasks within particular time range
;; TODO some tag for those tasks not directly needed for job tasks (e.g. my own setups, ssh, etc)
;; TODO save done.org after refiling finished
;; TODO auto change status TODO --> DONE before refiling

(provide 'custom-orgmode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; custom-orgmode.el ends here
