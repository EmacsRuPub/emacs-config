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

(require 'google-weather)
(require 'org-google-weather)

(require 'org-install)
(require 'org)
(require 'org-agenda)


;#############################################################################
;#   Customizations
;############################################################################
(add-to-list 'file-coding-system-alist (cons "\\.\\(org\\|org_archive\\|/TODO\\)$"  'utf-8))

;; link abbrevs
(add-to-list 'org-link-abbrev-alist '("emacswiki" . "http://www.emacswiki.org/cgi-bin/wiki/"))
(add-to-list 'org-link-abbrev-alist '("google" . "http://www.google.com/search?q="))
(add-to-list 'org-link-abbrev-alist '("ms-spec" . "http://localhost/~ott/data-formats-doc/Microsoft%20Specs/[%s].pdf"))

(setq org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "STARTED(s)" "|" "DONE(d)"
				    "CANCELLED(c)")))

(setq org-todo-keywords-for-agenda '((sequence "TODO(t)" "WAITING(w)" "STARTED(s)")))
(setq org-done-keywords-for-agenda '((sequence "DONE(d)" "CANCELLED(c)")))

(setq org-todo-keyword-faces
      '(("TODO" . (:foreground "red" :weight bold))
	("WAITING" . (:foreground "orange" :weight bold))
	("STARTED" . (:foreground "blue" :weight bold))
	("DONE" . (:foreground "green" :weight bold))
	("CANCELLED" . (:foreground "cyan" :weight bold)))
      )

(setq org-agenda-files (quote ("/mnt/work/org/blog-posts.org"
			       "/mnt/work/org/books/books.org"
			       "/mnt/work/org/books/books_detailed.org"
			       "/mnt/work/org/books/books_toread.org"
			       "/mnt/work/org/checklists/checklists.org"
			       "/mnt/work/org/checklists/download.org"
			       "/mnt/work/org/checklists/from_newspapers.org"
			       "/mnt/work/org/checklists/hospital.org"
			       "/mnt/work/org/checklists/interests.org"
			       "/mnt/work/org/checklists/travel.org"
			       "/mnt/work/org/checklists/wishlist.org"
			       "/mnt/work/org/contacts.org"
			       "/mnt/work/org/dates.org"
			       "/mnt/work/org/job/braintasks.org"
			       "/mnt/work/org/job/job.org"
			       "/mnt/work/org/job/othertasks.org"
			       "/mnt/work/org/job/resume.org"
			       "/mnt/work/org/job/testtasks.org"
			       "/mnt/work/org/ordering.org"
			       "/mnt/work/org/projects/autocad/autocad.org"
			       "/mnt/work/org/projects/autocad/autocad2.org"
			       "/mnt/work/org/projects/boostdc/boostdc.org"
			       "/mnt/work/org/projects/boostdc/boostdc_rpc_eng.org"
			       "/mnt/work/org/projects/config/editors.org"
			       "/mnt/work/org/projects/config/linux-system.org"
			       "/mnt/work/org/projects/config/xmonad.org"
			       "/mnt/work/org/projects/homeprojects.org"
			       "/mnt/work/org/projects/ideas/issue-tracker.org"
			       "/mnt/work/org/projects/ideas/projectideas.org"
			       "/mnt/work/org/projects/learn.org"
			       "/mnt/work/org/projects/mastering/mastering-admin.org"
			       "/mnt/work/org/projects/mastering/mastering-mochiweb.org"
			       "/mnt/work/org/projects/mastering/mastering-vcs.org"
			       "/mnt/work/org/projects/mastering/mastering_proglang.org"
			       "/mnt/work/org/projects/oss/delicious-client.org"
			       "/mnt/work/org/projects/oss/erlang-make.org"
			       "/mnt/work/org/projects/oss/erlang-postgres.org"
			       "/mnt/work/org/projects/oss/feedsaw.org"
			       "/mnt/work/org/projects/oss/gourmet.org"
			       "/mnt/work/org/projects/oss/leechcraft.org"
			       "/mnt/work/org/projects/oss/qross.org"
			       "/mnt/work/org/projects/oss/qxmpp.org"
			       "/mnt/work/org/projects/review.org"
			       "/mnt/work/org/projects/science.org"
			       "/mnt/work/org/recipes.org"
			       "/mnt/work/org/review/review-books.org"
			       "/mnt/work/org/review/review-essays.org"
			       "/mnt/work/org/review/review-infosources.org"
			       "/mnt/work/org/review/review-links.org"
			       "/mnt/work/org/review/review-materials.org"
			       "/mnt/work/org/review/review-media.org"
			       "/mnt/work/org/review/review-software.org"
			       "/mnt/work/org/review/review-tokens.org"
			       "/mnt/work/org/review/review-unsorted.org"
			       "/mnt/work/org/review/review-yandexfotki.org"
			       "/mnt/work/org/search.org"
			       "/mnt/work/org/todo.org"
			       "/mnt/work/org/weather.org"
			       )))

; Targets include this file and any file contributing to the agenda - up to 5 levels deep
(setq org-refile-targets (quote ((org-agenda-files :maxlevel . 5) (nil :maxlevel . 5))))
(setq org-refile-use-outline-path (quote file))
(setq org-refile-allow-creating-parent-nodes (quote confirm))

(setq org-agenda-span 'month)
(setq org-deadline-warning-days 14)
(setq org-agenda-show-all-dates t)
(setq org-agenda-skip-deadline-if-done t)
(setq org-agenda-skip-scheduled-if-done t)
(setq org-agenda-start-on-weekday nil)
(setq org-agenda-include-diary t)
(setq org-agenda-include-all-todo t)
(setq org-reverse-note-order t)
(setq org-fast-tag-selection-single-key (quote expert))
(setq org-startup-folded nil)
(setq org-log-done t)
(setq org-hide-leading-stars t)
(setq org-use-property-inheritance t)
;; (setq org-enforce-todo-dependencies t)
;; (setq org-ctrl-k-protect-subtree t)
(setq org-special-ctrl-a/e t)
(setq org-special-ctrl-k t)
(setq org-blank-before-new-entry (quote ((heading . auto) (plain-list-item))))
(setq org-agenda-dim-blocked-tasks 'invisible)
(setq org-enforce-todo-checkbox-dependencies t)

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
		(org-agenda-overriding-header "Unscheduled TODO entries: "))))))

(setq org-insert-mode-line-in-empty-file t)
(setq org-log-done t) ;; read documentation
(setq appt-disp-window-function (function org-osd-display))
(setq appt-display-format 'window) ;; Update appt each time agenda opened.
;; 5 minute warning
(setq appt-message-warning-time '60)
(setq appt-display-interval '15)
;; drawing diagrams with ditaa
(setq org-ditaa-jar-path "~/.emacs.d/resources/ditaa0_9.jar")


;#############################################################################
;#   Custom definitions
;############################################################################
(defun org-osd-display (min-to-app new-time msg)
  (osd-display msg msg -1 "center" "center" "Verdana 40"))

(defun custom/org-agenda-to-appt ()
  (interactive)
  (setq appt-time-msg-list nil)
  (org-agenda-to-appt))

;; on screen display
(defun org-osd-display (min-to-app new-time msg)
  (osd-display msg msg -1 "center" "center" "Verdana 40")
  )

;; on screen display
(defun org-osd-display (min-to-app new-time msg)
  (osd-display msg msg -1 "center" "center" "Verdana 40")
  )


;#############################################################################
;#   Setup
;############################################################################
(custom/org-agenda-to-appt)
(appt-activate t)
;; Run once, activate and schedule refresh
(run-at-time "00:59" 3600 'org-save-all-org-buffers)
(run-at-time "24:01" nil 'custom/org-agenda-to-appt)
(run-at-time nil 3600 'org-agenda-to-appt)


;#############################################################################
;#   Hooks
;############################################################################
(defun custom/org-mode-hook ()
  (local-set-key "\C-x\C-a" 'show-all)
  (imenu-add-to-menubar "Imenu")
  (icy-mode 0)
  ;; (make-variable-buffer-local 'yas/trigger-key)
  ;; (setq yas/trigger-key [tab])
  ;; (local-set-key [tab] 'yas/expand)
  ;; (define-key yas/keymap [tab] 'yas/next-field-group)
  )

(add-hook 'org-mode-hook 'custom/org-mode-hook)
(add-hook 'org-mode-hook 'turn-on-font-lock)
(add-hook 'diary-display-hook 'fancy-diary-display)
;; (add-hook 'org-finalize-agenda-hook 'custom/org-agenda-to-appt) ;; org + appt ;; Run once, activate and schedule refresh
;; (add-hook 'org-finalize-agenda-hook 'org-agenda-to-appt) ;; Update appt each time agenda opened.
;; (add-hook 'org-mode-hook 'turn-on-org-cdlatex) ;; doesn't work now


;#############################################################################
;#   Keybindings
;############################################################################
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(global-set-key "\C-c\C-o\C-l" 'org-agenda-open-link)
(global-set-key "\C-ctc" 'org-table-create)
(global-set-key "\C-cts" 'org-sparse-tree)
(global-set-key "\C-ctt" 'org-toggle-timestamp-type)

;;; emacs-rc-org-mode.el ends here
