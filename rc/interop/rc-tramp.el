;;; emacs-rc-tramp.el --- 

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords: 
;; Requirements: 
;; Status: not intended to be distributed yet

;#############################################################################
;#   Load extensions
;############################################################################
(require 'tramp) ;; load tramp

;#############################################################################
;#   Defaults
;############################################################################
(add-to-list 'tramp-default-method-alist '("\\`localhost\\'" "\\`root\\'" "su"))
(add-to-list 'tramp-default-method-alist '("" "ronin" "ssh"))
(add-to-list 'tramp-default-method-alist '("" "root" "ssh"))


;#############################################################################
;#   Customizations
;############################################################################
(tramp-set-completion-function "ssh"
			       '((tramp-parse-sconfig "/etc/ssh_config")
				 (tramp-parse-sconfig "~/.ssh/config")))
;; (setq tramp-chunksize 500)
;; (setq tramp-default-method "scp")
(setenv "SHELL" "/bin/sh") ;; workaround for zsh
(setq tramp-default-method "ssh")

;; (add-to-list 'tramp-default-proxies-alist
;; 						 '("office\\.webdrive\\.ru" "octocat"
;; 							 "/ssh:node1.unitedplatform.com:")
;; 						 '("\\`smee\\.loc\\'" "\\`octocat\\'"
;; 							 "/ssh:office.webdrive.ru:"))

;;; emacs-rc-tramp.el ends here
