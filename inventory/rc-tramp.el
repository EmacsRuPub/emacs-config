;; -*- coding: utf-8 -*-
;;
;; Filename: rc-tramp.el
;; Created: Вт апр 29 23:38:03 2014 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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

;; (setq tramp-default-method "scp")
;; (setenv "SHELL" "/bin/bash") ;; workaround for zsh

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-tramp.el ends here
