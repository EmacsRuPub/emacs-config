;;; rc-bookmarks.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

;#############################################################################
;#   Load Extensions
;############################################################################

(require 'bookmark+)
(require 'crosshairs)
(require 'breadcrumb)

;; TODO: See if we can customize Bookmarks[+] further

(setq bc-bookmark-limit 1000)

(provide 'rc-bookmarks)

;;; rc-bookmarks.el ends here
