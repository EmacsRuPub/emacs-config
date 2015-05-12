;; -*- coding: utf-8 -*-
;;
;; Filename: defun-jabber-tools.el
;; Created: Пн ноя 25 16:34:10 2013 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; TODO: migrate to helm
(require 'ido)

(defvar *my-jid-history* '())

(defun my-jabber-jid-connection (jid)
  (or (find-if
       #'(lambda (jc)
           (cl-find jid (plist-get (fsm-get-state-data jc) :roster)
                    :key #'symbol-name
                    :test #'equal))
       jabber-connections)
      (error "cannot determine connection for %s" jid)))

(defun custom/jabber-muc-sendto (&optional other-window)
  "Insert MUC participant nick into chat."
  (interactive)
  (end-of-buffer)
  (insert (concat (helm-comp-read "Send to: "
                                  (jabber-muc-nicknames)) ": ")))


(defvar custom/helm-source-jabber-contact-jids
  '((name . "Jabber Contacts")
    (init . (lambda () (require 'jabber)))
    (candidates . (lambda () (mapcar 'cdr (helm-jabber-online-contacts))))
    (action . (lambda (x)
                (jabber-chat-with
                 (jabber-read-account)
                 x)))))

(defun custom/helm-jabber-chat-with (arg)
  (interactive "P")
  (if (= (prefix-numeric-value arg) 4)
      (helm-other-buffer '(custom/helm-source-jabber-contact-jids)
                     "*jabber: chat with*")
    (helm-other-buffer '(helm-source-jabber-contacts)
                     "*jabber: chat with*")))

(global-set-key "\C-x\C-j\C-j" 'custom/helm-jabber-chat-with)
(global-set-key "\C-x\C-j\C-s" 'custom/jabber-muc-sendto)

(provide 'custom-jabber-tools)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; defun-jabber-tools.el ends here
