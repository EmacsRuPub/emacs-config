;;; constants.el ---

;; Copyright (C) Ronin
;;
;; Author: Ronin <aaermolov@gmail.com>
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(setq custom/base-conf-dir "~/.emacs.d")
(setq custom/base-ext-dir "~/site-lisp")

;#############################################################################
;#   Abbreviation
;############################################################################
(setq custom/yasnippet-dir (concat custom/base-conf-dir "/resources/yasnippet"))
(setq custom/auto-insert-dir (concat custom/base-conf-dir "/resources/auto-insert/"))


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
(setq custom/rc-jabber-custom "~/.emacs.d/rc/extras/client/rc-jabber-custom.el")


;#############################################################################
;#   Extension paths
;############################################################################
;; project-buffer-mode
(setq custom-ext-path/project-buffer-mode (concat custom/base-ext-dir "/projects"))

;;; constants.el ends here
