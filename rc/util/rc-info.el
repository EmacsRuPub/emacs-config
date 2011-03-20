;;; emacs-rc-info.el --- 

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords: 
;; Requirements: 
;; Status: not intended to be distributed yet

;#############################################################################
;#   Load extension
;############################################################################
(require 'info)
(add-to-list  'Info-directory-list "/usr/share/info")


;#############################################################################
;#   Customizations
;############################################################################
(push "/usr/share/info" Info-directory-list)
(setenv "MANPATH" "/usr/share/man:/usr/local/man")

;;; emacs-rc-info.el ends here
