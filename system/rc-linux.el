;; -*- coding: utf-8 -*-
;;
;; Filename: rc-linux.el
;; Created: Ср май  7 01:19:34 2014 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq x-alt-keysym 'meta)

(when (eq window-system 'x)
  (use-package jabber
    :init
    (use-package custom-jabber-linux)
    :config
    (progn
      ;; Jabber urgency hints
      (defvar jabber-activity-jids-count 0)
      (add-hook 'jabber-activity-update-hook 'jabber-urgency-hint)
      (add-hook 'jabber-alert-presence-hooks 'jabber-presence-urgency-hint)
      (defvar jabber-libnotify-icon ""
        "*Icon to be used on the notification pop-up. Default is empty")
      (defvar jabber-libnotify-timeout "7000"
        "*Specifies the timeout of the pop up window in millisecond")
      (add-to-list 'jabber-alert-message-hooks
                   'jabber-libnotify-message-display))))

(setq custom/python-libs-path "/usr/lib64/python2.7:")
(setq TeX-output-view-style '(("^pdf$" "." "zathura %s.pdf")
                              ("^html?$" "." "open %o")))

(setq browse-url-browser-function 'browse-url-generic)
(setq browse-url-generic-program "/usr/bin/firefox")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-linux.el ends here
