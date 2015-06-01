;;; defun-jabber-custom.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(define-namespace custom/

(defvar use-zenburn-in-jabber t "Paint jabber-el buffers with zenburn colors")

(defun jabber-muc-sendto (&optional other-window)
  "Insert MUC participant nick into chat."
  (interactive)
  (end-of-buffer)
  (insert (concat (helm-comp-read "Send to: "
                                  (jabber-muc-nicknames)) ": ")))


(defvar helm-source-jabber-contact-jids
  '((name . "Jabber Contacts")
    (init . (lambda () (require 'jabber)))
    (candidates . (lambda () (mapcar 'cdr (helm-jabber-online-contacts))))
    (action . (lambda (x)
                (jabber-chat-with
                 (jabber-read-account)
                 x)))))

(defun helm-jabber-chat-with (arg)
  (interactive "P")
  (if (= (prefix-numeric-value arg) 4)
      (helm-other-buffer '(helm-source-jabber-contact-jids)
                         "*jabber: chat with*")
    (helm-other-buffer '(helm-source-jabber-contacts)
                       "*jabber: chat with*")))

(defun jabber-abbrev ()
  (interactive)
  (clipboard-kill-ring-save (region-beginning) (region-end))
  (end-of-buffer)
  (helm-yas-complete))

)

(provide 'custom-jabber)

;;; defun-jabber-custom.el ends here
