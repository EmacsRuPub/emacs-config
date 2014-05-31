;;; rc-org-temp.el ---

;; Copyright (C) 2012 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:


;;; Modules
(setq org-modules
      '(
        org-bibtex
        org-bookmark
        org-expiry
        org-habit
        org-id
        org-info
        org-inlinetask
        org-man
        org-w3m
        org-clock
        org-timer
        org-protocol))

;; example:
;; (:startgroup . nil)
;; ("@" . ?w) ("@home" . ?h)
;; ("@tennisclub" . ?t)
;; (:endgroup . nil)
(setq org-tag-alist '((:startgroup . nil)
                      ("@home" . ?h)
                      ("@errands" . ?e)
                      ("@computer" . ?c)
                      ("@reading" . ?r)
                      ("@phone" . ?p)
                      ("@message" . ?m)
                      (:endgroup . nil)
                      ("project" . ?x)
                      ("event" . ?v)
                      ("idea" . ?i)
                      ("next" . ?n)))

(setq org-todo-state-tags-triggers
      '(("WAITING" ("next"))
        ("LATER" ("next"))
        ("DONE" ("next"))
        ("SOMEDAY" ("next"))
        ("CANCELED" ("next"))
        ("GOING" ("next" . t))))

(setq org-stuck-projects
      '("project/-DONE-CANCELED"
        ("GOING") ("next") ""))

(setq org-global-properties
      '(("STYLE_ALL" . "habit")))

(setq org-tags-exclude-from-inheritance '("project"))
(setq org-columns-default-format
      "%42ITEM %TODO %3Effort(E){:} %3CLOCKSUM_T(R) %SCHEDULED")
(setq org-read-date-prefer-future 'time)
(setq org-completion-use-ido t)
(setq org-refile-targets '((org-agenda-files :maxlevel . 3)
                           (nil :maxlevel . 3)))
(setq org-refile-use-outline-path 'file)
(setq org-outline-path-complete-in-steps nil)
(setq org-clock-history-length 35)
(setq org-clock-in-resume nil)
(setq org-clock-in-switch-to-state "GOING")
(setq org-clock-out-switch-to-state
      (function iy-clock-out-switch-to-pause-if-going))
(setq org-clock-idle-time 30)
(setq org-drawers '("PROPERTIES" "LOGBOOK" "CLOCK"))
(setq org-clock-into-drawer "CLOCK")
(setq org-clock-out-remove-zero-time-clocks t)
(setq org-clock-out-when-done t)
(setq org-clock-persist (quote history))
(setq org-agenda-todo-ignore-with-date t)
(setq org-agenda-skip-deadline-if-done t)
(setq org-agenda-skip-scheduled-if-done t)
(setq org-agenda-skip-timestamp-if-done t)
(setq org-agenda-span 7)
(setq org-tags-column -80)
(setq org-agenda-tags-column -80)
(setq org-enforce-todo-checkbox-dependencies t)
(setq org-enforce-todo-dependencies t)
(setq org-cycle-separator-lines 2)
(setq org-agenda-todo-list-sublevels t)
(setq org-show-following-heading t)
(setq org-show-hierarchy-above t)
(setq org-show-siblings nil)
(setq org-log-into-drawer t)
(setq org-special-ctrl-a/e t)
(setq org-special-ctrl-k t)
(setq org-yank-adjusted-subtrees nil)
(setq org-use-fast-todo-selection t)
(setq org-directory (concat iy-dropbox-dir "g/org"))
(setq org-mobile-directory (concat iy-dropbox-dir "MobileOrg"))
(setq org-mobile-inbox-for-pull (concat iy-dropbox-dir "g/org/mobile-inbox.org"))

(setq org-agenda-files (list (concat iy-dropbox-dir "g/org") (concat iy-dropbox-dir "g/org/projects")))
(setq org-default-notes-file (concat org-directory "/inbox.org"))
(setq org-mobile-directory (concat iy-dropbox-dir "MobileOrg"))
(setq org-mobile-inbox-for-pull (concat iy-dropbox-dir "g/org/from_mobile.org"))
(setq org-ditaa-jar-path iy-ditaa-path)
(setq org-extend-today-until 2)

(setq org-file-apps
      '((t . emacs)
        (system . "xopen %s")))

(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c L") 'org-insert-link-global)
(global-set-key (kbd "C-c o") 'org-open-at-point-global)
(global-set-key (kbd "C-c a") 'org-agenda)

(define-key iy-map (kbd "<return>") 'org-clock-goto)
(define-key iy-map (kbd "<DEL>") 'org-clock-out)
(define-key iy-map (kbd "r") 'org-capture)
(define-key iy-map (kbd "M-r") 'org-capture)
(autoload 'org-footnote-action "org-footnote" nil t)
(define-key iy-map (kbd "t") 'org-footnote-action)
(define-key iy-map (kbd "'") 'org-pomodoro-record-interuptions)

(add-hook 'org-mode-hook 'iy-org-mode-init)
(defun iy-org-mode-init ()
  (define-key org-mode-map (kbd "C-c ,") 'org-cycle-agenda-files)
  (define-key org-agenda-mode-map "#" 'org-agenda-3-days-view)
  (define-key org-agenda-mode-map "M" 'org-agenda-month-view)
  (flyspell-mode 1)
  (org-pomodoro-on-org-load))

(defun wl-org-column-view-uses-fixed-width-face ()
  ;; copy from org-faces.el
  (when (fboundp 'set-face-attribute)
    ;; Make sure that a fixed-width face is used when we have a column table.
    (set-face-attribute 'org-column nil
                        :height (face-attribute 'default :height)
                        :family (face-attribute 'default :family))))

(when iy-daemon-enable-daemon
  (add-hook 'org-mode-hook 'wl-org-column-view-uses-fixed-width-face))

;;; Clock
(defun sacha-org-clock-in-if-starting ()
  "Clock in when the task is marked GOING."
  (when (and (string= org-state "GOING")
             (not (string= org-last-state org-state))
             (not org-clock-current-task))
    (org-clock-in)))
(add-hook 'org-after-todo-state-change-hook
          'sacha-org-clock-in-if-starting)

(defun iy-org-clock-out-if-pause ()
  "Clock out when the task is marked PAUSE."
  (when (and (string= org-state "PAUSE")
             (not (string= org-last-state org-state))
             (org-clock-is-active))
    (org-clock-out t)))
(add-hook 'org-after-todo-state-change-hook
          'iy-org-clock-out-if-pause)
(defun iy-clock-out-switch-to-pause-if-going (state)
  "Switch to PAUSE if clock out a task marked GOING"
  (if (string= state "GOING") "PAUSE" state))

;;; Template
(setq
 org-capture-templates
 '(("r" "Notes" entry (file+headline (concat org-directory "/inbox.org") "Notes")
    "* %?\n :PROPERTIES:\n :CREATED: %U\n :END:\n %a\n %i"
    :prepend t)
   ("t" "TODO" entry (file+headline (concat org-directory "/inbox.org") "Tasks")
    "* TODO %?\n :PROPERTIES:\n :CREATED: %U\n :END:\n %a\n %i")
   ("j" "Journal" plain (file+datetree (concat org-directory "/journal.org"))
    "\n%?\n" :empty-lines 1)
   ("d" "Dump" plain (file+olp (concat org-directory "/inbox.org") "Quick Notes" "Plain")
    "\n--%U--------------------------------------------------\n%?\n" :empty-lines 1)
   ("l" "List" item (file+olp (concat org-directory "/inbox.org") "Quick Notes" "List") "%?\n" :empty-lines 1)
   ("s" "SOMEDAY" entry (file+headline (concat org-directory "/inbox.org") "Someday")
    "* SOMEDAY %?\n :PROPERTIES:\n :CREATED: %U\n :END:\n %a\n %i")
   ("x" "Clipboard" entry (file+headline (concat org-directory "/inbox.org") "Notes")
    "* %?\n :PROPERTIES:\n :CREATED: %U\n :END:\n %x"
    :prepend t :empty-lines 1)
   ("i" "Idea" entry (file (concat org-directory "/spark.org") "")
    "* %?\n :PROPERTIES:\n :CREATED: %U\n :END:\n %a\n %i")

   ("c" "Code snippet" entry (file (concat iy-dropbox-dir "g/snippets/inbox.org"))
    "* %^{title} %^g\n :PROPERTIES:\n :CREATED: %U\n :END:\n\n#+BEGIN_SRC %^{lang}\n %i%?\n#+END_SRC\n")
   ("b" "Default template" entry (file+headline "inbox.org" "Bookmarks")
    "* %:description\n :PROPERTIES:\n :CREATED: %U\n :END:\n %c\n\n %i"
    :prepend t :empty-lines 1 :immediate-finish t)))

;;; Custom Agenda
(setq org-agenda-custom-commands
      '(("l" . "Context List")
        ("lh" "Home"
         ((tags-todo "@home/GOING|PAUSE|TODO")))
        ("le" "Errands"
         ((tags-todo "@errands/GOING|PAUSE|TODO")))
        ("lc" "Computer"
         ((tags-todo "@computer/GOING|PAUSE|TODO")))
        ("lp" "Phone"
         ((tags-todo "@phone/GOING|PAUSE|TODO")))
        ("lm" "Message"
         ((tags-todo "@message/GOING|PAUSE|TODO")))
        ("lr" "Reading"
         ((tags-todo "@reading/GOING|PAUSE|TODO")))
        ("T" "TODO List"
         ((todo "GOING|PAUSE|TODO"))
         ((org-agenda-todo-ignore-with-date nil)))
        ("M" "Maybe"
         ((todo "WAITING|LATER"))
         ((org-agenda-todo-ignore-with-date nil)))
        ("i" "Inbox" tags "inbox-CONTAINER=\"true\"")

        ("d" "Daily Action List"
         ((agenda "" ((org-agenda-span 'day)
                      (org-agenda-sorting-strategy
                       (quote ((agenda time-up priority-down tag-up) )))
                      (org-deadline-warning-days 0)))))

        ("r" "Review"
         ((agenda "" ((org-agenda-span 'day)
                      (org-agenda-sorting-strategy
                       (quote ((agenda time-up priority-down tag-up) )))
                      (org-deadline-warning-days 0)
                      (org-agenda-skip-deadline-if-done nil)
                      (org-agenda-skip-timestamp-if-done nil)
                      (org-agenda-skip-scheduled-if-done nil)))))

        ("p" "Projects" ((tags "project/-DONE-CANCELED") (stuck "")))

        ("x" "Archive tags search" tags ""
         ((org-agenda-files (file-expand-wildcards (concat org-directory "/*.org_archive" )))))
        ("X" "Archive search" search ""
         ((org-agenda-files (file-expand-wildcards (concat org-directory "/*.org_archive" )))))

        ("c" "Code snippets tags search" tags ""
         ((org-agenda-files (append (file-expand-wildcards (concat iy-dropbox-dir "g/snippets/*.org" ))
                                    (file-expand-wildcards (concat iy-dropbox-dir "g/snippets/*/*.org"))))))
        ("C" "Code snippets search" search ""
         ((org-agenda-files (append (file-expand-wildcards (concat iy-dropbox-dir "g/snippets/*.org" ))
                                    (file-expand-wildcards (concat iy-dropbox-dir "g/snippets/*/*.org"))))))
        ))

;;; Appt
(appt-activate 1)
;; (ignore-errors (org-agenda-to-appt))
(add-hook 'org-finalize-agenda-hook 'org-agenda-to-appt)

(defun iy-appt-display (min-to-app new-time msg)
  (let ((title (format "Appointment in %d minute(s)" min-to-app)))
    (message (concat title ": " msg))
    (if (fboundp 'dbus-call-method)
        (dbus-call-method
         :session "org.freedesktop.Notifications"
         "/org/freedesktop/Notifications"
         "org.freedesktop.Notifications" "Notify"
         "Emacs Appt"
         0
         "appointment-soon"
         (format "Appointment in %d minute(s)" min-to-app)
         msg
         '(:array)
         '(:array :signature "{sv}")
         ':int32 -1)
      (el-get-notify title msg))))

(defun iy-org-clock-display (msg)
  (message "Org Notification: %s" msg)
  (if (fboundp 'dbus-call-method)
      (dbus-call-method
       :session "org.freedesktop.Notifications"
       "/org/freedesktop/Notifications"
       "org.freedesktop.Notifications" "Notify"
       "Emacs Org"
       0
       "appointment-missed"
       "Org Notification"
       msg
       '(:array)
       '(:array :signature "{sv}")
       ':int32 -1)
    (el-get-notify "Org Notification" msg)))

(setq appt-disp-window-function (function iy-appt-display))
(setq org-show-notification-handler (function iy-org-clock-display))

;; pomodoro

(defvar org-pomodoro-minutes 25)
(defvar org-pomodoro-cancelling nil)
(defvar org-pomodoro-process nil)
(defvar org-pomodoro-command (locate-file "pomodoro" exec-path))

(defun org-pomodoro-on-org-load ()
  (push (cons "p" org-pomodoro-minutes) org-effort-durations)
  (push '("Effort_ALL" . "1p 2p 3p 4p 5p 6p 7p 8p") org-global-properties)
  (define-key org-mode-map "\C-c\C-x'" 'org-pomodoro-columns)
  (define-key org-agenda-mode-map "\C-c\C-x'" 'org-pomodoro-agenda-columns))

(defadvice org-minutes-to-hh:mm-string (around org-pomodoro-minutes-to-pomodoros activate)
  (setq ad-return-value (format "%dp" (round (/ m (float org-pomodoro-minutes))))))
(defadvice org-columns-number-to-string (around org-pomodoro-minutes-to-pomodoros activate)
  (if (memq fmt '(add_times max_times min_times mean_times))
      (setq ad-return-value (format "%dp" (round (/ (* n 60) org-pomodoro-minutes))))
    ad-do-it))

(defun org-pomodoro-after-clock-in ()
  (when (not org-timer-current-timer)
    (org-timer-set-timer org-pomodoro-minutes)
    (when (and org-pomodoro-process
               (eq 'run (process-status org-pomodoro-process)))
      (interrupt-process org-pomodoro-process))
    (when org-pomodoro-command
      (setq org-pomodoro-process
            (start-process "pomodoro" nil "pomodoro" "-l" (number-to-string org-pomodoro-minutes))))))

(defun org-pomodoro-after-clock-out ()
  (org-pomodoro-stop-process)
  (unless org-pomodoro-cancelling
    (org-pomodoro-cancel-timer-safe)))

(defun org-pomodoro-stop-process ()
  (when (and org-pomodoro-process
             (eq 'run (process-status org-pomodoro-process)))
    (interrupt-process org-pomodoro-process)
    (setq org-pomodoro-process nil)))

(defun org-pomodoro-is-indivisible! ()
  (let ((org-clock-out-remove-zero-time-clocks nil)
        (org-pomodoro-cancelling t)
        (buffer (current-buffer))
        (point (point)))
    (when (org-clock-is-active)
      (setq buffer (marker-buffer org-clock-marker)
            point (marker-position org-clock-marker))
      (org-clock-out))
    (save-excursion
      (with-current-buffer buffer
        (save-restriction
          (widen)
          (goto-char point)
          (beginning-of-line 1)
          (when (and (not remove)
                     (looking-at (concat "[ \t]*" org-keyword-time-regexp))
                     (equal (match-string 1) org-clock-string))
            (goto-char (match-end 0))
            (beginning-of-line 1)
            (kill-line 1)
            (message "Pomodoro is cancelled")))))))

(defun org-pomodoro-done ()
  (when (org-clock-is-active)
    (org-clock-out)
    (start-process-shell-command "pomodoro-ring" nil "mplayer ~/Dropbox/resources/audio/ring.mp3")))

(defun org-pomodoro-cancel-timer-safe ()
  (when org-timer-current-timer (org-timer-cancel-timer)))

(add-hook 'org-timer-pause-hook 'org-pomodoro-cancel-timer-safe)
(add-hook 'org-timer-continue-hook 'org-pomodoro-cancel-timer-safe)
(add-hook 'org-timer-stop-hook 'org-pomodoro-cancel-timer-safe)
(add-hook 'org-timer-cancel-hook 'org-pomodoro-is-indivisible!)
(add-hook 'org-timer-done-hook 'org-pomodoro-done)
(add-hook 'org-clock-in-hook 'org-pomodoro-after-clock-in)
(add-hook 'org-clock-out-hook 'org-pomodoro-after-clock-out)

(defvar org-pomodoro-columns-format
  "%22SCHEDULED %CATEGORY %42ITEM %3Effort(E){:} %3CLOCKSUM_T(R) %POMODORO_INTERRUPTIONS(I){+}")

(defun org-pomodoro-columns ()
  (interactive)
  (org-columns org-pomodoro-columns-format))

(defun org-pomodoro-agenda-columns ()
  (interactive)
  (let ((org-agenda-overriding-columns-format org-pomodoro-columns-format))
   (org-agenda-columns)))

(defun org-pomodoro-record-interuptions (char)
  (interactive (list
                (if (string=
                     "internal"
                     (completing-read "type: " '("internal" "external") nil t nil nil "internal"))
                    ?' ?-)))
  (if (and org-clock-current-task org-clock-marker)
      (save-excursion
        (with-current-buffer (marker-buffer org-clock-marker)
          (goto-char org-clock-marker)
          (let ((value (concat (sort (cons char (string-to-list (org-entry-get nil "POMODORO_INTERUPTIONS"))) '<))))
            (org-entry-put nil "POMODORO_INTERUPTIONS" value)
            (org-entry-put nil "POMODORO_INTERUPTIONS_COUNT" (number-to-string (length value)))
            (message "Interuptions: %s" value))))
    (error "no active pomodoro")))

(defun org-agenda-3-days-view (&optional day-of-year)
  "Switch to 3-days (yesterday, today, tomorrow) view for agenda."
  (interactive "P")
  (org-agenda-check-type t 'agenda)
  (if (and (not day-of-year) (equal org-agenda-current-span 3))
      (error "Viewing span is already \"%s\"" 3))
  (let* ((sd (or day-of-year
                 (org-get-at-bol 'day)
                 (time-to-days (current-time))))
         (sd (and sd (1- sd)))
         (org-agenda-overriding-arguments
          (or org-agenda-overriding-arguments
              (list (car (get-text-property (point) 'org-last-args)) sd 3 t))))
    (org-agenda-redo)
    (org-agenda-find-same-or-today-or-agenda))
  (org-agenda-set-mode-name)
  (message "Switched to %s view" 3))

(defun org ()
  (interactive)
  (ido-find-file-in-dir org-directory))
(defun orgb ()
  (interactive)
  (ido-find-file-in-dir org-directory))
(defun snippet ()
  (interactive)
  (ido-find-file-in-dir (concat iy-dropbox-dir "g/snippets" )))

(setq org-fontify-done-headline t)
(custom-set-variables
 '(appt-display-format (quote window))
 '(appt-message-warning-time 10)
 '(calendar-week-start-day 1)
 '(diary-file (concat iy-dropbox-dir "diary")))

(provide 'iy-pim)

;; (require 'org-checklist)
;; (require 'org-screen)
;; (require 'org-protocol)
;; (require 'org-mobile)

;; (setq org-modules (quote (org-bibtex org-crypt org-gnus org-id org-info org-jsinfo org-habit org-inlinetask org-irc org-protocol org-w3m)))
;; mine^: (org-bbdb org-bibtex org-docview org-gnus org-info org-jsinfo org-irc org-mew org-mhe org-rmail org-vm org-w3m org-wl)


; global STYLE property values for completion
(setq org-global-properties (quote (("STYLE_ALL" . "habit"))))

;; Most of this ripped from http://doc.norang.ca/org-mode.html
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(setq
 org-directory "~/emacs_org" ;; Use ~/emacs_org for storing files. Usually symlinked to Dropbox
 org-log-done t ;; By default, at least timestamp done states
 org-indent-mode t ;; Always make sure indentation is on
 org-startup-indented t ;; Start indented
 org-cycle-separator-lines 0 ;; Hide blank lines inside folded nodes
 org-reverse-note-order nil ;; Show notes in a task first
 org-agenda-ndays 1 ;; Just show one day on the agenda
 org-indent-indentation-per-level 2 ;; Not sure, think I copied it from norang
 org-archive-location "~/emacs_org/archives/%s_archive::" ;; Archive to the file name, assume we're not doubling up names across projects
 org-enable-priority-commands nil ;; Don't really use priorities, turn them off
 org-confirm-elisp-link-function 'y-or-n-p ;; Do single letter confirm of links
 org-completion-use-ido t ;; Use IDO for target completion
 org-refile-targets (quote ((nil :maxlevel . 9) (org-agenda-files :maxlevel . 9))) ;; Targets include this file and any file contributing to the agenda - up to 9 levels deep
 org-refile-use-outline-path (quote file) ;; Use outline paths, but let IDO handle things
 org-refile-allow-creating-parent-nodes (quote confirm) ;; Allow refile to create parent tasks with confirmation
 org-outline-path-complete-in-steps nil ;; IDO now handles header finding
 org-clock-history-length 35 ;; Yes it's long... but more is better ;
 org-clock-in-resume t ;; Resume clocking task on clock-in if the clock is open
 org-clock-in-switch-to-state "STARTED" ;; Change task state to STARTED when clocking in
 org-clock-into-drawer t ;; Save clock data and notes in the LOGBOOK drawer
 org-clock-out-remove-zero-time-clocks t ;; Sometimes I change tasks I'm clocking quickly - this removes clocked tasks with 0:00 duration
 org-clock-out-when-done nil ;; Don't clock out when moving task to a done state
 org-clock-persist t ;; Save the running clock and all clock history when exiting Emacs, load it on startup
 org-enable-priority-commands nil ;; Don't use priorities and accidentally set them all the time, so just turn them off.
 org-use-sub-superscripts nil ;; Don't use super/subscript, makes exports weird.
 org-habit-graph-column 50 ;; The habit graph display column in the agenda
 appt-message-warning-time 15 ;; warn 15 min in advance
 appt-display-interval 5 ;; warn every 5 minutes
 appt-display-mode-line t ;; show in the modeline
 appt-display-format 'nil ;; use our func
 org-use-speed-commands t ;; use speed commands
 org-return-follows-link t ;; I like links being active ret
 org-cycle-include-plain-lists t ;; Make lists cycle whether they're nodes or plain
 org-src-fontify-natively t ;; Fontify org-src blocks like their language mode
 org-agenda-sticky t ;; Turn on sticky agendas so we don't have to regenerate them
 ;; region ;; If there's a region, do whatever it is I'm trying to do to ALL headlines in
org-loop-over-headlines-in-active-region t
org-align-all-tags t)

;; flyspell mode for spell checking everywhere
(add-hook 'org-mode-hook 'turn-on-flyspell 'append)

;; Disable C-c [ and C-c ] in org-mode
(add-hook 'org-mode-hook
          (lambda ()
            ;; Undefine C-c [ and C-c ] since this breaks my
            ;; org-agenda files when directories are include It
            ;; expands the files in the directories individually
            (org-defkey org-mode-map "\C-c[" 'undefined)
            (org-defkey org-mode-map "\C-c]" 'undefined))
          'append)

;; Resume clocking tasks when emacs is restarted
(org-clock-persistence-insinuate)

;; 3 different stage setups. First two are from norang, final is for
;; events, so I can search for things like "all concerts I attended
;; this year" via state and tags
(setq org-todo-keywords (quote ((sequence "TODO(t)" "STARTED(s!)" "|" "DONE(d!/!)")
                                (sequence "WAITING(w@/!)" "SOMEDAY(S!)" "OPEN(O@)" "|" "CANCELLED(c@/!)")
(sequence "EVENT(e)" "|" "ATTENDED(a!)" "SKIPPED(k!)")
(sequence "ORDER(z)" "ORDERED(o!)" "SHIPPED(h!)" "|" "ARRIVED(A!/!)"))))

;; I use C-M-r to start org-remember
(global-set-key (kbd "C-M-R") 'org-capture)

;; Once again, stolen from norang, except for the contacts one, which
;; was taken from the org-mode list.
(setq org-capture-templates
      (quote
       (("t" "todo" entry (file "~/emacs_org/tasks.org")
"* TODO %?
%u
%a")
("n" "note" entry (file "~/emacs_org/notes.org")
"* %? :NOTE:
%u
%a")
("r" "reply" entry (file+headline "~/emacs_org/tasks.org" "Email")
"* [[gnus:%:group#%:message-id]] :email:"
:immediate-finish t)
("w" "link" entry (file+headline "~/emacs_org/links.org" "Links")
"* %c :link:"
:immediate-finish t)
("s" "snowmew link" entry (file+headline "~/emacs_org/links.org" "Snowmew Links")
"* %c :link:"
:immediate-finish t))))

;; Personal agenda modes
(setq org-agenda-custom-commands
      (quote (("h" "Tasks for home" tags-todo "+HOME-someday" nil)
              ("5" "Tasks for work" tags-todo "+WORK-someday" nil)
              ("p" "Tasks for personal projects" tags-todo "+PROJECTS-someday" nil)
              ("X" agenda ""
               (;;(org-agenda-prefix-format " [ ] ")
                (org-agenda-with-colors nil)
                (org-agenda-remove-tags t))
               ("~/emacs_org/agenda.txt"))
              ("w" agenda "Week with events and no daily/chores"
               ((org-agenda-ndays-to-span 7)
                (org-agenda-ndays 7)
                (org-agenda-filter-preset '("-daily"))))
(" " "Agenda"
               ((agenda "" nil)
                (tags "email"
                      ((org-agenda-overriding-header "Emails")
                       (org-tags-match-list-sublevels nil)
(org-agenda-skip-function '(org-agenda-skip-entry-if 'todo '("DONE" "CANCELLED")))))
nil)))))

;; Org mode notifications via aptp
;; the appointment notification facility
(appt-activate 1) ;; active appt (appointment notification)
(display-time) ;; time display is required for this...

;; update appt each time agenda opened
(add-hook 'org-finalize-agenda-hook 'org-agenda-to-appt)

(setq org-latex-to-pdf-process
      '("xelatex -interaction nonstopmode %f"
"xelatex -interaction nonstopmode %f")) ;; for multiple passes


;; Always hilight the current agenda line
(add-hook 'org-agenda-mode-hook
          '(lambda () (hl-line-mode 1))
          'append)

;; The following custom-set-faces create the highlights
(custom-set-faces
 '(org-mode-line-clock ((t (:background "grey75" :foreground "red" :box (:line-width -1 :style released-button)))) t))

;; Turn habits on at 6am every morning
(run-at-time "06:00" 86400 '(lambda () (setq org-habit-show-habits t)))

(setq org-ghi-interesting-repos '("qdot/libnifalcon" "qdot/liblightstone" "qdot/libtrancevibe" "qdot/emokit" "qdot/libomron" "qdot/libfitbit"))
(setq org-ghi-org-file "~/emacs_org/github.org")
(setq org-ghi-file-under-repo-headline t)

(setq org-mobile-inbox-for-pull "~/emacs_org/tasks.org")
(setq org-mobile-directory "~/Dropbox/MobileOrg")
(setq org-mobile-files '("~/emacs_org/tasks.org" "~/emacs_org/mozilla/B2G.org"))
(setq org-mobile-agendas nil)

(defvar org-agenda-no-resize nil
  "When non-nil, don't let org-mode resize windows for you")

(setq org-agenda-no-resize t)

(defadvice qdot/org-fit-agenda-window (around org-fit-agenda-window-select)
  "Will not let org-fit-agenda-window resize if
org-agenda-no-resize is non-nil"
  (when (not org-agenda-no-resize)
    ad-do-it))

(defadvice qdot/cfw:org-extract-summary (after cfw:org-extract-summary)
  "Remove tags and filenames from item summary"
  (message item))

;; Taken from http://doc.norang.ca/org-mode.html
;;;; Refile settings
; Exclude DONE state tasks from refile targets
(defun qdot/verify-refile-target ()
  "Exclude todo keywords with a done state from refile targets"
  (not (member (nth 2 (org-heading-components)) org-done-keywords)))

(setq org-refile-target-verify-function 'qdot/verify-refile-target)

;; (diminish 'org-indent-mode " i")
;; ============================
;; ============================

;; ;; adding shortcuts
;; (add-hook 'org-mode-hook
;;           (lambda ()
;;             (auto-fill-mode 1)
;;             (local-set-key (kbd "C-c t") 'org-todo)
;;             (local-set-key (kbd "C-c e") 'org-set-effort)
;;             (local-set-key (kbd "C-c i") 'ra/gtd-inbox)
;;             (local-set-key (kbd "C-c C-r") 'org-decrypt-entry)))

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; Org-mode and remember
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ;; We also want to be able to encrypt subtrees in org-mode, requires
;; ;; the epa-setup package
;; (require 'org-crypt)
;; (org-crypt-use-before-save-magic)
;; (setq org-crypt-key "93A4BE9DEAB7218E")

;; (setq org-priority-faces
;;       '(("A" . (:foreground "red" :weight bold))
;;         ("B" . (:foreground "green" :weight bold))
;;         ("C" . (:foreground "blue" :weight bold)))
;;       )

;; Some people view a TODO item that has been scheduled for execution
;; or have a deadline (see Timestamps) as no longer open. Configure
;; the variables org-agenda-todo-ignore-scheduled,
;; org-agenda-todo-ignore-deadlines, org-agenda-todo-ignore-timestamp
;; and/or org-agenda-todo-ignore-with-date to exclude such items from
;; the global TODO list.


;; TODO items may have sublevels to break up the task into
;; subtasks. In such cases it may be enough to list only the highest
;; level TODO headline and omit the sublevels from the global
;; list. Configure the variable org-agenda-todo-list-sublevels to get
;; this behavior.

;; C-c a M     (org-tags-view)
;;     Like C-c a m, but only select headlines that are also TODO
;;     items in a not-DONE state and force checking subitems (see
;;     variable org-tags-match-list-sublevels). To exclude
;;     scheduled/deadline items, see the variable
;;     org-agenda-tags-todo-honor-ignore-options. Matching specific
;;     TODO keywords together with a tags match is also possible, see
;;     Tag searches.

;; (setq org-agenda-custom-commands
;;       '(("W" "Work"
;;   ((agenda)
;;    (tags-todo "WORK")
;;    (tags-todo "SCHEDULED")))))

;; (provide 'setup-org)


;; (defun myorg-update-parent-cookie ()
;;   (when (equal major-mode 'org-mode)
;;     (save-excursion
;;       (org-back-to-heading)
;;       (org-update-parent-todo-statistics))))

;; (defadvice org-kill-line (after fix-cookies activate)
;;   (myorg-update-parent-cookie))

;; (defadvice kill-whole-line (after fix-cookies activate)
;;   (myorg-update-parent-cookie))

;; (setq calendar-date-style 'iso
;;       diary-show-holidays-flag nil
;;       calendar-week-start-day 1
;;       calendar-mark-diary-entries-flag t)



;; (setq org-agenda-include-diary t
;;       org-agenda-include-all-todo t
;;       org-columns-default-format "%60ITEM %TODO %TAGS %6effort(EFFORT){:}"
;;       org-tags-column -90)

;; ;; custom agenda commands
;; (setq org-agenda-custom-commands
;;       '(("i" "Inbox entries" tags "CATEGORY=\"Stuff\"")))

;; ;; higiligt the cursor row in agenda view
;; (add-hook 'org-agenda-mode-hook
;;           (lambda ()
;;             (hl-line-mode t)
;;             (local-set-key (kbd "r") 'org-agenda-refile)
;;             (local-set-key (kbd "R") 'org-agenda-redo)))

(setq org-replace-disputed-keys t);; org-mode: Don't ruin S-arrow to switch windows please (use M-+ and M-- instead to toggle)
(setq org-src-fontify-natively t);; Fontify org-mode code blocks

;;; rc-org-temp.el ends here
