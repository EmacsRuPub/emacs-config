;; -*- coding: utf-8 -*-
;;
;; Filename: rc-pylookup.el
;; Created: Сб июн 15 12:52:31 2013 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; add pylookup to your loadpath, ex) ~/.emacs.d/pylookup
(setq pylookup-dir "/home/octocat/.emacs.d/el-get/pylookup") ;; TODO use constants

;; load pylookup when compile time
(eval-when-compile (require 'pylookup))

;; set executable file and db file
(setq pylookup-program (concat pylookup-dir "/pylookup.py"))
(setq pylookup-db-file (concat pylookup-dir "/pylookup.db"))

;; set search option if you want
(setq pylookup-search-options '("--insensitive" "0" "--desc" "0"))

;; to speedup, just load it on demand
(autoload 'pylookup-lookup "pylookup"
  "Lookup SEARCH-TERM in the Python HTML indexes." t)

(autoload 'pylookup-update "pylookup"
  "Run pylookup-update and create the database at `pylookup-db-file'." t)

(defadvice pylookup-lookup
  (around change-browse-url-browser-function activate)
  "Use w3m for slime documentation lookup."
  (let ((browse-url-browser-function 'w3m-browse-url))
    ad-do-it))


(provide 'rc-pylookup)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-pylookup.el ends here
