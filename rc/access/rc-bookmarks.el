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
(add-to-list 'load-path "~/site-lisp/bookmarks/bookmark+")
(add-to-list 'load-path "~/site-lisp/bookmarks/crosshair")

(require 'bookmark+)


;#############################################################################
;#   Keybindings
;############################################################################
;; (global-set-key [f5] 'bookmark-set)
;; (global-set-key [(control x) r j] 'bookmark-jump)

;; TODO: See if we can customize Bookmarks[+] further

;;; rc-bookmarks.el ends here
