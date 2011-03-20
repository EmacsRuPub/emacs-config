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
;; (load-file "~/site-lisp/clients/autosmiley.el")

(require 'jabber)
(require 'jabber-autoloads) ;; For 0.7.90 and above:
(require 'jabber-bookmarks)
(require 'jabber-autoaway)
;; (require 'autosmiley)


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
;#   Loading customizations
;############################################################################
(load custom/rc-jabber-custom)


;#############################################################################
;#   Custom definitions and hooks
;############################################################################
(defun custom/jabber-chat-mode-hook ()
  (local-set-key "\C-c\C-l" 'custom-jabber/insert-inlove-smile)
  (local-set-key "\C-c\C-k" 'custom-jabber/insert-kiss-smile)
  (local-set-key "\C-cwc" 'custom-jabber/cite-region)
  (local-set-key "\C-cwa" 'custom-jabber/asterisk-region)
  (local-set-key "\C-cwp" 'custom-jabber/parenthesize-region)
  (local-set-key "\C-cur" 'upcase-region)
  (local-set-key "\C-c\C-fw" 'custom-jabber/wrap-replace-regexp)
  (local-set-key "\C-c\C-fr" 'custom-jabber/wrap-misreading)
  (local-set-key [(meta down)] 'custom/find-url-forward)
  (local-set-key [(meta up)] 'custom/find-url-backward))

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
(global-set-key "\C-x\C-j\C-r" 'jabber-switch-to-roster-buffer)
(global-set-key "\C-x\C-j\C-a" 'jabber-activity-switch-to)
(global-set-key "\C-c\C-o\C-l" 'browse-url)

;;; emacs-rc-jabber.el ends here
