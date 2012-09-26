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

(require 'crosshairs)
(require 'bookmark+)

;; TODO: See if we can customize Bookmarks[+] further

(provide 'rc-bookmarks)

(global-set-key (kbd "C-c C-b C-j") 'bmkp-jump-in-navlist)

;;; rc-bookmarks.el ends here
