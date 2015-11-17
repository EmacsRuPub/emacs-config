;; -*- coding: utf-8 -*-
;;
;; Filename: rc-org-mode.el
;; Created:  Fri May 24 22:41:54 2013 +0400
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package icalendar)
(use-package org-footnote)
(use-package org-magit :ensure t)
(use-package org-pomodoro :ensure t)

(setq org-modules
      '(<C>org-pomodoro
        org-agenda org-archive org-attach org-bbdb org-bibtex
        org-bookmark org-checklist org-clock org-collector org-docview
        org-drill org-expiry org-habit org-id org-info org-inlinetask
        org-interactive-query org-irc org-man org-mouse org-protocol
        org-timer org-w3m))

(use-package org)
(use-package ox-html)
(use-package org-dashboard :ensure t)
(use-package orgit :ensure t)
(use-package org-bullets :ensure t)

(use-package orglink
  :ensure t
  :config
  ;; TODO: customize orglink-activate-in-modes
  (global-orglink-mode)
  (diminish 'orglink-mode "OL"))

(use-package org-linkany
  :ensure t)

(add-to-list 'file-coding-system-alist (cons "\\.\\(org\\|org_archive\\|/TODO\\)$"  'utf-8))

(f-entries (at-org-dir)
           (lambda (entry) (when (and (f-file? entry)
                                      (s-suffix? "org" entry)
                                      (file-exists-p entry))
                             (push entry org-agenda-files)))
           t)

;TODO: maybe do it less straightforward
(add-to-list 'org-agenda-files (at-config-basedir "todo.org"))
(add-to-list 'org-agenda-files (at-config-basedir "totry.org"))
(add-to-list 'org-agenda-files (at-homedir "/.stumpwm.d/todo.org"))

(add-to-list 'org-speed-commands-user '("x" org-todo "DONE"))
(add-to-list 'org-speed-commands-user '("y" org-todo-yesterday "DONE"))
(add-to-list 'org-speed-commands-user '("s" call-interactively 'org-schedule))
(add-to-list 'org-speed-commands-user '("i" call-interactively 'org-clock-in))
(add-to-list 'org-speed-commands-user '("o" call-interactively 'org-clock-out))
(add-to-list 'org-speed-commands-user '("$" call-interactively 'org-archive-subtree))

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
(setq org-attach-directory (at-org-dir "org-attach-data"))
(setq org-blank-before-new-entry '((heading) (plain-list-item . auto)))
(setq org-clock-history-length 35)
(setq org-clock-idle-time 3)
(setq org-clock-in-switch-to-state "GOING")
(setq org-clock-into-drawer "CLOCK")
(setq org-clock-out-remove-zero-time-clocks t)
(setq org-id-locations-file (at-data-dir "/.org-id-locations"))
(setq org-clock-persist-file (at-data-dir "/org-clock-save.el"))
(setq org-clock-persist t)
(setq org-columns-default-format "%42ITEM %TODO %3Effort(E){:} %3CLOCKSUM_T(R) %SCHEDULED")
;; (setq org-columns-default-format "%50ITEM %12SCHEDULED %TODO %3PRIORITY %Effort{:} %TAGS")
(setq org-confirm-elisp-link-function 'y-or-n-p)
(setq org-ctrl-k-protect-subtree t)
(setq org-cycle-include-plain-lists 'integrate)
(setq org-cycle-separator-lines 0)
(setq org-deadline-warning-days 14)
(setq org-default-notes-file custom/org-capture-file)
(setq org-ditaa-jar-path (at-config-basedir "resources/ditaa0_9.jar"))
(setq org-enforce-todo-checkbox-dependencies t)
(setq org-enforce-todo-dependencies t)  ;;TODO: try ORDERED/NOBLOCKING props : org-toggle-ordered-property
(setq org-track-ordered-property-with-tag t)
(setq org-extend-today-until 2)
(setq org-fast-tag-selection-single-key 'expert)
(setq org-fontify-done-headline t)
(setq org-global-properties '(("STYLE_ALL" . "habit")))
(setq org-habit-graph-column 50)
;; (setq org-habit-show-habits-only-for-today nil)
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
(setq org-special-ctrl-a/e t)
(setq org-special-ctrl-k t)
(setq org-src-fontify-natively t)
(setq org-startup-folded nil)
(setq org-stuck-projects '("+LEVEL=1/-DONE" ("TODO" "GOING" "NEXT" "WAITING" "HOLD" "CANCELLED") nil ""))
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
(setq org-use-effective-time t)
(setq org-goto-max-level 10)
(setq org-use-speed-commands 'custom/org-use-speed-commands-for-headings-and-lists)
(setq org-agenda-inhibit-startup t)
(setq org-agenda-use-tag-inheritance t)
(setq org-agenda-show-log t)
(setq org-agenda-skip-deadline-prewarning-if-scheduled 'pre-scheduled)
(setq org-ellipsis "⤵")

(setq kw-seq-common '(sequence "TODO(t)" "GOING(g!)" "NEXT(x)" "WAITING(w@/!)" "HOLD" "SOMEDAY(s@)"
                  "|" "DONE(d!/@)" "CANCELLED(c@/!)"))
(setq org-todo-keywords
      `(,kw-seq-common))
(setq org-todo-keywords-for-agenda '("TODO(t)" "WAITING(w)" "HOLD(h)" "GOING(g)" "NEXT(x)"))
(setq org-done-keywords-for-agenda '("DONE(d)" "CANCELLED(c)"))
(setq org-agenda-time-grid
      '((daily today require-timed remove-match)
        "----------------"
        (930 1000 1200 1400 1600 1800 2000 2200 2400 2500)))
(setq org-todo-keyword-faces
      '(("TODO" . (:foreground "red" :weight bold))
        ("WAITING" . (:foreground "orange" :weight bold))
        ("HOLD" . (:foreground "yellow" :weight bold))
        ("CANCELLED" . (:foreground "cyan" :weight bold))
        ("DONE" . (:foreground "green" :weight bold))))
(setq org-priority-faces
      '((?A :foreground "red" :weight bold)
        (?B :foreground "#94bff3" :weight bold)
        (?C :foreground "#6f6f6f")))
(setq org-tag-alist '(("current" . ?c)
                      ("reference" . ?f)
                      ("orgmode" . ?g)
                      ("purchase" . ?p)
                      ("master" . ?m)
                      ("ordering" . ?o)
                      ("housekeeping" . ?h)
                      ("entertainment" . ?e)
                      ("interesting" . ?i)
                      ("repair" . ?r)
                      ))
(setq org-tags-exclude-from-inheritance '("project"))
(setq org-agenda-custom-commands
      '(("d" . "some non-straightforward TODO statuses")
        ("dc" todo "SOMEDAY|CANCELLED|CLOSED" nil)
        ("dw" todo "WAITING|LATER" nil)
        ("dg" todo "GOING" nil)
        ("c" . "by context")
        ("cp" tags "+@personal/GOING|WAITING|TODO")
        ("cr" tags "+@project/GOING|WAITING|TODO")
        ("cj" tags "+@job/GOING|WAITING|TODO")
        ("cw" tags "+@workplace/GOING|WAITING|TODO")
        ("ct" tags "+@phonecall/WAITING|TODO")
        ("cs" tags "+@someday")
        ("cq" tags "+@quicknote")
        ("e" . "by essence")
        ;;TODO: find more handy shortcuts
        ("ec" tags "+current")
        ("ef" tags "+reference")
        ("em" tags "+master")
        ("eo" tags "+ordering")
        ("er" tags "+repair")
        ("ed" tags "+develop")
        ("ei" tags "+investigate")
        ("ee" tags "+entertainment")
        ("eh" tags "+housekeeping")
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
        ("P" . "Prioritized tasks")
        ("Pa" "Prioritized tasks A"
         ((tags-todo "+PRIORITY=\"A\"") ))
        ("Pb" "Prioritized tasks B"
         ((tags-todo "+PRIORITY=\"B\"")))
        ("Pc" "Prioritized tasks C"
         ((tags-todo "+PRIORITY=\"C\"")))
        ("S" "Scheduled tasks" agenda ""
         ((org-agenda-time-grid nil)
          (org-deadline-warning-days 32)
          (org-agenda-entry-types '(:scheduled))
          ))
        ("p" tags "+purchase")
        ("b" . "tickets")
        ("be" tags "+ticket+emacs")
        ("bs" tags "+ticket+stumpwm")
        ))

(setq org-capture-templates
      '(("d" "todo")
        ("dp" "personal tasks" entry (file (at-org-dir "/tasks.org")) "* TODO [#C] %? %U :@personal:")
        ("dw" "workplace tasks" entry (file (at-org-dir "/tasks.org")) "* TODO [#C] %? %U :@workplace:")
        ("dc" "phonecalls" entry (file (at-org-dir "/tasks.org")) "* TODO [#C] %? %U :@phonecall:")
        ("dy" "someday" entry (file (at-org-dir "/tasks.org")) "* %? %U :@someday:")
        ("dq" "quick notes (uncategorized)" entry (file (at-org-dir "/refile.org")) "* %? %U :@quicknote:")
        ("de" "emacs todo" entry (file (at-config-basedir "todo.org")) "* TODO [#C] %? %U :emacs:ticket:")
        ("ds" "stumpwm todo" entry (file (at-homedir "/.stumpwm.d/todo.org")) "* TODO [#C] %? %U :stumpwm:ticket:")
        ("t" "try")
        ("tw" "workplace try" entry (file (at-org-dir "/workspace_totry.org")) "* %? %U :@workplace:try")
        ("te" "emacs try" entry (file (at-config-basedir "totry.org")) "* %? %U :emacs:try:")
        ("i" "sink")
        ("ip" "project ideas" entry (file (at-org-dir "/sink.org")) "* %? %U :project/idea:")
        ("ia" "newspaper articles" entry (file (at-org-dir "/sink.org")) "* %? %U :newspaper:toread:")
        ("ic" "code snippet" entry (file (at-org-dir "/sink.org"))
         "* %^{title} %^g :code_snippet:\n :PROPERTIES:\n :CREATED: %U\n :END:\n\n#+BEGIN_SRC %^{lang}\n %i%?\n#+END_SRC\n")
        ("is" "search" entry (file (at-org-dir "/sink.org")) "* %? %U :search:")
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
        ("p" "new project" entry (file (at-org-dir "/projects.org")) "* %? %U :@project:")
        ("j" "job tasks")
        ("jc" "current" entry (file (at-org-dir private/job-tasks-file)) "* TODO %? %U :@job:current:")
        ("jb" "bug" entry (file (at-org-dir private/job-tasks-file)) "* TODO %? %U :@job:bug:")
        ("jr" "reference item" entry (file (at-org-dir private/job-tasks-file)) "* %? %U :@job:reference:")
        ("je" "excalation" entry (file (at-org-dir private/job-tasks-file)) "* TODO %? %U :@job:escalation:")
        ("jp" "patching" entry (file (at-org-dir private/job-tasks-file)) "* TODO %? %U :@job:patching:")
        ("l" "journal (test mode)" entry (file+datetree (at-org-dir "/journal.org")) "* %? %U")
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

(set-face-attribute 'org-done nil :foreground "PaleGreen" :weight 'normal :strike-through t)
(set-face-attribute 'org-headline-done nil :foreground "LightSalmon" :weight 'normal :strike-through t)

(appt-activate t)
(run-at-time "00:59" 3600 'org-save-all-org-buffers)
(org-add-link-type "tag" 'custom/follow-tag-link)
(ignore-errors (org-agenda-to-appt))
(add-hook 'org-finalize-agenda-hook 'org-agenda-to-appt)
(org-clock-persistence-insinuate) ;; Resume clocking tasks when emacs is restarted
(run-at-time "06:00" 86400 '(lambda () (setq org-habit-show-habits t)))
(run-with-idle-timer 300 t 'custom/jump-to-org-agenda)
(set-charset-priority 'unicode)
(turn-on-orgtbl)

(add-hook 'org-mode-hook 'turn-on-font-lock)
(add-hook 'org-mode-hook 'org-bullets-mode)
(add-hook 'org-after-todo-state-change-hook 'custom/org-todo-changed-hook)
(add-hook 'org-clock-out-hook 'custom/remove-empty-drawer-on-clock-out 'append)
(add-hook 'org-after-refile-insert-hook 'save-buffer)

(defhydra hydra-org-sandbox ()
  ("c" org-table-create)
  ("s" org-sparse-tree))

(defhydra hydra-org-global (:color teal)
  "
^Navigation^               ^Agenda^                  ^Clock^             ^Properties^        ^Capture^
---------------------------------------------------------------------------------------------------------------
_<up>_:     up heading     show _a_genda             _._ clock in        set _p_roperty      captur_e_
_C-<down>_: next heading   _s_chedule                _,_ clock out       _d_elete property   _w_ store link
_C-<up>_:   prev heading   dead_l_ine                cloc_k_ display                       _y_ insert link
ace-link for _o_rg         agenda _c_olumns          _g_oto last clock
_O_pen at point            foot_n_ote action         estimate effor_t_
show _A_ll                 add t_i_me to timestamp   _c_ancel clock
                                                 clock _r_eport
                                                 po_m_odoro
"
  ("<up>" outline-up-heading "")
  ("C-<down>" outline-next-heading "")
  ("C-<up>" outline-previous-heading "")
  ("g" org-clock-goto)
  ("p" org-set-property)
  ("d" org-delete-property)
  ("D" org-dashboard-display :color blue)
  ("s" org-schedule :color blue)
  ("l" org-deadline :color blue)
  ("." org-clock-in)
  ("," org-clock-out)
  ("t" org-clock-modify-effort-estimate)
  ("c" org-clock-cancel)
  ("r" org-clock-report)
  ("?" (org-info "Clocking commands"))
  ("k" org-clock-display)
  ("n" org-footnote-action)
  ("w" org-store-link)
  ("y" org-insert-link)
  ("i" custom/org-update-timestamp-with-time)
  ("o" ace-link-org :color blue)
  ("O" custom/open-or-browse-at-point)
  ("e" org-capture :color blue)
  ("a" org-agenda :color blue)
  ("A" show-all)
  ("t" org-toggle-timestamp-type)
  ("m" org-pomodoro)
  ("r" (custom/with-major-mode 'org-mode (org-refile)) "refile")
  ("q" nil "cancel"))
(global-set-key (kbd "<f7>") 'hydra-org-global/body)

(defhydra hydra-org-movement (:color red :columns 3)
  "Org Mode Movements"
  ("n" outline-next-visible-heading "next heading")
  ("p" outline-previous-visible-heading "prev heading")
  ("N" org-forward-heading-same-level "next heading at same level")
  ("P" org-backward-heading-same-level "prev heading at same level")
  ("u" outline-up-heading "up heading")
  ("g" org-goto "goto" :exit t))
;;TODO: bind hydra-org-movement to a key

(define-key org-agenda-mode-map (kbd "<f7> .") 'org-agenda-clock-in)
(define-key org-agenda-mode-map (kbd "<f7> ,") 'org-agenda-clock-out)
(define-key org-agenda-mode-map (kbd "<f7> o") 'ace-link-org)
(define-key org-mode-map (kbd "M-o") 'ace-link-org)

(define-key org-mode-map (kbd "C-'") nil)
(define-key org-mode-map (kbd "C-c [") nil)
(define-key org-mode-map (kbd "C-c ]") nil)
(define-key org-mode-map (kbd "C-c C-o") nil)

(global-set-key (kbd "C-c r o") '(lambda () ;;TODO: make hydra for such custom helm sources
                                   (interactive)
                                   (helm :sources '(custom/helm-source-org-files))))


(org-babel-do-load-languages
 'org-babel-load-languages
 '((css . t)
   (dot . t)
   (ditaa . t)
   (emacs-lisp . t)
   (js . t)
   (latex . t)
   (org . t)
   (plantuml . t)
   (R . t)
   (scheme . t)
   (sh . t)))

(provide 'rc-org-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-org-mode.el ends here
