;; -*- coding: utf-8 -*-
;;
;; Filename: rc-help.el
;; Created:  Mon Jun 30 19:02:26 2014 +0400
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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

(global-set-key [f1] 'help-on-click/key)

(provide 'rc-help)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-help.el ends here
