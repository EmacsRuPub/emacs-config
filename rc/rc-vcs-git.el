;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(global-git-gutter-mode +1)

(global-set-key (kbd "C-c C-m C-s") 'magit-status)
(global-set-key (kbd "C-c C-m C-l") 'magit-log)
(global-set-key (kbd "C-c C-g") 'magit-blame-mode)

(provide 'rc-vcs-git)
