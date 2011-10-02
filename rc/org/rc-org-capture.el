;;; rc-org-capture.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(setq org-default-notes-file custom/org-capture-file)

(global-set-key "\C-cr" 'org-capture)

(setq org-capture-templates
      (quote
       (("d" "todo" entry (file "/mnt/work/org/todo.org") "* TODO %? %U :todo:")
        ("o" "ordering" entry (file "/mnt/work/org/ordering.org") "* TODO %? %U :ordering:")
        ("s" "search" entry (file "/mnt/work/org/search.org") "* TODO %? %U :search:")
				("m" "system maintaining" entry (file+headline "/mnt/work/org/projects/config/linux-system.org" "raw tickets") "* TODO %? %U :todo:system:")
        ("n" "newspaper articles" entry (file+headline "/mnt/work/org/checklists/from_newspapers.org" "unsorted") "* %? %U :newspaper:toread:")
        ("j" "job" entry (file+headline "/mnt/work/org/job/othertasks.org" "todo") "* %? %U :job:todo:")
        ("t" "keys to file various tickets")
        ("te" "emacs tickets" entry (file+headline "/mnt/work/org/projects/config/editors.org" "tickets") "* %? %U :emacs:ticket:")
        ("tp" "project ideas" entry (file "/mnt/work/org/projects/ideas/projectideas.org") "* %? %U :project:idea:")
        ("tl" "leechcraft tickets" entry (file+headline "/mnt/work/org/projects/oss/leechcraft.org" "tickets") "* %? %U :leechcraft:ticket:")
        ("tq" "qxmpp tickets" entry (file+headline "/mnt/work/org/projects/oss/qxmpp.org" "tickets") "* %? %U :qxmpp:ticket:")
        ("tx" "xmonad tickets" entry (file+headline "/mnt/work/org/projects/config/xmonad.org" "tickets") "* %? %U :xmonad:ticket:")
        ("r" "keys to log review items")
        ("rb" "review books" entry (file+headline "/mnt/work/org/review/review-books.org" "captured") "* %? %U :review:book:")
        ("rl" "review links" entry (file "/mnt/work/org/review/review-links.org") "* %? %U :review:link:")
				("ri" "review infosources" entry (file "/mnt/work/org/review/review-infosources.org") "* %? %U :review:infosource:")
				("rt" "review tokens" entry (file "/mnt/work/org/review/review-tokens.org") "* %? %U :review:token:")
				("re" "review materials" entry (file "/mnt/work/org/review/review-materials.org") "* %? %U :review:material:")
				("rm" "review media" entry (file "/mnt/work/org/review/review-media.org") "* %? %U :review:media:")
        ("rs" "review software" entry (file "/mnt/work/org/review/review-software.org") "* %? %U :review:software:")
        ("ru" "review unsorted" entry (file "/mnt/work/org/review/unsorted.org") "* %? %U :review:unsorted:")
        ("ry" "yandex.fotki" entry (file "/mnt/work/org/review/review-yandexfotki.org") "* %? %U :review:yandexfotki:")
        ("e" "keys to perform Emacs stuff")
        ("ee" "emacs try" entry (file+headline "/mnt/work/org/projects/config/editors.org" "try") "* %? %U :emacs:try:")
        )))

;; Remove empty CLOCK drawers on clock out
(defun custom/remove-empty-drawer-on-clock-out ()
  (interactive)
  (save-excursion
    (beginning-of-line 0)
    (org-remove-empty-drawer-at "CLOCK" (point))))
(add-hook 'org-clock-out-hook 'bh/remove-empty-drawer-on-clock-out 'append)

;;; rc-org-capture.el ends here
