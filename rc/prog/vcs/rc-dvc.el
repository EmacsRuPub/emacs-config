;;; emacs-rc-dvc.el --- 

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords: 
;; Requirements: 
;; Status: not intended to be distributed yet

;#############################################################################
;#   Load extensions
;############################################################################
(add-to-list 'load-path "~/site-lisp/vcs/dvc/")
(load-file "~/site-lisp/vcs/dvc/dvc-load.el")

(require 'dvc-autoloads)


;#############################################################################
;#   Customizations
;############################################################################
(setq dvc-prompt-active-dvc nil)
(setq dvc-select-priority '(xgit xhg bzr baz))
(setq dvc-tips-enabled nil)

;;; emacs-rc-dvc.el ends here
