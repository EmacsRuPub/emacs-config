;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(global-git-gutter-mode +1)

(global-set-key (kbd "C-c C-g") 'magit-blame-mode)
(global-set-key (kbd "C-c g s") 'magit-status)
(global-set-key (kbd "C-c g l") 'magit-file-log)
(global-set-key (kbd "C-c g w") 'magit-diff-working-tree)
(global-set-key (kbd "C-c g r") 'magit-reflog)
(global-set-key (kbd "C-c g c") 'magit-checkout)
(global-set-key (kbd "C-c g r") 'magit-add-remote)

(provide 'rc-git)
