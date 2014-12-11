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

(provide 'custom-orgmode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; custom-orgmode.el ends here
