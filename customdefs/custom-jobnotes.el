;;; custom-jobnotes.el ---

(defvar last-scrum-timestamp nil)
(defvar last-scrum-timestamp-filename (at-config-basedir "last-scrum-timestamp"))

(defun save-last-scrum-timestamp ()
  (interactive)
  (setq last-scrum-timestamp
          (custom/strip-org-timestamp (custom/get-org-timestamp)))
  (write-string-to-file
   (elisp-var-printable 'last-scrum-timestamp)
   last-scrum-timestamp-filename))

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

(provide 'custom-jobnotes)

;;; custom-jobnotes.el ends here
