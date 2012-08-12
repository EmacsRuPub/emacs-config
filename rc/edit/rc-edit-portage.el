;;; rc-edit-portage.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(global-set-key (kbd "\C-c p m") (lambda () (interactive) (find-file "/sudo::/etc/portage/package.mask/package.common.mask")))
(global-set-key (kbd "\C-c p u") (lambda () (interactive) (find-file "/sudo::/etc/portage/package.use")))
(global-set-key (kbd "\C-c p k") (lambda () (interactive) (find-file "/sudo::/etc/make.conf")))

(provide 'rc-edit-portage)

;;; rc-edit-portage.el ends here
