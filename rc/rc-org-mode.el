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
(require 'org-contacts)

(require 'defun-org-mode)


;#############################################################################
;#   Customizations
;############################################################################
(add-to-list 'file-coding-system-alist (cons "\\.\\(org\\|org_archive\\|/TODO\\)$"  'utf-8))

;; link abbrevs
(add-to-list 'org-link-abbrev-alist '("emacswiki" . "http://www.emacswiki.org/cgi-bin/wiki/"))
(add-to-list 'org-link-abbrev-alist '("google" . "http://www.google.com/search?q="))



(setq org-todo-keywords
      '((sequence "TODO(t)" "GOING(g)" "PAUSE(p)" "WAITING(w@)" "STARTED(s)" "LATER(l)"
                  "|" "DONE(d!/@)" "SOMEDAY(s)" "CANCELLED(c@)")))

(setq org-todo-keywords-for-agenda '((sequence "TODO(t)" "WAITING(w)" "STARTED(s)")))
(setq org-done-keywords-for-agenda '((sequence "DONE(d)" "CANCELLED(c)")))

(setq org-agenda-time-grid
      '((daily today require-timed remove-match)
        "----------------"
        (930 1000 1200 1400 1600 1800 2000 2200 2400 2500)))

;;       org-tag-alist
;;       '(("@home" . ?h)
;;         ("@office" . ?o)
;;         ("@phone" . ?p)
;;         ("@cms" . ?w)
;;         ("@computer" . ?c)
;;         ("@errands" . ?e)
;;         ("@bvc" . ?b)
;;         ("@ltlunch" . ?l)
;;         ("@2020" . ?2)
;;         ("someday" . ?s)
;;         ("@gul" . ?g)
;;         ("flov" . ?f))


(setq org-todo-keyword-faces
      '(("TODO" . (:foreground "red" :weight bold))
        ("WAITING" . (:foreground "orange" :weight bold))
        ("STARTED" . (:foreground "blue" :weight bold))
        ("DONE" . (:foreground "green" :weight bold))
        ("CANCELLED" . (:foreground "cyan" :weight bold)))
      )
(setq org-priority-faces
      '((?A :foreground "red" :weight bold)
        (?B :foreground "#94bff3" :weight bold)
        (?C :foreground "#6f6f6f")))

(setq org-agenda-files (all-files-under-dir-recursively org-dir "org"))

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
;; (setq appt-disp-window-function (function org-osd-display))
;; (setq appt-display-format 'window) ;; Update appt each time agenda opened.
;; 5 minute warning
;; (setq appt-message-warning-time '60)
;; (setq appt-display-interval '15)
;; drawing diagrams with ditaa
(setq org-ditaa-jar-path (concat config-basedir "resources/ditaa0_9.jar"))


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
  (local-set-key (kbd "C-x C-a") 'show-all)
  (imenu-add-to-menubar "Imenu")
  ;; (make-variable-buffer-local 'yas/trigger-key)
  ;; (setq yas/trigger-key (kbd "<tab>"))
  ;; (local-set-key (kbd "<tab>") 'yas/expand)
  ;; (define-key yas/keymap (kbd "<tab>") 'yas/next-field-group)
  )

(defun custom/org-todo-changed-hook ()
  "Remove :current: tag, when DONE"
  ;; TODO generalize
  (let ((tags (org-get-tags)))
    (when (and (equal org-state "DONE")
               (member "current" tags))
      (org-set-tags-to (delete "current" tags)))))

(add-hook 'org-mode-hook 'custom/org-mode-hook)
(add-hook 'org-mode-hook 'turn-on-font-lock)
(add-hook 'diary-display-hook 'fancy-diary-display)
;; (add-hook 'org-finalize-agenda-hook 'custom/org-agenda-to-appt) ;; org + appt ;; Run once, activate and schedule refresh
;; (add-hook 'org-finalize-agenda-hook 'org-agenda-to-appt) ;; Update appt each time agenda opened.
;; (add-hook 'org-mode-hook 'turn-on-org-cdlatex) ;; doesn't work now
(add-hook 'org-after-todo-state-change-hook 'custom/org-todo-changed-hook)


;#############################################################################
;#   Keybindings
;############################################################################
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c b") 'org-iswitchb)
;; (global-set-key (kbd "C-c C-o C-l") 'org-agenda-open-link)
(global-set-key (kbd "C-c t c") 'org-table-create)
(global-set-key (kbd "C-c t s") 'org-sparse-tree)
(global-set-key (kbd "C-c t t") 'org-toggle-timestamp-type)
(global-set-key (kbd "C-c t t") 'org-toggle-timestamp-type)
(global-set-key (kbd "C-c o") 'oog)
(global-set-key (kbd "C-c m s") 'org-insert-src-markers)
(global-set-key (kbd "C-c m e") 'org-enclose-region-in-src-block)

(provide 'rc-org-mode)

;;; emacs-rc-org-mode.el ends here
