;;; defun-jabber-custom-linux.el ---

;; Copyright (C) 2012 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:

;#############################################################################
;#   Linux-specific notifications code
;############################################################################

(defun jabber-libnotify-message(from msg)
  "Show MSG using libnotify"
  (let ((process-connection-type nil))
    (start-process "notification" nil "notify-send"
                   "-t" jabber-libnotify-timeout
                   "-i" jabber-libnotify-icon
                   from msg)))

(defun jabber-libnotify-message-display(from buffer text propsed-alert)
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

(provide 'defun-jabber-custom-linux)

;;; defun-jabber-custom-linux.el ends here
