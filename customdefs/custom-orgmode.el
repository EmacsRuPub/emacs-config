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
(defun custom/verify-refile-target ()
  "Exclude todo keywords with a done state from refile targets"
  (not (member (nth 2 (org-heading-components)) org-done-keywords)))

(defun open-or-browse-at-point (arg)
  (interactive "P")
  (if arg
      (browse-url-at-point)
    (org-open-at-point)))

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

;TODO: customize "todo-only" parameter for "org-tags-view"
(defun custom/follow-tag-link (tag)
  "Display a list of TODO headlines with tag TAG.
With prefix argument, also display headlines without a TODO keyword."
  (org-tags-view nil tag))              ;nil was (null current-prefix-arg) originally

;TODO: use prefix arg
(defun custom/org-update-timestamp-with-time (&optional as-is)
  (interactive)
  (unless as-is
    (insert " "))
  (insert (format-time-string "%H:%M")))

(use-package helm-utils)
(defvar custom/helm-source-org-files
  `((name . "Org files")
    (candidates . ,(helm-walk-directory (at-org-dir) :path 'full))
    (action . (lambda (candidate)
                (find-file candidate)))))

(defun custom/get-org-timestamp ()
  (with-temp-buffer
    (call-interactively 'org-time-stamp-inactive)
    (buffer-string)))

(defun custom/strip-org-timestamp (ts)
  (let ((tslen (length ts)))
    (substring ts 1 (- tslen 4))))

(provide 'custom-orgmode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; custom-orgmode.el ends here
