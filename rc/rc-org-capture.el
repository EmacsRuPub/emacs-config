;;; rc-org-capture.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(setq org-default-notes-file custom/org-capture-file)

(global-set-key (kbd "C-c e") 'org-capture)

(setq org-capture-templates
      (quote
       (("d" "todo")
        ("dc" "chaos" entry (file (concat org-dir "/todo.org")) "* SOMEDAY %? %U :todo:chaos:")
        ("dt" "today" entry (file (concat org-dir "/todo.org")) "* TODO %? %U :todo:today:")
        ("dm" "tomorrow" entry (file (concat org-dir "/todo.org")) "* TODO %? %U :todo:tomorrow")
        ("do" "ordering" entry (file (concat org-dir "/ordering.org")) "* TODO %? %U :todo:ordering")
        ("k" "knowledge base" entry (file (concat org-dir "/kb.org")) "* %? %U :kb:raw:")
        ("s" "search" entry (file (concat org-dir "/search.org")) "* TODO %? %U :search:")
        ("m" "system maintaining" entry (file+headline (concat org-dir "/projects/config/linux-system.org") "raw tickets") "* TODO %? %U :todo:system:")
        ("n" "newspaper articles" entry (file+headline (concat org-dir "/checklists/from_newspapers.org") "unsorted") "* %? %U :newspaper:toread:")
        ("j" "issues" entry (file+headline (concat org-dir "/job/issues.org") "list") "* %? %U :work:tasks:")
        ("g" "github" entry (file (concat org-dir "-inventory/checklists/github.org")) "* %? %U :github:")
        ("b" "browser tabs")
        ("bc" "clojure" entry (file+olp (concat org-dir "/review/browser-tabs.org") "firefox tabs" "clojure (to process)") "* %? %U :clojure:")
        ("bh" "haskell" entry (file+olp (concat org-dir "/review/browser-tabs.org") "firefox tabs" "haskell") "* %? %U :haskell:")
        ("t" "keys to file various tickets")
        ("te" "emacs tickets" entry (file+headline (concat org-dir "/projects/config/editors.org") "tickets") "* %? %U :emacs:ticket:")
        ("tp" "project ideas" entry (file (concat org-dir "/projects/ideas/projectideas.org")) "* %? %U :project:idea:")
        ("tx" "xmonad tickets" entry (file+headline (concat org-dir "/projects/config/xmonad.org") "tickets") "* %? %U :xmonad:ticket:")
        ("ts" "stumpwm tickets" entry (file+headline (concat org-dir "/projects/config/stumpwm.org") "tickets") "* %? %U :stumpwm:ticket:")
        ("tw" "workplace fixes" entry (file (concat org-dir "/workplace-fixes.org")) "* TODO %? %U :workplace:")
        ("e" "keys to perform Emacs stuff")
        ("ee" "emacs try" entry (file+headline (concat org-dir "/projects/config/editors.org") "try") "* %? %U :emacs:try:")
        ("ep" "emacs practical todo" entry (file+headline (concat org-dir "/projects/config/editors.org") "практическое для Emacs") "* %? %U :emacs:todo:practical:")
        ("l" "links" entry (file (concat org-dir "/links.org")) "* %? %U :links:send:")
        )))

;; Remove empty CLOCK drawers on clock out
(defun custom/remove-empty-drawer-on-clock-out ()
  (interactive)
  (save-excursion
    (beginning-of-line 0)
    (org-remove-empty-drawer-at "CLOCK" (point))))
(add-hook 'org-clock-out-hook 'custom/remove-empty-drawer-on-clock-out 'append)

(provide 'rc-org-capture)

;;; rc-org-capture.el ends here
