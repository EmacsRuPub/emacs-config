;;; rc-vcs-common.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

;#############################################################################
;#   Load extensions
;############################################################################
(require 'psvn)
;(require 'mercurial)
(require 'ahg)
;; (require 'vc)

;; (autoload 'svn-status "psvn" nil t)

;#############################################################################
;#   Customizations
;############################################################################
;; PSVN customization
;; (setq svn-status-svn-environment-var-list (quote ("LC_MESSAGES=C" "LANG=C" "LC_ALL=C"))))
(setq vc-handled-backends nil)

(provide 'rc-vcs-common)

;;; rc-vcs-common.el ends here
