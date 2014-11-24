;;; constants.el ---

;; Copyright (C) Ronin
;;
;; Author: Ronin <aaermolov@gmail.com>
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

;#############################################################################
;#   Abbreviation
;############################################################################
(setq custom/yasnippet-dir (at-config-basedir "resources/yasnippet/"))
(setq custom/yasnippet-private-dir (at-config-basedir "resources/yasnippet-private/"))


;#############################################################################
;#   Org
;############################################################################
(setq custom/org-capture-file (at-org-dir "/refile.org"))


;#############################################################################
;#   Jabber
;############################################################################
(setq custom/jabber-history-dir (at-homedir "/.emacs-jabber"))


;#############################################################################
;#   Various
;############################################################################
(setq custom/frame-title-format "emacs - %f")
(setq custom/erc-autoaway-message "I'm gone (autoaway after %i seconds)")

(setq custom/juick-tmp-dir "~/.juick-avatars/")
(setq custom/psto-tmp-dir "~/.psto-avatars/")

(setq custom/jabber-resource "laptoptop")
(setq custom/hyperspec-root "~/help/HyperSpec/")

(setq custom/wl-domain "ronin.homelinux.net")

(setq custom/maildir-folder "~/Mail")

;; pylookup
(defun at-pylookup-dir (&optional suffix)
  (concat (at-config-basedir "el-get/pylookup") suffix))

(defconst emacs-tmp-dir (at-homedir "/.emacs-backups"))

(setq custom/php-manual-path "/home/octocat/documentation/php-chunked-xhtml/")

;;; constants.el ends here
