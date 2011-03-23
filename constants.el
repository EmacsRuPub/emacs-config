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
;; Google weather
(setq custom-ext-path/gweather (concat custom/base-ext-dir "/clients/google-weather.el"))
(setq custom-ext-path/org-gweather (concat custom/base-ext-dir "/clients/org-google-weather.el"))
;; DVC
(setq custom-ext-path/dvc-dir (concat custom/base-ext-dir "/vcs/dvc/"))
(setq custom-ext-path/dvc-load (concat custom/base-ext-dir "/vcs/dvc/dvc-load.el"))
;; Git
(setq custom-ext-path/git (concat custom/base-ext-dir "/vcs/git.el"))
(setq custom-ext-path/egit (concat custom/base-ext-dir "/vcs/egit.el"))
(setq custom-ext-path/gitsum (concat custom/base-ext-dir "/vcs/gitsum.el"))
(setq custom-ext-path/egg (concat custom/base-ext-dir "/vcs/egg"))
;; (setq custom-ext-path/git-emacs (concat custom/base-ext-dir "/vcs/git-emacs"))
;; Vcs
(setq custom-ext-path/vcs (concat custom/base-ext-dir "/vcs"))
;; lisp
;; (setq custom-ext-path/slime (concat custom/base-ext-dir "/slime/"))
;; nxml
(setq custom-ext-path/docbook-menu (concat custom/base-ext-dir "/publishing/docbook-menu"))
(setq custom-ext-path/nxml-mode (concat custom/base-ext-dir "/nxml-mode"))
(setq custom-ext-path/rng-auto (concat custom/base-ext-dir "/nxml-mode/rng-auto.el"))
;; ccmode
(setq custom-ext-path/c-eldoc (concat custom/base-ext-dir "/programming/c-eldoc.el"))
;; haskell
(setq custom-ext-path/shime (concat custom/base-ext-dir "/shime"))
;; javascript
;; (setq custom-ext-path/ejacs "~/emacs/ejacs")
;; jabber
(setq custom-ext-path/autosmiley (concat custom/base-ext-dir "/clients/autosmiley.el"))
;; project-buffer-mode
(setq custom-ext-path/project-buffer-mode (concat custom/base-ext-dir "/projects"))

;;; constants.el ends here
