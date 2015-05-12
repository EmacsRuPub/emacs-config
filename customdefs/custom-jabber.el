;;; defun-jabber-custom.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(defvar use-zenburn-in-jabber t "Paint jabber-el buffers with zenburn colors")
(defvar *my-jid-history* '())

(defun custom/open-urls-in-region (beg end)
  "Open URLs between BEG and END."
  (interactive "r")
  (save-excursion
    (save-restriction
      (narrow-to-region beg end)
      (goto-char (point-min))
      (while (re-search-forward org-plain-link-re nil t)
        (org-open-at-point)))))

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

(defun custom/jabber-abbrev ()
  (interactive)
  (clipboard-kill-ring-save (region-beginning) (region-end))
  (end-of-buffer)
  (helm-yas-complete))

(provide 'custom-jabber)

;;; defun-jabber-custom.el ends here
