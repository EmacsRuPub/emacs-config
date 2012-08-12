;;; rc-helm.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(require 'helm-config)

(helm-mode 1)
(setq enable-recursive-minibuffers t)

(global-set-key (kbd "C-c h e") 'helm-mini)
(global-set-key (kbd "C-f") 'helm-find-files)

(provide 'rc-helm)

;;; rc-helm.el ends here
