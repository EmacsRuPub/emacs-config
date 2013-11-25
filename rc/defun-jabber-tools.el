;; -*- coding: utf-8 -*-
;;
;; Filename: defun-jabber-tools.el
;; Created: Пн ноя 25 16:34:10 2013 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'ido)
;; (provide 'jabber-tools)

(defvar *my-jid-history* '())

(defun my-jabber-read-jid-completing (prompt)
  (let* ((hist-items (remove-duplicates *my-jid-history* :test #'equal))
         (choices
          (mapcar #'symbol-name (jabber-concat-rosters))))
    (setf choices (append hist-items
                          (sort (set-difference choices hist-items :test #'equal)
                                #'string<)))
    (ido-completing-read prompt choices
                         nil nil nil '*my-jid-history*)))

(defun my-jabber-jid-connection (jid)
  (or (find-if
       #'(lambda (jc)
           (cl-find jid (plist-get (fsm-get-state-data jc) :roster)
                    :key #'symbol-name
                    :test #'equal))
       jabber-connections)
      (error "cannot determine connection for %s" jid)))

(defun my-jabber-chat-with (jid &optional other-window)
  "Open an empty chat window for chatting with JID.
With a prefix argument, open buffer in other window.
Returns the chat buffer."
  (interactive (list (my-jabber-read-jid-completing "Chat with: ")
                     current-prefix-arg))
  (let* ((jc (my-jabber-jid-connection jid))
         (buffer (jabber-chat-create-buffer jc jid)))
    (if other-window
        (switch-to-buffer-other-window buffer)
      (switch-to-buffer buffer))))

(global-set-key "\C-x\C-j\C-j" 'my-jabber-chat-with)

(provide 'defun-jabber-tools)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; defun-jabber-tools.el ends here
