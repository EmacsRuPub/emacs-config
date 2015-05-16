;; -*- coding: utf-8 -*-
;;
;; Filename: rc-darwin.el
;; Created: Пн май  5 19:47:43 2014 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; key bindings
(cua-mode t)
(setq mac-option-key-is-meta t)
(setq mac-command-key-is-meta nil)
(setq process-connection-type nil)
(setq mac-command-modifier 'hyper)    ;meta|super
(setq mac-pass-command-to-system nil)   ;;avoid hiding with M-h
(global-set-key [(hyper x)] 'cua-cut-region)
(global-set-key [(hyper c)] 'cua-copy-region)
(global-set-key [(hyper v)] 'cua-paste)
(global-set-key [kp-delete] 'delete-char) ;; sets fn-delete to be right-delete
(setq mac-control-modifier 'control)

;; Ignore .DS_Store files with ido mode
(add-to-list 'ido-ignore-files "\\.DS_Store")

(setq locate-command "mdfind")
(setq helm-locate-command "mdfind")

(prefer-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8-unix)
(if (< emacs-major-version 23)
    (set-keyboard-coding-system 'utf-8))
(set-clipboard-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)

(use-package jabber
  :init
  (use-package custom-jabber-darwin)
  :config
  (progn
    ;; Make jabber.el notify through growl when I get a new message
    (setq jabber-message-alert-same-buffer nil)
    (add-hook 'jabber-alert-message-hooks 'custom/pg-jabber-growl-notify)
    (add-hook 'jabber-alert-muc-hooks 'custom/pg-jabber-muc-growl-notify)
    (setq jabber-message-alert-same-buffer t)))

(setq custom/python-libs-path "/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7:")
(setq TeX-output-view-style '(("^pdf$" "." "open -a preview %s.pdf")
                              ("^html?$" "." "open %o")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-darwin.el ends here
