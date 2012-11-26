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

(global-set-key (kbd "C-c m j") 'bmkp-jump-in-navlist)

;; TODO: See if we can customize Bookmarks[+] further

(provide 'rc-bookmarks)


;;; rc-bookmarks.el ends here
