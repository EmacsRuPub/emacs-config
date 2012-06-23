;;; emacs-rc-jabber.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

;#############################################################################
;#   Load extensions
;############################################################################
(require 'jabber)
(require 'jabber-autoloads) ;; For 0.7.90 and above:
(require 'jabber-bookmarks)
(require 'jabber-autoaway)
(require 'autosmiley)


;#############################################################################
;#   Account definitions
;############################################################################
;; 'custom/jabber-account-list' has similar layout as below:
;; 
;; (setq custom/jabber-account-list '(("abc@gmail.com/emacs"
;; 				    (:network-server . "talk.google.com")
;; 				    (:password . "12345")
;; 				    (:connection-type . ssl))
;; 				   ("xyz@jabber.ru/emacs"
;; 				    (:password . "1234567")
;; 				    (:network-server . "jabber.ru")
;; 				    (:disabled . t))))
(setq jabber-account-list custom/jabber-account-list)


;#############################################################################
;#   Customizations
;############################################################################
(setq jabber-alert-info-message-hooks (quote (jabber-info-echo)))
(setq jabber-alert-message-hooks (quote (jabber-message-beep jabber-message-scroll)))
(setq jabber-alert-presence-hooks (quote (jabber-presence-update-roster)))
(setq jabber-nickname "Ronin")
(setq jabber-resource "at-home") ;; (concat "at-" (if (string-equal (system-name) "ronin.homelinux.net") "home" "work")))
(setq jabber-auto-reconnect t)
(setq fsm-debug nil)
(setq jabber-history-enabled t)
(setq jabber-history-dir custom/jabber-history-dir)
(setq jabber-use-global-history nil)
(setq jabber-groupchat-buffer-format "*-jg-%n-*")
(setq jabber-roster-buffer "*-jroster-*")
(setq jabber-roster-line-format " %c %-25n %u %-8s  %S")
(setq jabber-chat-buffer-format "*-jc-%n-*")
(setq jabber-muc-private-buffer-format "*-jmuc-priv-%g-%n-*")
(setq jabber-rare-time-format "%e %b %Y %H:00")
(custom-set-faces '(jabber-chat-prompt-system ((t (:foreground "darkgreen" :weight bold)))))

;#############################################################################
;#   Jabber notifications
;############################################################################
(when (eq system-type 'gnu/linux)
  (defvar jabber-libnotify-icon ""
    "*Icon to be used on the notification pop-up. Default is empty")
  (defvar jabber-libnotify-timeout "7000"
    "*Specifies the timeout of the pop up window in millisecond")
  (add-to-list 'jabber-alert-message-hooks
               'jabber-libnotify-message-display)
  )

;#############################################################################
;#   Jabber urgency hints
;############################################################################
(when (eq window-system 'x)
  ;; usage example
  (defvar jabber-activity-jids-count 0)
  (add-hook 'jabber-activity-update-hook 'jabber-urgency-hint)
  )

;; Message alert hooks
(define-jabber-alert echo "Show a message in the echo area"
  (lambda (msg)
    (unless (minibuffer-prompt)
      (message "%s" msg))))

(when (eq system-type 'darwin)
  (defvar growl-program "/usr/local/bin/growlnotify")
  ;; Make jabber.el notify through growl when I get a new message
  (setq jabber-message-alert-same-buffer nil)
  (add-hook 'jabber-alert-message-hooks 'pg-jabber-growl-notify)
  (add-hook 'jabber-alert-muc-hooks 'pg-jabber-muc-growl-notify)
  (setq jabber-message-alert-same-buffer t)
  )


;#############################################################################
;#   Custom definitions and hooks
;############################################################################
(defun custom/jabber-chat-mode-hook ()
  (local-set-key (kbd "C-c C-l") 'custom-jabber/insert-inlove-smile)
  (local-set-key (kbd "C-c C-k") 'custom-jabber/insert-kiss-smile)
  (local-set-key (kbd "C-c u r") 'upcase-region)
  (local-set-key (kbd "C-c C-f w") 'custom-jabber/wrap-replace-regexp)
  (local-set-key (kbd "C-c C-f r") 'custom-jabber/wrap-misreading)
  (local-set-key (kbd "<M-down>") 'custom/find-url-forward)
  (local-set-key (kbd "<M-up>") 'custom/find-url-backward))

(defun my-jabber-connect-hook (jc)
  (jabber-send-presence "" "I'm online" 10)
  (let* ((state-data (fsm-get-state-data jc))
	 (server (plist-get state-data :server)))
    (message "%s" server)
    (if (string-equal server "gmail.com")
	(progn
	  ;; (jabber-groupchat-join jc "devil@conference.jabber.ru" "ronin")
	  ;; (jabber-groupchat-join jc "haskell@conference.jabber.ru" "ronin")
	  ;; (jabber-groupchat-join jc "lisp@conference.jabber.ru" "ronin")
	  ;; (jabber-groupchat-join jc "emacs@conference.jabber.ru" "ronin")
	  ;; (jabber-groupchat-join jc "icfpc@conference.jabber.ru" "ronin")
	  ;; (jabber-groupchat-join jc "wax@conference.jabber.ru" "ronin")
	  ;; (jabber-groupchat-join jc "erlang@conference.jabber.ru" "ronin")
	  ))))

(add-hook 'jabber-chat-mode-hook 'custom/jabber-chat-mode-hook)
(add-hook 'jabber-post-connect-hook 'jabber-autoaway-start)
(add-hook 'jabber-chat-mode-hook 'goto-address)
(add-hook 'jabber-post-connect-hooks 'my-jabber-connect-hook)


;#############################################################################
;#   Smileys
;############################################################################
;; (add-hook 'jabber-chat-mode-hook 'autosmiley-mode)
;; (setq smiley-base-directory (concat (getenv "HOME") "/.emacs.d/resources/smileys/"))
;; (add-to-list 'gnus-smiley-file-types "gif")
;; (smiley-load-theme "kolobok")


;#############################################################################
;#   Keybindings
;############################################################################
(global-set-key (kbd "C-x C-j C-r") 'jabber-switch-to-roster-buffer)
(global-set-key (kbd "C-x C-j C-a") 'jabber-activity-switch-to)
(global-set-key (kbd "C-c C-o C-l") 'browse-url)

;;; emacs-rc-jabber.el ends here
