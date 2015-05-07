;; -*- coding: utf-8 -*-
;;
;; Filename: rc-org-mode.el
;; Created:  Fri May 24 22:41:54 2013 +0400
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(autoload 'icalendar-import-buffer "icalendar" "Import iCalendar data from current buffer" t)
(autoload 'org-footnote-action "org-footnote" nil t)
(autoload 'orgtbl-mode "org" "Org tables as a minor mode" t)
(autoload 'turn-on-orgtbl "org" "Org tables as a minor mode")

(setq org-modules
      '(org-agenda org-archive org-attach org-bbdb org-bibtex org-bookmark
        org-checklist org-clock org-docview org-expiry org-habit
        org-id org-info org-inlinetask org-irc org-man org-protocol
        <C>org-pomodoro org-timer org-w3m))

(require 'org)
(require 'ox-html)

(add-to-list 'file-coding-system-alist (cons "\\.\\(org\\|org_archive\\|/TODO\\)$"  'utf-8))

(setq org-agenda-files (append (all-files-under-dir-recursively (at-org-dir) "org")))
;TODO: maybe do it less straightforward
(add-to-list 'org-agenda-files (at-config-basedir "todo.org"))
(add-to-list 'org-agenda-files (at-config-basedir "totry.org"))
(add-to-list 'org-agenda-files "/home/octocat/.stumpwm.d/todo.org")

(setq calendar-date-style 'european)
(setq org-agenda-dim-blocked-tasks 'invisible)
(setq org-agenda-include-all-todo t)
(setq org-agenda-repeating-timestamp-show-all nil)
(setq org-agenda-show-all-dates t)
(setq org-agenda-show-inherited-tags nil)
(setq org-agenda-skip-deadline-if-done t)
(setq org-agenda-skip-scheduled-if-done t)
(setq org-agenda-skip-timestamp-if-done t)
(setq org-agenda-span 'month)
(setq org-agenda-start-on-weekday nil)
(setq org-agenda-sticky nil)            ;otherwise agenda behaves strangely on non-stuck projects
(setq org-agenda-tags-todo-honor-ignore-options t)
(setq org-agenda-todo-ignore-deadlines 'all)
(setq org-agenda-todo-ignore-scheduled 'all)
(setq org-agenda-todo-ignore-timestamp 'past)
(setq org-agenda-todo-ignore-with-date t)
(setq org-agenda-todo-list-sublevels nil)
(setq org-align-all-tags t)
(setq org-attach-directory "org-attach-data")
(setq org-blank-before-new-entry '((heading) (plain-list-item . auto)))
(setq org-clock-history-length 35)
(setq org-clock-idle-time 3)
(setq org-clock-in-switch-to-state "GOING")
(setq org-clock-into-drawer "CLOCK")
(setq org-clock-out-remove-zero-time-clocks t)
(setq org-clock-persist t)
(setq org-columns-default-format "%42ITEM %TODO %3Effort(E){:} %3CLOCKSUM_T(R) %SCHEDULED")
(setq org-confirm-elisp-link-function 'y-or-n-p)
(setq org-ctrl-k-protect-subtree t)
(setq org-cycle-include-plain-lists 'integrate)
(setq org-cycle-separator-lines 0)
(setq org-deadline-warning-days 14)
(setq org-default-notes-file custom/org-capture-file)
(setq org-ditaa-jar-path (at-config-basedir "resources/ditaa0_9.jar"))
(setq org-enforce-todo-checkbox-dependencies t)
(setq org-enforce-todo-dependencies t)
(setq org-extend-today-until 2)
(setq org-fast-tag-selection-single-key 'expert)
(setq org-fontify-done-headline t)
(setq org-global-properties '(("STYLE_ALL" . "habit")))
(setq org-habit-graph-column 50)
(setq org-hide-leading-stars t)
(setq org-indirect-buffer-display 'current-window)
(setq org-insert-mode-line-in-empty-file t)
(setq org-log-done t)
(setq org-log-into-drawer t)
(setq org-loop-over-headlines-in-active-region t)
(setq org-outline-path-complete-in-steps nil)
(setq org-refile-allow-creating-parent-nodes 'confirm)
(setq org-refile-target-verify-function 'custom/verify-refile-target)
(setq org-refile-targets '((org-agenda-files :maxlevel . 5) (nil :maxlevel . 5)))
(setq org-refile-use-outline-path 'file)
(setq org-return-follows-link t)
(setq org-reverse-note-order t)
(setq org-special-ctrl-a/e t)
(setq org-special-ctrl-k t)
(setq org-src-fontify-natively t)
(setq org-startup-folded nil)
(setq org-stuck-projects '("+LEVEL=1/-DONE" ("TODO" "GOING" "NEXT" "WAITING" "CANCELLED") nil ""))
(setq org-tags-column -80)
(setq org-use-property-inheritance t)
(setq org-use-speed-commands t)
(setq org-use-sub-superscripts nil)
(setq org-agenda-restore-windows-after-quit t)
(setq org-agenda-window-setup 'only-window)
(setq org-yank-adjusted-subtrees t)
(setq org-read-date-prefer-future 'time)
(setq org-export-coding-system 'utf-8)
(setq org-agenda-skip-additional-timestamps-same-entry t)
(setq org-agenda-persistent-filter t)
(setq appt-message-warning-time 10)
(setq appt-display-interval 5)

(setq kw-seq-common '(sequence "TODO(t)" "GOING(g!)" "NEXT(x)" "WAITING(w@/!)" "SOMEDAY(s@)"
                  "|" "DONE(d!/@)" "CANCELLED(c@/!)"))
(setq org-todo-keywords
      `(,kw-seq-common))
(setq org-todo-keywords-for-agenda '("TODO(t)" "WAITING(w)" "GOING(g)" "NEXT(x)"))
(setq org-done-keywords-for-agenda '("DONE(d)" "CANCELLED(c)"))
(setq org-agenda-time-grid
      '((daily today require-timed remove-match)
        "----------------"
        (930 1000 1200 1400 1600 1800 2000 2200 2400 2500)))
(setq org-todo-keyword-faces
      '(("TODO" . (:foreground "red" :weight bold))
        ("WAITING" . (:foreground "orange" :weight bold))
        ("CANCELLED" . (:foreground "cyan" :weight bold))
        ("DONE" . (:foreground "green" :weight bold))))
(setq org-priority-faces
      '((?A :foreground "red" :weight bold)
        (?B :foreground "#94bff3" :weight bold)
        (?C :foreground "#6f6f6f")))
(setq org-tag-alist '(("current" . ?c)
                      ("orgmode" . ?g)
                      ("purchase" . ?p)
                      ("master" . ?m)
                      ("process" . ?r)
                      ("ordering" . ?o)
                      ("home_improvements" . ?h)
                      ("entertainment" . ?e)
                      ("interesting" . ?i)
                      ("fix" . ?f)
                      ))
(setq org-tags-exclude-from-inheritance '("project"))
(setq org-agenda-custom-commands
      '(("d" . "some non-straightforward TODO statuses")
        ("dc" todo "SOMEDAY|CANCELLED|CLOSED" nil)
        ("dw" todo "WAITING|LATER" nil)
        ("dg" todo "GOING" nil)
        ("c" . "by context")
        ("ch" tags "+@home/GOING|WAITING|TODO")
        ("co" tags "+@work/GOING|WAITING|TODO")
        ("cw" tags "+@workplace/GOING|WAITING|TODO")
        ("cj" tags "+@journey/GOING|WAITING|TODO")
        ("cp" tags "+@phonecall/GOING|WAITING|TODO")
        ("cs" tags "+@someday")
        ("e" . "by essence")
        ("ec" tags "+current")
        ("em" tags "+master")
        ("eo" tags "+ordering")
        ("ef" tags "+fix")
        ("ed" tags "+develop")
        ("ei" tags "+investigate")
        ("ee" tags "+entertainment")
        ("u" . "unassigned")
        ("uu" alltodo "Unscheduled TODO entries"
         ((org-agenda-skip-function
           (lambda nil
             (org-agenda-skip-entry-if 'scheduled 'deadline 'regexp "<[^>\n]+>")))
          (org-tags-match-list-sublevels 'indented)
          (org-agenda-sorting-strategy
           '((agenda priority-down todo-state-up tag-up) ))
          (org-agenda-overriding-header "Unscheduled TODO entries: ")))
        ("up" alltodo "Unprioritized TODO entries"
         ((org-agenda-skip-function
           (lambda nil
             (org-agenda-skip-entry-if 'regexp "\\[#[ABC]]")))
          (org-tags-match-list-sublevels 'indented)
          (org-agenda-sorting-strategy
           '((agenda time-up tag-up) ))
          ;; '(org-agenda-sorting-strategy '((agenda time-up priority-down tag-up) (todo tag-up)))
          (org-agenda-overriding-header "Unprioritized TODO entries: ")))
        ("u" . "unassigned")
        ("P" . "Prioritized tasks")
        ("Pa" "Prioritized tasks A"
         ((tags-todo "+PRIORITY=\"A\"") ))
        ("Pb" "Prioritized tasks B"
         ((tags-todo "+PRIORITY=\"B\"")))
        ("Pc" "Prioritized tasks C"
         ((tags-todo "+PRIORITY=\"C\"")))
        ("p" tags "+purchase")
        ("t" . "tickets")
        ("te" tags "+ticket+emacs")
        ("ts" tags "+ticket+stumpwm")
        ))

(setq org-capture-templates
      '(("d" "todo")
        ("dh" "tasks at home" entry (file (at-org-dir "/tasks.org")) "* TODO [#C] %? %U :@home:")
        ("do" "tasks at work" entry (file (at-org-dir "/tasks.org")) "* TODO [#C] %? %U :@work:")
        ("dw" "workplace tasks" entry (file (at-org-dir "/tasks.org")) "* TODO [#C] %? %U :@workplace:")
        ("dy" "workplace try" entry (file (at-org-dir "/workspace_totry.org")) "* TODO [#C] %? %U :@workplace:try")
        ("dj" "tasks on the way" entry (file (at-org-dir "/tasks.org")) "* TODO [#C] %? %U :@journey:")
        ("dp" "phonecalls" entry (file (at-org-dir "/tasks.org")) "* TODO [#C] %? %U :@phonecall:")
        ("ds" "someday" entry (file (at-org-dir "/tasks.org")) "* %? %U :@someday:")
        ("de" "emacs")
        ("det" "emacs todo" entry (file (at-config-basedir "todo.org")) "* TODO [#C] %? %U :emacs:ticket:")
        ("dey" "emacs try" entry (file (at-config-basedir "totry.org")) "* TODO [#C] %? %U :emacs:try:")
        ("i" "sink")
        ("ip" "project ideas" entry (file (at-org-dir "/sink.org")) "* %? %U :project/idea:")
        ("in" "job notes" entry (file (at-org-dir "/sink.org")) "* %? %U :@work:note:")
        ("ia" "newspaper articles" entry (file (at-org-dir "/sink.org")) "* %? %U :newspaper:toread:")
        ("il" "side links" entry (file (at-org-dir "/sink.org")) "* %? %U :side_link:")
        ("ic" "code snippet" entry (file (at-org-dir "/sink.org"))
         "* %^{title} %^g :code_snippet:\n :PROPERTIES:\n :CREATED: %U\n :END:\n\n#+BEGIN_SRC %^{lang}\n %i%?\n#+END_SRC\n")
        ("is" "search")
        ("isb" "book" entry (file (at-org-dir "/sink.org")) "* TODO %? %U :search:book:")
        ("isf" "food" entry (file (at-org-dir "/sink.org")) "* TODO %? %U :search:food:")
        ("ist" "token" entry (file (at-org-dir "/sink.org")) "* TODO %? %U :search:token:")
        ("isl" "by link" entry (file (at-org-dir "/sink.org")) "* TODO %? %U :search:link:")
        ("b" "browser tabs")
        ("bc" "common" entry (file+olp (at-org-dir "/browser-tabs.org") "inbox" "common") "* TODO [#C] %? %U :browser_tab:")
        ("be" "emacs" entry (file+olp (at-org-dir "/browser-tabs.org") "inbox" "emacs") "* TODO [#C] %? %U :browser_tab:emacs:")
        ("bn" "news" entry (file+olp (at-org-dir "/browser-tabs.org") "inbox" "news") "* TODO [#C] %? %U :browser_tab:news:")
        ("bv" "video" entry (file+olp (at-org-dir "/browser-tabs.org") "inbox" "video") "* TODO [#C] %? %U :browser_tab:video:")
        ("bb" "blogs" entry (file+olp (at-org-dir "/browser-tabs.org") "inbox" "blogposts") "* TODO [#C] %? %U :browser_tab:blogpost:")
        ("br" "review" entry (file+olp (at-org-dir "/browser-tabs.org") "inbox" "review") "* TODO [#C] %? %U :browser_tab:review:")
        ("t" "tickets")
        ("tx" "xmonad tickets" entry (file+headline (at-homedir "/.xmonad/todo.org")) "* TODO [#C] %? %U :xmonad:ticket:")
        ("ts" "stumpwm tickets" entry (file (at-homedir "/.stumpwm.d/todo.org")) "* TODO [#C] %? %U :stumpwm:ticket:")
        ("tv" "vim config tickets" entry (file (at-homedir "/workspace/configs/vim-config/todo.org")) "* TODO [#C] %? %U :vim:config:ticket:")
        ("l" "links" entry (file (at-org-dir "/links.org")) "* %? %U :links:send:")
        ("g" "github")
        ("gc" "common" entry (file (at-org-dir "/github.org")) "* %? %U :github:")
        ("gd" "dotfiles" entry (file (at-org-dir "/github.org")) "* %? %U :github:dotfiles:")
        ("ge" "emacs config" entry (file (at-org-dir "/github.org")) "* %? %U :github:emacs-config:")
        ("ga" "awesome config" entry (file (at-org-dir "/github.org")) "* %? %U :github:awesome-config:")
        ("gs" "stumpwm config" entry (file (at-org-dir "/github.org")) "* %? %U :github:stumpwm-config:")
        ("gl" "CL repo to review" entry (file+olp (at-org-dir "/mastering.org") "languages" "Common Lisp" "repos") "* %? %U :github:common_lisp:")
        ("g5" "Starred repos" entry (file (at-org-dir "/github.org")) "* %? %U :github:starred:")
        ("m" "mastering" entry (file+headline (at-org-dir "/mastering.org") "inbox") "* %? %U")
        ("p" "new project" entry (file (at-org-dir "/projects.org")) "* %? %U :project:")
        ("l" "journal (test mode)" entry (file+datetree (at-org-dir "/journal.org")) "* %? %U")
        ("j" "job tasks")
        ("jc" "current" entry (file (at-org-dir private/job-tasks-file)) "* TODO %? %U :current:")
        ("jr" "reference item" entry (file (at-org-dir private/job-tasks-file)) "* %? %U :reference:")
        ("je" "excalation" entry (file (at-org-dir private/job-tasks-file)) "* TODO %? %U :escalation:")
        ("jp" "patching" entry (file (at-org-dir private/job-tasks-file)) "* TODO %? %U :patching:")
        ))
(setq org-list-demote-modify-bullet '(("+" . "-")
                                      ("*" . "-")
                                      ("1." . "-")
                                      ("1)" . "-")
                                      ("A)" . "-")
                                      ("B)" . "-")
                                      ("a)" . "-")
                                      ("b)" . "-")
                                      ("A." . "-")
                                      ("B." . "-")
                                      ("a." . "-")
                                      ("b." . "-")))

(setq holiday-orthodox-holidays nil) ; Orthodox holidays to some extent
(setq holiday-personal-holidays nil) ; personal anniversaries, etc.

(setq holiday-other-holidays
      (append holiday-orthodox-holidays holiday-personal-holidays))

(setq calendar-holidays
  (append holiday-other-holidays
          holiday-solar-holidays))

(appt-activate t)
(run-at-time "00:59" 3600 'org-save-all-org-buffers)
(load (at-config-basedir "last-scrum-timestamp"))
(org-add-link-type "tag" 'custom/follow-tag-link)
(ignore-errors (org-agenda-to-appt))
(add-hook 'org-finalize-agenda-hook 'org-agenda-to-appt)
(org-clock-persistence-insinuate) ;; Resume clocking tasks when emacs is restarted
(run-at-time "06:00" 86400 '(lambda () (setq org-habit-show-habits t)))
(set-charset-priority 'unicode)

(add-hook 'org-mode-hook 'turn-on-font-lock)
(add-hook 'org-after-todo-state-change-hook 'custom/org-todo-changed-hook)
(add-hook 'org-clock-out-hook 'custom/remove-empty-drawer-on-clock-out 'append)
(add-hook 'org-after-refile-insert-hook 'save-buffer)

(defhydra hydra-org-nav (global-map "C-<f7>")
  "Org navigation"
  ("<up>" outline-up-heading "")
  ("C-<down>" outline-next-heading "")
  ("C-<up>" outline-previous-heading "")
  ("q" nil "cancel"))

(global-set-key (kbd "C-c e") 'org-capture)
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c b") 'org-iswitchb)
(global-set-key (kbd "C-c t c") 'org-table-create)
(global-set-key (kbd "C-c t s") 'org-sparse-tree)
(global-set-key (kbd "C-c t t") 'org-toggle-timestamp-type)
(global-set-key (kbd "C-c t t") 'org-toggle-timestamp-type)
(global-set-key (kbd "C-c m m") 'org-agenda-bulk-mark-all)
(global-set-key (kbd "C-c m u") 'org-agenda-bulk-unmark-all)
(global-set-key (kbd "<f12>") 'org-pomodoro)

(global-set-key (kbd "C-c C-o C-s") 'save-last-scrum-timestamp)
(global-set-key (kbd "C-c C-o C-m") 'mark-with-finished-timestamp)
(global-set-key (kbd "C-c C-o C-d") 'refile-job-done)

(define-key custom-search-keymap (kbd "l") 'helm-org-headlines)

(defhydra hydra-org-global (global-map "<f7>" :hint nil)
  "
^Agenda^                  ^Clock^             ^Properties^        ^Capture^
--------------------------------------------------------------------------------------
_s_chedule                _._ clock in        set _p_roperty      _w_ store link
dead_l_ine                _,_ clock out       _d_elete property   _y_ insert link
agenda _c_olumns          cloc_k_ display
foot_n_ote action         _g_oto last clock
add t_i_me to timestamp
"
  ("g" org-clock-goto)
  ("p" org-set-property)
  ("d" org-delete-property)
  ("s" org-schedule :color blue)
  ("l" org-deadline :color blue)
  ("." org-clock-in)
  ("," org-clock-out)
  ("k" org-clock-display)
  ("c" org-agenda-columns)
  ("n" org-footnote-action)
  ("w" org-store-link)
  ("y" org-insert-link)
  ("i" custom/org-update-timestamp-with-time)
  ("o" ace-link-org :color blue)
  ("q" nil "cancel"))

(define-key org-agenda-mode-map (kbd "<f7> .") 'org-agenda-clock-in)
(define-key org-agenda-mode-map (kbd "<f7> ,") 'org-agenda-clock-out)

(define-key org-mode-map (kbd "C-'") nil)
(define-key org-mode-map (kbd "C-c [") nil)
(define-key org-mode-map (kbd "C-c ]") nil)
(define-key org-mode-map (kbd "C-c C-o") nil)

(define-key org-mode-map (kbd "C-x C-a") 'show-all)
(define-key org-mode-map (kbd "C-c C-o C-l") 'open-or-browse-at-point)

(global-set-key (kbd "C-c r o") '(lambda ()
                                   (interactive)
                                   (helm :sources '(custom/helm-source-org-files))))

(provide 'rc-org-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-org-mode.el ends here
