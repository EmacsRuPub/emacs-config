;;; constants.el ---

;; Copyright (C) Ronin
;;
;; Author: Ronin <aaermolov@gmail.com>
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(setq org-dir "/Users/octocat/org")

;#############################################################################
;#   Abbreviation
;############################################################################
(setq custom/yasnippet-dir (concat config-basedir "/resources/yasnippet"))
(setq custom/auto-insert-dir (concat config-basedir "/resources/auto-insert/"))


;#############################################################################
;#   Org
;############################################################################
(setq custom/org-capture-file (concat org-dir "/refile.org"))
(setq custom/org-capture-review-file (concat org-dir "/review.org"))
(setq custom/org-diary-file (concat org-dir "/diary.org"))


;#############################################################################
;#   Jabber
;############################################################################
(setq custom/jabber-history-dir "~/.emacs-jabber")

;;; constants.el ends here
