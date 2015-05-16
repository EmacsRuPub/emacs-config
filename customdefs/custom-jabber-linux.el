;;; defun-jabber-custom-linux.el ---

;; Copyright (C) 2012 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:

;#############################################################################
;#   Linux-specific notifications code
;############################################################################

(define-namespace custom/

(defun jabber-libnotify-message(from msg)
  "Show MSG using libnotify"
  (let ((process-connection-type nil))
    (start-process "notification" nil "notify-send"
                   "-t" jabber-libnotify-timeout
                   "-i" jabber-libnotify-icon
                   from msg)))

(defun jabber-libnotify-message-display (from buffer text propsed-alert)
  (jabber-libnotify-message from text))

(defun x-urgency-hint (frame arg &optional source)
  (let* ((wm-hints (append (x-window-property
                            "WM_HINTS" frame "WM_HINTS"
                            (if source
                                source
                              (string-to-number
                               (frame-parameter frame 'outer-window-id)))
                            nil t) nil))
         (flags (car wm-hints)))
    (setcar wm-hints
            (if arg
                (logior flags #x00000100)
              (logand flags #xFFFFFEFF)))
    (x-change-window-property "WM_HINTS" wm-hints frame "WM_HINTS" 32 t)))

(defun jabber-urgency-hint ()
  (let ((count (length jabber-activity-jids)))
    (unless (= jabber-activity-jids-count count)
      (if (zerop count)
          (x-urgency-hint (selected-frame) nil)
        (x-urgency-hint (selected-frame) t))
      (setq jabber-activity-jids-count count))))

;; depends on s
(defun jabber-presence-urgency-hint (who oldstatus newstatus statustext proposed-alert)
  (when (remove-if (lambda (jid) (not (s-starts-with? (symbol-name who) jid))) *urgency-presence-jids*)
    (custom/notify "jabber" (format "Presence changed for %s: %s"
                                    who (if (get who 'connected) "online" "offline")))))

(defun notify (title message)
  "Notify the user using either the dbus based API or the `growl' one"
  (unless (and (fboundp 'dbus-register-signal)
               ;; avoid a bug in Emacs 24.0 under darwin
               (ignore-errors (require 'notifications nil t)))
    ;; else try notify.el
    (unless (fboundp 'notify)
      (ignore-errors (require 'notify nil 'noerror))))
  (condition-case nil
      (cond
       ;; Graphical notification
       ((fboundp 'notifications-notify) (notifications-notify :title title
                                                              :app-name "emacs"
                                                              :body message))
       ((fboundp 'notify)               (notify title message))
       ;; Fallback
       (t                               (error "Fallback to `message'")))
    ;; when notification function errored out, degrade gracefully to `message'
    (error (message "%s: %s" title message))))

)

(provide 'custom-jabber-linux)

;;; defun-jabber-custom-linux.el ends here
