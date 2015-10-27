;; -*- coding: utf-8 -*-
;;
;; Filename: custom-orgmode.el
;; Created: Ср июн 18 00:57:01 2014 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define-namespace custom/

(defun org-todo-changed-hook ()
  "Remove :current: tag, when DONE"
  ;; TODO generalize
  (let ((tags (org-get-tags)))
    (when (and (equal org-state "DONE")
               (member "current" tags))
      (org-set-tags-to (delete "current" tags)))))

;; Remove empty CLOCK drawers on clock out
(defun remove-empty-drawer-on-clock-out ()
  (interactive)
  (save-excursion
    (beginning-of-line 0)
    (org-remove-empty-drawer-at "CLOCK" (point))))

;; Exclude DONE state tasks from refile targets
(defun verify-refile-target ()
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
      (re-search-forward custom/url-regexp end t))))

;; TODO some handle for getting 'done' tasks within particular time range
;; TODO some tag for those tasks not directly needed for job tasks (e.g. my own setups, ssh, etc)
;; TODO save done.org after refiling finished
;; TODO auto change status TODO --> DONE before refiling

;;TODO: customize "todo-only" parameter for "org-tags-view"
(defun follow-tag-link (tag)
  "Display a list of TODO headlines with tag TAG.
With prefix argument, also display headlines without a TODO keyword."
  (org-tags-view nil tag))              ;nil was (null current-prefix-arg) originally

;;TODO: use prefix arg
(defun org-update-timestamp-with-time (&optional as-is)
  (interactive)
  (unless as-is
    (insert " "))
  (insert (format-time-string "%H:%M")))

(use-package helm-utils)
(defvar helm-source-org-files
  `((name . "Org files")
    (candidates . ,(helm-walk-directory (at-org-dir) :path 'full))
    (action . (lambda (candidate)
                (find-file candidate)))))

(defun get-org-timestamp ()
  (with-temp-buffer
    (call-interactively 'org-time-stamp-inactive)
    (buffer-string)))

(defun strip-org-timestamp (ts)
  (let ((tslen (length ts)))
    (substring ts 1 (- tslen 4))))

(defun jump-to-org-agenda ()
  (interactive)
  (let ((buf (get-buffer "*Org Agenda*"))
        wind)
    (if buf
        (if (setq wind (get-buffer-window buf))
            (select-window wind)
          (if (called-interactively-p)
              (progn
                (select-window (display-buffer buf t t))
                (org-fit-window-to-buffer)
                ;; (org-agenda-redo)
                )
            (with-selected-window (display-buffer buf)
              (org-fit-window-to-buffer)
              ;; (org-agenda-redo)
              )))
      (call-interactively 'org-agenda-list)))
  ;;(let ((buf (get-buffer "*Calendar*")))
  ;;  (unless (get-buffer-window buf)
  ;;    (org-agenda-goto-calendar)))
  )

(defun org-use-speed-commands-for-headings-and-lists ()
  "Activate speed commands on list items too."
  (or (and (looking-at org-outline-regexp) (looking-back "^\**"))
      (save-excursion (and (looking-at (org-item-re)) (looking-back "^[ \t]*")))))

)

(provide 'custom-orgmode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; custom-orgmode.el ends here
