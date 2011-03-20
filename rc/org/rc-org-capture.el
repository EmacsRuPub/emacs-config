;;; rc-org-capture.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(setq org-default-notes-file custom/org-capture-file)

(global-set-key (kbd "\C-cr") 'org-capture)

(setq org-capture-templates
      (quote
       (("d" "todo" entry (file "/mnt/work/org/todo.org") "* TODO %? %U :todo:")
        ("o" "ordering" entry (file "/mnt/work/org/ordering.org") "* TODO %? %U :ordering:")
        ("s" "search" entry (file "/mnt/work/org/search.org") "* TODO %? %U :search:")
        ("m" "system maintaining" entry (file "/mnt/work/org/projects/linux-system.org") "* TODO %? %U :todo:system:")
        ("n" "newspaper articles" entry (file+headline "/mnt/work/org/checklists/from_newspapers.org" "unsorted") "* %? %U :newspaper:toread:")
        ("j" "job" entry (file+headline "/mnt/work/org/job/othertasks.org" "todo") "* %? %U :job:todo:")
        ("t" "keys to file various tickets")
        ("te" "emacs tickets" entry (file+headline "/mnt/work/org/projects/editors.org" "tickets") "* %? %U :emacs:ticket:")
        ("tp" "project ideas" entry (file "/mnt/work/org/projectideas.org") "* %? %U :project:idea:")
        ("tl" "leechcraft tickets" entry (file+headline "/mnt/work/org/projects/leechcraft.org" "tickets") "* %? %U :leechcraft:ticket:")
        ("tq" "qxmpp tickets" entry (file+headline "/mnt/work/org/projects/qxmpp.org" "tickets") "* %? %U :qxmpp:ticket:")
        ("tx" "xmonad tickets" entry (file+headline "/mnt/work/org/projects/xmonad.org" "tickets") "* %? %U :xmonad:ticket:")
        ("r" "keys to log review items")
        ("rb" "review books" entry (file+headline "/mnt/work/org/review.org" "books") "* %? %U :review:book:")
        ("rl" "review links" entry (file+headline "/mnt/work/org/review.org" "links") "* %? %U :review:link:")
        ("rs" "review software" entry (file+headline "/mnt/work/org/review.org" "software") "* %? %U :review:software:")
        ("ru" "review unsorted" entry (file+headline "/mnt/work/org/review.org" "unsorted") "* %? %U :review:")
        ("ry" "yandex.fotki" entry (file+headline "/mnt/work/org/review.org" "Yandex.Fotki") "* %? %U :review:yandexfotki:")
        ("e" "keys to perform Emacs stuff")
        ("ee" "emacs try" entry (file+headline "/mnt/work/org/projects/editors.org" "try") "* %? %U :emacs:try:")
        )))

;; Remove empty CLOCK drawers on clock out
(defun custom/remove-empty-drawer-on-clock-out ()
  (interactive)
  (save-excursion
    (beginning-of-line 0)
    (org-remove-empty-drawer-at "CLOCK" (point))))
(add-hook 'org-clock-out-hook 'bh/remove-empty-drawer-on-clock-out 'append)

;;; rc-org-capture.el ends here
