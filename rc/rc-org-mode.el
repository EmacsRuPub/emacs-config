;;; emacs-rc-org-mode.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

;#############################################################################
;#   Load extensions
;############################################################################
(autoload 'icalendar-import-buffer "icalendar" "Import iCalendar data from current buffer" t)

(require 'org-install)
(require 'org)
(require 'org-agenda)
(require 'org-pomodoro)

;#############################################################################
;#   Custom definitions
;############################################################################
(defun org-osd-display (min-to-app new-time msg)
  (osd-display msg msg -1 "center" "center" "Verdana 40"))

;; on screen display
(defun org-osd-display (min-to-app new-time msg)
  (osd-display msg msg -1 "center" "center" "Verdana 40")
  )

;; on screen display
(defun org-osd-display (min-to-app new-time msg)
  (osd-display msg msg -1 "center" "center" "Verdana 40")
  )


;#############################################################################
;#   Customizations
;############################################################################
(add-to-list 'file-coding-system-alist (cons "\\.\\(org\\|org_archive\\|/TODO\\)$"  'utf-8))

(setq org-todo-keywords
      '((sequence "TODO(t)" "GOING(g)" "WAITING(w@)" "LATER(l)"
                  "|" "DONE(d!/@)" "SOMEDAY(s)" "CANCELLED(c@)")
        (sequence "NEW(n)" "INPROGRESS(p)" "CHECKING(r)" "REWORK(f)" "|" "CLOSED(k)")))

(setq org-todo-keywords-for-agenda '((sequence "TODO(t)" "WAITING(w)" "STARTED(s)")))
(setq org-done-keywords-for-agenda '((sequence "DONE(d)" "CANCELLED(c)")))

(setq org-agenda-time-grid
      '((daily today require-timed remove-match)
        "----------------"
        (930 1000 1200 1400 1600 1800 2000 2200 2400 2500)))

(setq org-todo-keyword-faces
      '(("TODO" . (:foreground "red" :weight bold))
        ("WAITING" . (:foreground "orange" :weight bold))
        ("DONE" . (:foreground "green" :weight bold))
        ("CANCELLED" . (:foreground "cyan" :weight bold))
        ("NEW" . (:foreground "red" :weight bold))
        ("INPROGRESS" . (:foreground "yellow" :weight bold))
        ("CHECKING" . (:foreground "orange" :weight bold))
        ("REWORK" . (:foreground "red" :weight bold))
        ("CLOSED" . (:foreground "green" :weight bold))))

(setq org-priority-faces
      '((?A :foreground "red" :weight bold)
        (?B :foreground "#94bff3" :weight bold)
        (?C :foreground "#6f6f6f")))

(setq org-agenda-files (all-files-under-dir-recursively org-dir "org"))
;TODO: maybe do it less straightforward
(add-to-list 'org-agenda-files (concat config-basedir "/todo.org"))
(add-to-list 'org-agenda-files (concat config-basedir "/totry.org"))

; Targets include this file and any file contributing to the agenda - up to 5 levels deep
(setq org-refile-targets (quote ((org-agenda-files :maxlevel . 5) (nil :maxlevel . 5))))
(setq org-refile-use-outline-path (quote file))
(setq org-refile-allow-creating-parent-nodes (quote confirm))

(setq org-agenda-span 'month)
(setq org-deadline-warning-days 14)
(setq org-agenda-show-all-dates t)
(setq org-agenda-skip-deadline-if-done t)
(setq org-agenda-skip-scheduled-if-done t)
(setq org-agenda-todo-list-sublevels nil)
(setq org-agenda-start-on-weekday nil)
(setq org-agenda-include-diary t)
(setq org-agenda-include-all-todo t)
(setq org-reverse-note-order t)
(setq org-fast-tag-selection-single-key (quote expert))
(setq org-startup-folded nil)
(setq org-log-done t)
(setq org-hide-leading-stars t)
(setq org-use-property-inheritance t)
(setq org-special-ctrl-a/e t)
(setq org-special-ctrl-k t)
(setq org-blank-before-new-entry (quote ((heading . auto) (plain-list-item))))
(setq org-agenda-dim-blocked-tasks 'invisible)
(setq org-enforce-todo-checkbox-dependencies t)
(setq org-enforce-todo-dependencies t)

(setq org-agenda-custom-commands
      (quote (("d" todo "DELEGATED" nil)
              ("c" todo "DONE|DEFERRED|CANCELLED" nil)
              ("w" todo "WAITING" nil)
              ("et" tags "+ticket+emacs")
              ("xt" tags "+ticket+xmonad")
              ("W" agenda "" ((org-agenda-ndays 21)))
              ("A" agenda ""
               ((org-agenda-skip-function
                 (lambda nil
                   (org-agenda-skip-entry-if (quote notregexp) "\\=.*\\[#A\\]")))
                (org-agenda-ndays 1)
                (org-agenda-overriding-header "Today's Priority #A tasks: ")))
              ("u" alltodo ""
               ((org-agenda-skip-function
                 (lambda nil
                   (org-agenda-skip-entry-if (quote scheduled) (quote deadline)
                                             (quote regexp) "<[^>\n]+>")))
                (org-agenda-overriding-header "Unscheduled TODO entries: ")))
              ("jp" tags "+work+planning")
              ("U" "Prioritized tasks"
               ((tags-todo "+PRIORITY=\"A\"")
                (tags-todo "+PRIORITY=\"B\"")
                (tags-todo "+PRIORITY=\"C\"")))
              )))

(setq org-insert-mode-line-in-empty-file t)
(setq org-log-done t) ;; read documentation
(setq org-ditaa-jar-path (concat config-basedir "resources/ditaa0_9.jar"))

(setq org-capture-templates
      (quote
       (("d" "todo")
        ("dc" "chaos" entry (file (concat org-dir "/todo.org")) "* SOMEDAY %? %U :todo:chaos:")
        ("dt" "today" entry (file (concat org-dir "/todo.org")) "* TODO %? %U :todo:today:")
        ("dn" "tomorrow" entry (file (concat org-dir "/todo.org")) "* TODO %? %U :todo:tomorrow")
        ("do" "ordering" entry (file (concat org-dir "/ordering.org")) "* TODO %? %U :todo:ordering")
        ("de" "emacs")
        ("det" "emacs todo" entry (file (concat config-basedir "/todo.org")) "* TODO %? %U :emacs:ticket:")
        ("dey" "emacs try" entry (file+headline (concat config-basedir "/totry.org") "try") "* %? %U :emacs:try:")
        ("dm" "system maintaining" entry (file+headline (concat org-dir "/projects/config/linux-system.org") "raw tickets") "* TODO %? %U :todo:system:")
        ("dp" "project ideas" entry (file (concat org-dir "/projects/ideas/projectideas.org")) "* %? %U :project:idea:")
        ("dx" "xmonad tickets" entry (file+headline (concat org-dir "/projects/config/xmonad.org") "tickets") "* %? %U :xmonad:ticket:")
        ("ds" "stumpwm tickets" entry (file+headline (concat org-dir "/projects/config/stumpwm.org") "tickets") "* %? %U :stumpwm:ticket:")
        ("dw" "workplace fixes" entry (file (concat org-dir "/workplace-fixes.org")) "* TODO %? %U :workplace:")
        ("j" "job")
        ("ji" "issues" entry (file+headline (concat org-dir "/job/issues.org") "list") "* %? %U :work:tasks:")
        ("jp" "plan" entry (file (concat org-dir "/job/plan.org")) "* TODO %? %U :work:planning:%(custom/scrum-timestamp-as-tag):")
        ("b" "browser tabs")
        ("bc" "clojure" entry (file+olp (concat org-inventory-dir "/review/browser-tabs.org") "firefox tabs" "clojure (to process)") "* %? %U :clojure:")
        ("bh" "haskell" entry (file+olp (concat org-inventory-dir "/review/browser-tabs.org") "firefox tabs" "haskell") "* %? %U :haskell:")
        ("l" "links" entry (file (concat org-dir "/links.org")) "* %? %U :links:send:")
        ("g" "github" entry (file (concat org-inventory-dir "/checklists/github.org")) "* %? %U :github:")
        ("k" "knowledge base" entry (file (concat org-inventory-dir "/kb.org")) "* %? %U :kb:raw:")
        ("s" "search" entry (file (concat org-inventory-dir "/search.org")) "* TODO %? %U :search:")
        ("n" "newspaper articles" entry (file+headline (concat org-dir "/checklists/from_newspapers.org") "unsorted") "* %? %U :newspaper:toread:")
        )))


;#############################################################################
;#   Setup
;############################################################################
(appt-activate t)
(run-at-time "00:59" 3600 'org-save-all-org-buffers)

(load (concat config-basedir "last-scrum-timestamp"))

;#############################################################################
;#   Hooks
;############################################################################
(defun custom/org-mode-hook ()
  (local-set-key (kbd "C-x C-a") 'show-all)
  (local-unset-key (kbd "C-c ["))
  (local-unset-key (kbd "C-c ]"))
  (imenu-add-to-menubar "Imenu"))

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

(add-hook 'org-mode-hook 'custom/org-mode-hook)
(add-hook 'org-mode-hook 'turn-on-font-lock)
(add-hook 'diary-display-hook 'fancy-diary-display)
(add-hook 'org-after-todo-state-change-hook 'custom/org-todo-changed-hook)
(add-hook 'org-clock-out-hook 'custom/remove-empty-drawer-on-clock-out 'append)

(setq org-default-notes-file custom/org-capture-file)

(global-set-key (kbd "C-c e") 'org-capture)


;#############################################################################
;#   Keybindings
;############################################################################
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c b") 'org-iswitchb)
(global-set-key (kbd "C-c t c") 'org-table-create)
(global-set-key (kbd "C-c t s") 'org-sparse-tree)
(global-set-key (kbd "C-c t t") 'org-toggle-timestamp-type)
(global-set-key (kbd "C-c t t") 'org-toggle-timestamp-type)
(global-set-key (kbd "C-c o") 'oog)
(global-set-key (kbd "C-c m m") 'org-agenda-bulk-mark-all)
(global-set-key (kbd "C-c m u") 'org-agenda-bulk-unmark-all)
(global-set-key (kbd "<f12>") 'org-pomodoro)

(global-set-key (kbd "C-c C-o C-s") 'save-last-scrum-timestamp)
(global-set-key (kbd "C-c C-o C-m") 'mark-with-finished-timestamp)
(global-set-key (kbd "C-c C-o C-d") 'refile-job-done)

(provide 'rc-org-mode)

;;; emacs-rc-org-mode.el ends here
