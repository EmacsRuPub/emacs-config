;;; init-git.el --- 

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords: 
;; Requirements: 
;; Status: not intended to be distributed yet

;#############################################################################
;#   Load extensions
;############################################################################
(autoload 'egit "egit" "Emacs git history" t)
(autoload 'egit-file "egit" "Emacs git history file" t)
(autoload 'egit-dir "egit" "Emacs git history directory" t)

(require 'git) ;; standard git module
;; (require 'git-emacs) ;; git-emacs
(require 'egit)
(require 'gitsum)
(require 'git-blame)
(require 'egg)


;#############################################################################
;#   Keybindings
;############################################################################
(global-set-key "\C-cg" 'egg-status)
(global-set-key "\C-cmc" 'mo-git-blame-current)
(global-set-key "\C-cmf" 'mo-git-blame-file)

;;; init-git.el ends here
