;;; defun-jabber-custom-darwin.el ---

;; Copyright (C) 2012 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:

;#############################################################################
;#   Darwin-specific notifications code
;############################################################################

(define-namespace custom/

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

(defun pg-jabber-growl-notify (from buf text proposed-alert)
  "(jabber.el hook) Notify of new Jabber chat messages via Growl"
  (when (or jabber-message-alert-same-buffer
            (not (memq (selected-window) (get-buffer-window-list buf))))
    (if (jabber-muc-sender-p from)
        (growl (format "(PM) %s"
                       (jabber-jid-displayname (jabber-jid-user from)))
               (format "%s: %s" (jabber-jid-resource from)
                       (osd-text-to-utf-16-hex text))
               (format "jabber-from-%s" (jabber-jid-resource from)))
      (growl (format "%s" (jabber-jid-displayname from))
             (osd-text-to-utf-16-hex text) "jabber-from-unknown"))))

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
                 (format "%s: %s" nick (osd-text-to-utf-16-hex text))
                 (format "jabber-chat-%s" (jabber-jid-displayname group))))
      (growl (format "%s" (jabber-jid-displayname group))
             (osd-text-to-utf-16-hex text) "jabber-chat-unknown"))))

(defun osd-text-to-utf-16-hex (text)
  (let* ((utext (encode-coding-string text 'utf-8))
         (ltext (string-to-list utext)))
    (apply #'concat
           (mapcar (lambda (x) (format "%c" x)) ltext))))

)

(provide 'custom-jabber-darwin)

;;; defun-jabber-custom-darwin.el ends here
