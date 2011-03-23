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
(setq custom/yasnippet-dir "~/.emacs.d/resources/yasnippet")
(setq custom/msf-abbrev-dir "~/.emacs.d/resources/msf-abbrevs")
(setq custom/auto-insert-dir (concat (getenv "HOME") "/.emacs.d/resources/auto-insert/"))
;; (setq custom/company-mode-dir "~/emacs/company-mode") ;; FIXME value


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
(setq custom-ext-path/gweather "~/site-lisp/clients/google-weather.el")
(setq custom-ext-path/org-gweather "~/site-lisp/clients/org-google-weather.el")
;; DVC
(setq custom-ext-path/dvc-dir "~/site-lisp/vcs/dvc/")
(setq custom-ext-path/dvc-load "~/site-lisp/vcs/dvc/dvc-load.el")
;; Git
(setq custom-ext-path/git "~/site-lisp/vcs/git.el")
(setq custom-ext-path/egit "~/site-lisp/vcs/egit.el")
(setq custom-ext-path/gitsum "~/site-lisp/vcs/gitsum.el")
(setq custom-ext-path/egg "~/site-lisp/vcs/egg")
;; (setq custom-ext-path/git-emacs "~/site-lisp/vcs/git-emacs")
;; Vcs
(setq custom-ext-path/vcs "~/site-lisp/vcs")
;; lisp
;; (setq custom-ext-path/slime "~/site-lisp/slime/")
;; nxml
(setq custom-ext-path/docbook-menu "~/site-lisp/publishing/docbook-menu")
(setq custom-ext-path/nxml-mode "~/site-lisp/nxml-mode")
(setq custom-ext-path/rng-auto "~/site-lisp/nxml-mode/rng-auto.el")
;; ccmode
(setq custom-ext-path/c-eldoc "~/site-lisp/programming/c-eldoc.el")
;; haskell
(setq custom-ext-path/shime "~/site-lisp/shime")
;; javascript
;; (setq custom-ext-path/ejacs "~/emacs/ejacs")
;; jabber
(setq custom-ext-path/autosmiley "~/site-lisp/clients/autosmiley.el")
;; project-buffer-mode
(setq custom-ext-path/project-buffer-mode "~/site-lisp/projects")

;;; constants.el ends here
