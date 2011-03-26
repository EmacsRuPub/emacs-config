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
(require 'dvc-autoloads)


;#############################################################################
;#   Customizations
;############################################################################
(setq dvc-prompt-active-dvc nil)
(setq dvc-select-priority '(xgit xhg bzr baz))
(setq dvc-tips-enabled nil)

;;; emacs-rc-dvc.el ends here
