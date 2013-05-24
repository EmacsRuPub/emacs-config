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

(setq tramp-default-method "ssh")

;#############################################################################
;#   Defaults
;############################################################################
;; (add-to-list 'tramp-default-method-alist '("\\`localhost\\'" "\\`root\\'" "ssh"))
;; (add-to-list 'tramp-default-method-alist '("" "octocat" "ssh"))
;; (add-to-list 'tramp-default-method-alist '("" "root" "ssh"))

;; (add-to-list 'tramp-default-proxies-alist '(nil "\\`root\\'" "/ssh:%h:"))
;; (add-to-list 'tramp-default-proxies-alist '((regexp-quote (system-name)) nil nil))

;#############################################################################
;#   Customizations
;############################################################################
;; (tramp-set-completion-function "ssh"
;;                                '((tramp-parse-sconfig "/etc/ssh_config")
;;                                  (tramp-parse-sconfig "~/.ssh/config")))

(setq tramp-chunksize 500)
;; (setq tramp-default-method "scp")
;; (setenv "SHELL" "/bin/bash") ;; workaround for zsh

(provide 'rc-tramp)

;;; emacs-rc-tramp.el ends here
