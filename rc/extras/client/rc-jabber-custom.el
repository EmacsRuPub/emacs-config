;;; emacs-rc-jabber-custom.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet


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

  (defun jabber-urgency-hint ()
    (let ((count (length jabber-activity-jids)))
      (unless (= jabber-activity-jids-count count)
        (if (zerop count)
            (x-urgency-hint (selected-frame) nil)
          (x-urgency-hint (selected-frame) t))
        (setq jabber-activity-jids-count count))))
  (add-hook 'jabber-activity-update-hook 'jabber-urgency-hint)

  )

;; Message alert hooks
(define-jabber-alert echo "Show a message in the echo area"
  (lambda (msg)
    (unless (minibuffer-prompt)
      (message "%s" msg))))

(when (eq system-type 'darwin)
  (defvar growl-program "/usr/local/bin/growlnotify")

  (defun growl (title message &optional id)
    (if (eq id nil)
        (start-process "growl" " growl"
                       growl-program title "-w")
      (start-process "growl" " growl"
                     growl-program title "-w" "-d" id))
    (process-send-string " growl" message)
    (process-send-string " growl" "\n")
    (process-send-eof " growl"))

  ;; Make jabber.el notify through growl when I get a new message
  (setq jabber-message-alert-same-buffer nil)
  (defun pg-jabber-growl-notify (from buf text proposed-alert)
    "(jabber.el hook) Notify of new Jabber chat messages via Growl"
    (when (or jabber-message-alert-same-buffer
              (not (memq (selected-window) (get-buffer-window-list buf))))
      (if (jabber-muc-sender-p from)
          (growl (format "(PM) %s"
                         (jabber-jid-displayname (jabber-jid-user from)))
                 (format "%s: %s" (jabber-jid-resource from) text)
                 (format "jabber-from-%s" (jabber-jid-resource from)))
        (growl (format "%s" (jabber-jid-displayname from))
               text "jabber-from-unknown"))))
  (add-hook 'jabber-alert-message-hooks 'pg-jabber-growl-notify)

  ;; Same as above, for groupchats
  (defun pg-jabber-muc-growl-notify (nick group buf text proposed-alert)
    "(jabber.el hook) Notify of new Jabber MUC messages via Growl"
    (when (or jabber-message-alert-same-buffer
              (not (memq (selected-window) (get-buffer-window-list buf))))
      (if nick
          (when (or jabber-muc-alert-self
                    (not (string=
                          nick (cdr (assoc group *jabber-active-groupchats*)))))
            (growl (format "%s" (jabber-jid-displayname group))
                   (format "%s: %s" nick text)
                   (format "jabber-chat-%s" (jabber-jid-displayname group))))
        (growl (format "%s" (jabber-jid-displayname group))
               text "jabber-chat-unknown"))))
  (add-hook 'jabber-alert-muc-hooks 'pg-jabber-muc-growl-notify)

  (setq jabber-message-alert-same-buffer t)

  )

;;; emacs-rc-jabber-custom.el ends here
