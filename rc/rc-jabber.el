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

(eval-after-load "jabber"
  '(progn
     (when use-zenburn-in-jabber
       (set-face-attribute 'jabber-roster-user-chatty nil :foreground "#f0dfaf" :weight 'bold)
       (set-face-attribute 'jabber-roster-user-online nil :foreground "#dfaf8f" :weight 'bold)
       (set-face-attribute 'jabber-roster-user-away nil :foreground "#8fb28f")
       (set-face-attribute 'jabber-roster-user-xa nil :foreground "#7f9f7f")
       (set-face-attribute 'jabber-roster-user-offline nil :foreground "#606060")
       (set-face-attribute 'jabber-roster-user-dnd nil :foreground "#94bff3" :weight 'bold)
       (set-face-attribute 'jabber-roster-user-error nil :foreground "#e37170" :background "#332323")
       (set-face-attribute 'jabber-title-small nil :inherit 'variable-pitch :weight 'bold :height 1.2)
       (set-face-attribute 'jabber-title-medium nil :inherit 'variable-pitch :weight 'bold :height 1.2)
       (set-face-attribute 'jabber-title-large nil :inherit 'variable-pitch :weight 'bold :height 1.2)
       (set-face-attribute 'jabber-chat-prompt-local nil :foreground "#f0dfaf" :weight 'bold)
       (set-face-attribute 'jabber-chat-prompt-foreign nil :foreground "#dfaf8f" :weight 'bold)
       (set-face-attribute 'jabber-rare-time-face nil :foreground "#8fb28f")
       )))

;#############################################################################
;#   Account definitions
;############################################################################
;; 'custom/jabber-account-list' has similar layout as below:
;;
;; (setq custom/jabber-account-list '(("abc@gmail.com/emacs"
;;                                     (:network-server . "talk.google.com")
;;                                     (:password . "12345")
;;                                     (:connection-type . ssl))
;;                                    ("xyz@jabber.ru/emacs"
;;                                     (:password . "1234567")
;;                                     (:network-server . "jabber.ru")
;;                                     (:disabled . t))))
(setq jabber-account-list custom/jabber-account-list)

(setq gnutls-algorithm-priority "NORMAL:+COMP-DEFLATE")

;#############################################################################
;#   Customizations
;############################################################################
(setq jabber-alert-info-message-hooks 'jabber-info-echo)
(setq jabber-alert-message-hooks 'jabber-message-beep jabber-message-scroll)
(setq jabber-alert-presence-hooks 'jabber-presence-update-roster)
(setq jabber-nickname (capitalize global-username))
(setq jabber-resource custom/jabber-resource)
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
(setq jabber-mode-line-mode t)
(setq jabber-alert-presence-message-function
      (lambda (who oldstatus newstatus statustext) nil))
(setq jabber-backlog-number 100)

(custom-set-faces '(jabber-chat-prompt-system ((t (:foreground "darkgreen" :weight bold)))))

;#############################################################################
;#   Jabber notifications
;############################################################################
;; Message alert hooks
(define-jabber-alert echo "Show a message in the echo area"
  (lambda (msg)
    (unless (minibuffer-prompt)
      (message "%s" msg))))


;#############################################################################
;#   Custom definitions and hooks
;############################################################################
(defun custom/jabber-chat-mode-hook ()
  (local-set-key (kbd "C-c C-l") 'custom-jabber/insert-inlove-smile)
  (local-set-key (kbd "C-c C-k") 'custom-jabber/insert-kiss-smile)
  (local-set-key (kbd "C-c C-y") 'custom-jabber/insert-shy-smile)
  (local-set-key (kbd "C-c C-t") 'custom-jabber/insert-copyright-sign)
  (local-set-key (kbd "C-c C-e") 'custom-jabber/cite-region)
  (local-set-key (kbd "C-c u r") 'upcase-region)
  (local-set-key (kbd "C-M-r")   'custom-jabber/wrap-replace-regexp)
  (local-set-key (kbd "C-M-m")   'custom-jabber/wrap-misreading)
  (local-set-key (kbd "<M-down>") 'custom/find-url-forward)
  (local-set-key (kbd "<M-up>") 'custom/find-url-backward)
  (local-set-key (kbd "C-c C-o C-l") 'browse-url))


(defun my-jabber-connect-hook (jc)
  (jabber-send-presence "" "I'm online" 10)
  (let* ((state-data (fsm-get-state-data jc))
         (server (plist-get state-data :server)))
    (message "%s" server)
    ))

(add-hook 'jabber-chat-mode-hook 'custom/jabber-chat-mode-hook)
(add-hook 'jabber-post-connect-hook 'jabber-autoaway-start)
(add-hook 'jabber-chat-mode-hook 'goto-address)
(add-hook 'jabber-post-connect-hooks 'my-jabber-connect-hook)

;#############################################################################
;#   Keybindings
;############################################################################
(global-set-key (kbd "C-x C-j C-r") 'jabber-switch-to-roster-buffer)
(global-set-key (kbd "C-x C-j C-a") 'jabber-activity-switch-to)
(global-set-key (kbd "C-c C-o C-r") 'custom/open-urls-in-region)

(provide 'rc-jabber)

;;; emacs-rc-jabber.el ends here
