;;; rc-edit-portage.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(global-set-key (kbd "\C-c p c") (lambda () (interactive) (find-file "/sudo::/etc/portage/make.conf")))
(global-set-key (kbd "\C-c p m") (lambda () (interactive) (find-file "/sudo::/etc/portage/package.mask")))
(global-set-key (kbd "\C-c p u") (lambda () (interactive) (find-file "/sudo::/etc/portage/package.use")))
(global-set-key (kbd "\C-c p l") (lambda () (interactive) (find-file "/sudo::/etc/portage/package.license")))
(global-set-key (kbd "\C-c p k") (lambda () (interactive) (find-file "/sudo::/etc/portage/package.keywords")))
(global-set-key (kbd "\C-c p a") (lambda () (interactive) (find-file "/sudo::/etc/portage/package.accept_keywords")))

(provide 'rc-edit-portage)

;;; rc-edit-portage.el ends here
