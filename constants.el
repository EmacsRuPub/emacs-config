;;; constants.el ---

;; Copyright (C) Ronin
;;
;; Author: Ronin <aaermolov@gmail.com>
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(setq org-dir (concat home-directory "/org/main"))
(setq org-inventory-dir (concat home-directory "/org/inventory"))

;#############################################################################
;#   Abbreviation
;############################################################################
(setq custom/yasnippet-dir (concat config-basedir "resources/yasnippet/"))
(setq custom/auto-insert-dir (concat config-basedir "resources/auto-insert/"))


;#############################################################################
;#   Org
;############################################################################
(setq custom/org-capture-file (concat org-dir "/refile.org"))


;#############################################################################
;#   Jabber
;############################################################################
(setq custom/jabber-history-dir "~/.emacs-jabber")


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

;;; constants.el ends here
