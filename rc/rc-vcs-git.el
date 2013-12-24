;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(global-git-gutter-mode +1)

(global-set-key (kbd "C-c C-g") 'magit-blame-mode)
(define-key magit-blame-map (kbd "C-o") 'magit-blame-locate-commit)

(provide 'rc-vcs-git)
