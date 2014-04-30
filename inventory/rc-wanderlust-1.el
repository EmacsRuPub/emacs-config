;; -*- coding: utf-8 -*-
;;
;; Filename: rc-wanderlust.el
;; Created: Вс авг 25 02:03:30 2013 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(autoload 'wl "wl" "Wanderlust" t)
(autoload 'wl-draft "wl-draft" "Write draft with Wanderlust." t)
(autoload 'wl-other-frame "wl" "Wanderlust on new frame." t)
(autoload 'wl-user-agent-compose "wl-draft" "Compose with Wanderlust." t)

(require 'octet)
;; (require 'defun-wanderlust)

(octet-mime-setup)

(eval-after-load "wl"
  '(progn
      (elmo-cache-expire-by-age  14)
      (elmo-cache-expire-by-size 4096)
      (elmo-search-register-engine
       'mu 'local-file
       :prog "mu"
       :args '("find" pattern "-o" "plain" "-f" "l")
       :charset 'utf-8)
      ))

(setq wl-user-mail-address-list
      '("aaermolov@gmail.com"
        "aermolov@hostcomm.ru"))
;; How messages with disposal mark ("d") are to be handled.
;; remove = instant removal (same as "D"), thrash = move to wl-trash-folder
;; string = move to string.
(setq wl-dispose-folder-alist
      '(("^%.*hostcomm\\.ru" . "%INBOX.Trash:\"aermolov@hostcomm.ru\"/clear@mail.hostcomm.ru")
        ("^%.*gmail\\.com" . "%[Gmail]/Trash:aaermolov/clear@imap.gmail.com:993!")
        ))
(setq wl-fcc-force-as-read t)
(setq wl-default-spec "%")
;;is run when wl-draft-send-and-exit or wl-draft-send is invoked:
;;(NOTE: "M-: wl-draft-parent-folder" => %INBOX:myname/clear@imap.gmail.com:993)
(setq wl-draft-config-alist
      '(
        ((string-match "hostcomm.ru" wl-draft-parent-folder)
         (template . "work")
         (wl-smtp-posting-user . "aermolov@hostcomm.ru")
         (wl-smtp-posting-server . "mail.hostcomm.ru")
         (wl-local-domain . "hostcomm.ru")
         (wl-smtp-posting-port . 465)
         (wl-smtp-authenticate-type ."plain")
         (wl-smtp-connection-type . 'ssl)
         ;; (wl-draft-folder . "%[Gmail]/Draft:aaermolov/clear@imap.gmail.com:993!")
         ;; ("Fcc" . "%INBOX.Sent:\"aermolov@hostcomm.ru\"/clear@mail.hostcomm.ru")
         ;; (wl-draft-folder . "%INBOX.Drafts:\"aermolov@hostcomm.ru\"/clear@mail.hostcomm.ru")
         )
        ;; ((string-match "inscomsolutions.ru" wl-draft-parent-folder)
        ;;  (template . "work")
        ;;  (wl-smtp-posting-user . "aermolov@inscomsolutions.ru")
        ;;  (wl-smtp-posting-server . "mail.hostcomm.ru")
        ;;  (wl-local-domain . "hostcomm.ru")
        ;;  (wl-smtp-posting-port . 465)
        ;;  (wl-smtp-authenticate-type ."plain")
        ;;  (wl-smtp-connection-type . 'ssl)
        ;;  ;; (wl-draft-folder . "%[Gmail]/Draft:aaermolov/clear@imap.gmail.com:993!")
        ;;  ;; ("Fcc" . "%INBOX.Sent:\"aermolov@hostcomm.ru\"/clear@mail.hostcomm.ru")
        ;;  ;; (wl-draft-folder . "%INBOX.Drafts:\"aermolov@hostcomm.ru\"/clear@mail.hostcomm.ru")
        ;;  )
        ((string-match "gmail.com" wl-draft-parent-folder)
         (template . "gmail")
         (wl-smtp-posting-user . "aaermolov")
         (wl-smtp-posting-server . "smtp.gmail.com")
         (wl-smtp-authenticate-type ."plain")
         (wl-smtp-connection-type . 'starttls)
         (wl-smtp-posting-port . 587)
         (wl-local-domain . "gmail.com")
         (wl-message-id-domain . "smtp.gmail.com"))))
;;choose template with C-c C-j
(setq wl-template-alist
      '(("gmail"
         (wl-from . "Александр Ермолов <aaermolov@gmail.com>")
         ("From" . wl-from))
        ("work"
         (wl-from . "Александр Ермолов <aermolov@hostcomm.ru>")
         ("From" . wl-from))))
(setq wl-forward-subject-prefix "Fwd: ")    ;; use "Fwd: " not "Forward: "
;; Uncomment the line below if you have problems with accented letters
;; (setq-default mime-transfer-level 8) ;; default value is 7
(setq elmo-search-default-engine 'mu)
(setq wl-summary-auto-sync-marks nil)
;; (setq smime-keys '(("aermolov@hostcomm.ru" "/home/octocat/hostcomm.pem")))

;; select correct email address when we _start_ writing a draft.
;; don't apply the templates when sending the draft otherwise
;; choosing another template with C-c C-j won't have any effect
(add-hook 'wl-mail-setup-hook 'wl-draft-config-exec)
(remove-hook 'wl-draft-send-hook 'wl-draft-config-exec)

(global-set-key (kbd "C-c C-w") 'wl)

(provide 'rc-wanderlust)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-wanderlust.el ends here
