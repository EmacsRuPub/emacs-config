;;; rc-org-capture.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(setq org-default-notes-file custom/org-capture-file)

(global-set-key (kbd "C-c r") 'org-capture)

(setq org-capture-templates
      (quote
       (("d" "todo" entry (file (concat org-dir "/todo.org")) "* TODO %? %U :todo:")
        ("o" "ordering" entry (file (concat org-dir "/ordering.org")) "* TODO %? %U :ordering:")
        ("s" "search" entry (file (concat org-dir "/search.org")) "* TODO %? %U :search:")
        ("m" "system maintaining" entry (file+headline (concat org-dir "/projects/config/linux-system.org") "raw tickets") "* TODO %? %U :todo:system:")
        ("n" "newspaper articles" entry (file+headline (concat org-dir "/checklists/from_newspapers.org") "unsorted") "* %? %U :newspaper:toread:")
        ("j" "Job issues")
        ("jb" "bugs" entry (file+headline (concat org-dir "/job/work.org") "баги") "* TODO %? %U :work:bugs:")
        ("jt" "tasks" entry (file+headline (concat org-dir "/job/work.org") "задачи (полуформально)") "* %? %U :work:tasks:")
        ("jo" "job" entry (file+headline (concat org-dir "/job/hr/othertasks.org") "todo") "* %? %U :job:todo:")
        ("t" "keys to file various tickets")
        ("te" "emacs tickets" entry (file+headline (concat org-dir "/projects/config/editors.org") "tickets") "* %? %U :emacs:ticket:")
        ("tp" "project ideas" entry (file (concat org-dir "/projects/ideas/projectideas.org")) "* %? %U :project:idea:")
        ("tl" "leechcraft tickets" entry (file+headline (concat org-dir "/projects/oss/leechcraft.org") "tickets") "* %? %U :leechcraft:ticket:")
        ("tq" "qxmpp tickets" entry (file+headline (concat org-dir "/projects/oss/qxmpp.org") "tickets") "* %? %U :qxmpp:ticket:")
        ("tx" "xmonad tickets" entry (file+headline (concat org-dir "/projects/config/xmonad.org") "tickets") "* %? %U :xmonad:ticket:")
        ("tw" "wiki" entry (file+headline (concat org-dir "/wiki.org") "wiki") "* %? %U :wiki:")
        ("r" "keys to log review items")
        ("rb" "review books" entry (file+headline (concat org-dir "/review/review-books.org") "captured") "* %? %U :review:book:")
        ("rl" "review links" entry (file (concat org-dir "/review/review-links.org")) "* %? %U :review:link:")
        ("ri" "review infosources" entry (file (concat org-dir "/review/review-infosources.org")) "* %? %U :review:infosource:")
        ("rt" "review tokens" entry (file (concat org-dir "/review/review-tokens.org")) "* %? %U :review:token:")
        ("re" "review materials" entry (file (concat org-dir "/review/review-materials.org")) "* %? %U :review:material:")
        ("rm" "review media" entry (file (concat org-dir "/review/review-media.org")) "* %? %U :review:media:")
        ("rs" "review software" entry (file (concat org-dir "/review/review-software.org")) "* %? %U :review:software:")
        ("ru" "review unsorted" entry (file (concat org-dir "/review/unsorted.org")) "* %? %U :review:unsorted:")
        ("ry" "yandex.fotki" entry (file (concat org-dir "/review/review-yandexfotki.org")) "* %? %U :review:yandexfotki:")
        ("e" "keys to perform Emacs stuff")
        ("ee" "emacs try" entry (file+headline (concat org-dir "/projects/config/editors.org") "try") "* %? %U :emacs:try:")
        ("ep" "emacs practical todo" entry (file+headline (concat org-dir "/projects/config/editors.org") "практическое для Emacs") "* %? %U :emacs:todo:practical:")
        )))

;; Remove empty CLOCK drawers on clock out
(defun custom/remove-empty-drawer-on-clock-out ()
  (interactive)
  (save-excursion
    (beginning-of-line 0)
    (org-remove-empty-drawer-at "CLOCK" (point))))
(add-hook 'org-clock-out-hook 'custom/remove-empty-drawer-on-clock-out 'append)

;;; rc-org-capture.el ends here
