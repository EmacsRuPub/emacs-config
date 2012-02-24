;;; constants.el ---

;; Copyright (C) Ronin
;;
;; Author: Ronin <aaermolov@gmail.com>
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(setq custom/base-conf-dir "~/.emacs.d")

;#############################################################################
;#   Abbreviation
;############################################################################
(setq custom/yasnippet-dir (concat config-basedir "/resources/yasnippet"))
(setq custom/auto-insert-dir (concat config-basedir "/resources/auto-insert/"))


;#############################################################################
;#   Org
;############################################################################
(setq custom/org-capture-file "/mnt/work/org/refile.org")
(setq custom/org-capture-review-file "/mnt/work/org/review.org")
(setq custom/org-diary-file "/mnt/work/org/diary.org")


;#############################################################################
;#   Jabber
;############################################################################
(setq custom/jabber-history-dir "~/.emacs-jabber")
(setq custom/rc-jabber-custom (concat config-basedir "/rc/extras/client/rc-jabber-custom.el"))

;;; constants.el ends here
