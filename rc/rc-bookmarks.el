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

;(global-set-key (kbd "C-c m j") 'bmkp-jump-in-navlist)

;; TODO: See if we can customize Bookmarks[+] further

(setq bc-bookmark-limit 1000)

(key-chord-define-global "2s" 'bc-set)
(key-chord-define-global "[-" 'bc-previous)
(key-chord-define-global "-]" 'bc-next)
(key-chord-define-global "[=" 'bc-local-previous)
(key-chord-define-global "]=" 'bc-local-next)
(key-chord-define-global "4c" 'bc-goto-current)
(key-chord-define-global "0-" 'bc-list)

(provide 'rc-bookmarks)

;;; rc-bookmarks.el ends here
