;;; rc-edit-portage.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(global-set-key (kbd "\C-c r c") (lambda () (interactive) (sudo-find-file "/etc/portage/make.conf")))
(global-set-key (kbd "\C-c r m") (lambda () (interactive) (sudo-find-file "/etc/portage/package.mask/main")))
(global-set-key (kbd "\C-c r u") (lambda () (interactive) (sudo-find-file "/etc/portage/package.use")))
(global-set-key (kbd "\C-c r l") (lambda () (interactive) (sudo-find-file "/etc/portage/package.license")))
(global-set-key (kbd "\C-c r k") (lambda () (interactive) (sudo-find-file "/etc/portage/package.keywords")))
(global-set-key (kbd "\C-c r a") (lambda () (interactive) (sudo-find-file "/etc/portage/package.accept_keywords")))

(provide 'rc-edit-portage)

;;; rc-edit-portage.el ends here
