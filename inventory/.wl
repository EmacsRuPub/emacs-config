;; ;; Appearance customization
;; (setq wl-stay-folder-window t)
;; (setq wl-folder-window-width 40)
;; (setq wl-message-window-size '(1 . 2))
;; (setq wl-draft-preview-attributes-buffer-lines 7)
;; (setq wl-summary-width nil)
;; (setq wl-summary-line-format "%n%T%P %W %D-%M-%Y %h:%m %t%[%c %f% %] %s")

;; (setq elmo-archive-use-cache nil) ;; disable cache for archives folders
;; (setq elmo-enable-disconnected-operation t) ;; offline mode on

;; (setq wl-summary-auto-refile-skip-marks nil)

;; (setq wl-refile-rule-alist
;;      '(("From"
;;         ("^\"Sun Microsystems\"" . "+from/vendor_news")
;;         ("^Sun Microsystems" . "+from/vendor_news")
;;         ("atlassian.com>$" . "+from/vendor_news")
;;           ("@idealprice.ru>$" . "+from/vendor_news")
;;           ("<mailer@sender5.mail.ru>$" . "+from/vendor_news")
;;         ;;
;;         ("<shtukabodhisanva@mail.ru>$" . "+private")
;;         ("<liv.lebedeva@gmail.com>$" . "+private")
;;         ("<katia-k@bk.ru>$" . "+private")
;;         ("<rishkarainy@gmail.com>$" . "+private")
;;         ("^4erdak.org" . "+private")
;;         ;;
;;         ("<robot@moikrug.ru>$" . "+from/social")
;;           ("<myadmin@corp.mail.ru>$" . "+from/social")
;;         ("twitter.com>$" . "+from/social")
;;         ("<noreply@i-kino.com>$" . "+from/social")
;;           ("gq.net.ru>$" . "+from/social")
;;         ;;
;;         ("^LADOSHKI" . "+from/ladoshki")
;;         ("^\"Open Source\"" . "+from/nix_oss")
;;         ("^The Geek Stuff" . "+from/geekstuff")
;;         ("ozon.ru>$" . "+from/ozon")
;;         ("ozon.ru$" . "+from/ozon")
;;         ("^Imhonet News" . "+from/imhonet")
;;         ("^info@site.hh.ru" . "+job")
;;         ("ladoshki.com>$" . "+from/ladoshki")
;;         ("intuit.ru>$" . "+from/intuit")
;;         ("citforum.ru>$" . "+from/citforum")
;;         ("^Smi2" . "+from/smi2")
;;         ("^\"noreply@smi2.ru\"" . "+from/smi2")

;;         ("<lj_notify@livejournal.com>$" . "+from/lj_notify")
;;           ("@linuxcenter.ru$" . "+from/linux")
;;           ("@samag.ru$" . "+from/nix_oss")
;;           ("noreply@drugme.ru$" . "+from/health")
;;         ("^Рассылки@Mail.Ru" . "+from/vendor_news")
;;         ("^MailList.ru: Новости Агавы" . "+from/vendor_news")
;;           ("wikidot.com>$" . "+from/vendor_news")
;;           ("<users@russianinternetweek.ru>$" . "+from/rocid")
;;         ;;
;;        )
;;        ("To"
;;         ("^\"comp.hard.pcnews\"" . "+from/compnews")
;;         ("^\"comp.hard.articles\"" . "+from/compnews")
;;         ("^\"comp.hard.original050288\"" . "+from/compnews")
;;         ("^\"comp.hard.interesno\"" . "+from/compnews")
;;         ("^\"comp.hard.pcnews\"" . "+from/compnews")
;;         ;;
;;         ("^\"news.3dfx\"" . "+from/graphics")
;;         ("^\"comp.hard.nvworld\"" . "+from/graphics")
;;         ("^\"news.reactor\"" . "+from/graphics")
;;         ;;
;;         ("^\"comp.hard.encyclopedia\"" . "+from/hardware")
;;         ("^\"comp.hard.nap\"" . "+from/hardware")
;;         ("^\"hard.upgrade\"" . "+from/hardware")
;;         ;;
;;         ("^\"industry.mcomm.mobisetnews\"" . "+from/mobile")
;;         ("^\"comp.inet.news.sota1anons\"" . "+from/mobile")
;;         ("^\"industry.mcomm.mobisetnews.mobisetreviews\"" . "+from/mobile")
;;         ("^\"tech.helpix\"" . "+from/mobile")
;;         ;;
;;         ("^\"science.news.news\"" . "+from/science")
;;         ("^\"science.news.izvestiascience\"" . "+from/science")
;;         ("^\"science.exact.gap\"" . "+from/science")
;;         ("^\"job.education.grants\"" . "+from/science")
;;         ("^\"comp.soft.winsoft.science\"" . "+from/science")
;;         ("^\"science.news.elementynews\"" . "+from/science")
;;         ;;
;;         ("^\"inet.bugtraq" . "+from/security")
;;         ("^\"inet.safety.bezpeka\"" . "+from/security")
;;         ("^\"inet.safety.securemergency\"" . "+from/security")
;;         ;;
;;         ("^\"radio.oldradio\"" . "+from/romantic")
;;         ("^\"inet.revew.ilesite\"" . "+from/romantic")
;;         ;;
;;         ("^\"tech.airwar\"" . "+from/nebo")
;;         ("^\"science.news.membrana\"" . "+from/membrana")
;;         ("^\"tech.siberia\"" . "+from/ieee")
;;         ("^\"science.news.inno\"" . "+from/inno")
;;         ("^\"comp.soft.winsoft.fsdev\"" . "+from/winsoft.free")
;;         ("^uneex" . "+from/uneex")
;;         ("^\"comp.soft.linux.lcnews\"" . "+from/linux")
;;         ("^\"comp.soft.linux.nixp" . "+from/linux")
;;         ;;
;;         ("^\"comp.soft.prog.programist\"" . "+from/programming")
;;        )
;;       )
;; )

;; (thread show rules)
;; (setq wl-thread-indent-level 4
;; wl-thread-have-younger-brother-str "+"
;; wl-thread-youngest-child-str "+"
;; wl-thread-vertical-str "|"
;; wl-thread-horizontal-str "-"
;; wl-thread-space-str " ")


;; SSL parameters
;; (setq ssl-certificate-verification-policy 1)
;; (setq ssl-program-name "gnutls-cli")
;; (setq ssl-program-arguments '("-p" service host))

;; LDAP, if ever needed (examples below)
;; (setq ldap-verbose t)
;; (setq ldap-default-host "sonic.0.com")
;; (setq ldap-default-base "dc=0,dc=com") ;; ldap-default-base "ou=users,dc=domain,dc=com"


;; IMAP
;; (setq elmo-imap4-default-server "imap.gmail.com")
;; (setq elmo-imap4-default-user "aaermolov@gmail.com")
;; (setq elmo-imap4-default-user "aaermolov")
;; (setq elmo-imap4-default-authenticate-type 'clear)
;; (setq elmo-imap4-default-port '993)
;; (setq elmo-imap4-default-stream-type 'ssl)


;; Extra message fields to look up on refile (REVIEW LATER)
;; (setq elmo-msgdb-extra-fields
;;       '("x-ml-name"
;;         "reply-to"
;;         "sender"
;;         "mailing-list"
;;         "newsgroups"))


;; ==========================================================================



;; ;; browse url key
;; (add-hook 'mime-view-mode-hook
;;    (lambda ()
;;      (local-set-key "f" 'browse-url)))

;; ;; Cancel-Lock
;; ;; (setq canlock-password "<yourpassword>")
;; ;; (autoload 'canlock-insert-header "canlock")
;; ;; (autoload 'wl-summary-canlock-verify "canlock")
;; ;; (setq canlock-sha1-function-for-verify 'canlock-sha1-with-ssleay)
;; ;; (add-hook 'wl-news-send-pre-hook
;; ;;           'canlock-insert-header t)
;; ;; (setq canlock-ignore-errors t)

;; ;; Reading f=f
;; (autoload 'fill-flowed "flow-fill")
;; (add-hook 'mime-display-text/plain-hook
;;    (lambda ()
;;        (when (string= "flowed"
;;           (cdr (assoc "format"
;;                 (mime-content-type-parameters
;;            (mime-entity-content-type entity)))))
;;          (fill-flowed))))

;; ;; (mime-edit-insert-tag "text" "plain" "; format=flowed")

;; (setq mime-header-accept-quoted-encoded-words t)
;; (setq eword-lexical-analyze-cache nil)

;; (setq wl-summary-auto-sync-marks nil)


;; Emacs with Wanderlust and GMail
;; Emacs with Wanderlust IMAP mailclient

;; You have multiple workstations from which you want to approach your email. Maybe because you use both your workstation and your laptop. Or because you want to use email from different locations. Whatever the reason, if you have more than one computer from which you want to have access to your mailboxes, IMAP can provide a good way to get things nicely organized. You could also use a hosted exchange service for extra organization.

;; The IMAP protocol let you access your mailboxes, open emails to read without removing the mail from the mailserver. So the next time you log in, your email is still there. (Exept when you deliberately want to delete mail).

;; Most pop3-mailservers can do IMAP.

;; To approach an IMAP mailserver from within Emacs, you need to install additional software in Emacs. Wanderlust is an proven solution to add IMAP capabilities to Emacs.
;; Wanderlust and GMail HOWTO

;; It is very easy to configure Wanderlust to access your GMail account.

;; Here are the steps to do so:

;;    1. Get wanderlust
;;    2. Create ~/.folders
;;    3. Append the wanderlust configuration to ~/.emacs
;;    4. Start emacs, start wanderlust and enjoy the most effecient and effective GMail client in the world

;; Get wanderlust

;; apt-get install wl


;; If you don't have Debian, this is where you can find Wanderlust
;; Create ~/.folders

;; This is the minimal content of ~/.folders:

;; %inbox  "inbox"
;; +trash  "Trash"
;; +draft  "Drafts"

;; Append the wanderlust configuration to ~/.emacs

;; Put this in your ~/.emacs:

;; ;; wanderlust
;; (autoload 'wl "wl" "Wanderlust" t)
;; (autoload 'wl-other-frame "wl" "Wanderlust on new frame." t)
;; (autoload 'wl-draft "wl-draft" "Write draft with Wanderlust." t)

;; ;; IMAP
;; (setq elmo-imap4-default-server "imap.gmail.com")
;; (setq elmo-imap4-default-user "<accountname>@gmail.com")
;; (setq elmo-imap4-default-authenticate-type 'clear)
;; (setq elmo-imap4-default-port '993)
;; (setq elmo-imap4-default-stream-type 'ssl)

;; (setq elmo-imap4-use-modified-utf7 t)

;; ;; SMTP
;; (setq wl-smtp-connection-type 'starttls)
;; (setq wl-smtp-posting-port 587)
;; (setq wl-smtp-authenticate-type "plain")
;; (setq wl-smtp-posting-user "mattofransen")
;; (setq wl-smtp-posting-server "smtp.gmail.com")
;; (setq wl-local-domain "gmail.com")

;; (setq wl-default-folder "%inbox")
;; (setq wl-default-spec "%")
;; (setq wl-draft-folder "%[Gmail]/Drafts") ; Gmail IMAP
;; (setq wl-trash-folder "%[Gmail]/Trash")

;; (setq wl-folder-check-async t)

;; (setq elmo-imap4-use-modified-utf7 t)

;; (autoload 'wl-user-agent-compose "wl-draft" nil t)
;; (if (boundp 'mail-user-agent)
;;     (setq mail-user-agent 'wl-user-agent))
;; (if (fboundp 'define-mail-user-agent)
;;     (define-mail-user-agent
;;       'wl-user-agent
;;       'wl-user-agent-compose
;;       'wl-draft-send
;;       'wl-draft-kill
;;       'mail-send-hook))

;; Start emacs, start wanderlust and enjoy the most effecient and effective GMail client in the world

;; Start emacs and do

;; M-x wl


;; Now you will be prompted for your gmail password. After this, you can access your gmail inbox.

;; If you want to open other mailboxes besides inbox you should add them to your ~/.folders (I have not tested this).

;; You can send email through your gmail account to. Create a new mail in Wanderlust and
;; send it. You will be prompted for your password again and your mail is sent.



;; GPG and Emacs with Wanderlust
;; Use Wanderlust to encrypt and decrypt messages

;; Wanderlust is the IMAP mailclient for Emacs. With the help of mailcrypt, Wanderlust can encrypt and decrypt messages through GnuPG (sometimes called openpgp).
;; Get GPG

;; If you already haven't done so, install the GNU Privacy Guard (GnuPG). Your distribution almost certainly comes with a gpg package.
;; Get Mailcrypt

;; Mailcrypt makes the use of gpg within Emacs easy.
;; Setup .emacs

;; To prevent mailcrypt complain about the read only message buffer some tinkering have to be done to your .emacs file. After some googlesearches I found the following to work:

;; (require 'mailcrypt)
;; (add-hook 'wl-summary-mode-hook 'mc-install-read-mode)
;; (add-hook 'wl-mail-setup-hook 'mc-install-write-mode)

;; (defun mc-wl-verify-signature ()
;;   (interactive)
;;   (save-window-excursion
;;     (wl-summary-jump-to-current-message)
;;     (mc-verify)))

;; (defun mc-wl-decrypt-message ()
;;   (interactive)
;;   (save-window-excursion
;;     (wl-summary-jump-to-current-message)
;;     (let ((inhibit-read-only t))
;;       (mc-decrypt))))

;; (eval-after-load "mailcrypt"
;;   '(setq mc-modes-alist
;;        (append
;;         (quote
;;          ((wl-draft-mode (encrypt . mc-encrypt-message)
;;             (sign . mc-sign-message))
;;           (wl-summary-mode (decrypt . mc-wl-decrypt-message)
;;             (verify . mc-wl-verify-signature))))
;;         mc-modes-alist)))

;; Encrypt message in Wanderlust

;; To encrypt a message, call M-x mc-encrypt.
;; Decrypt messages in Wanderlust

;; To decrypt a message, call M-x mc-wl-decrypt-message from the summary-buffer. You will be prompted for your password and the message will be decrypted.
;; Use Wanderlust and GMail to send and receive encrypted email

;; ;;; rc-mail-wl.el ---

;; ;; Copyright (C) 2011 Alex Ermolov
;; ;;
;; ;; Author: aaermolov@gmail.com
;; ;; Keywords:
;; ;; Requirements:
;; ;; Status: not intended to be distributed yet

;; (require 'wl)
;; (require 'elmo)
;; ;; autoload configuration
;; ;; (Not required if you have installed Wanderlust as XEmacs package)
;; (autoload 'wl "wl" "Wanderlust" t)
;; (autoload 'wl-other-frame "wl" "Wanderlust on new frame." t)
;; (autoload 'wl-draft "wl-draft" "Write draft with Wanderlust." t)
;; (autoload 'wl-user-agent-compose "wl-draft" nil t)


;; (setq wl-init-file (at-config-basedir "rc/.wl"))

;; ;; SMTP server for mail posting. Default: nil
;; (setq wl-smtp-posting-server "localhost")
;; (setq wl-local-domain custom/wl-domain)
;; (setq wl-message-id-domain custom/wl-domain)
;; ;; NNTP server for news posting. Default: nil
;; ;; (setq wl-nntp-posting-server "your.nntp.example.com")

;; (require 'mel-b-el)
;; (defalias 'base64-internal-decode-string 'base64-decode-string)

;; (setq setqmime-browse-url-function 'browse-url-firefox)

;; ;; wl-from "Me <me@example.com>"                  ;; my From:


;; ;; ==============================

;; (if (boundp 'mail-user-agent)
;;     (setq mail-user-agent 'wl-user-agent))
;; (if (fboundp 'define-mail-user-agent)
;;     (define-mail-user-agent
;;       'wl-user-agent
;;       'wl-user-agent-compose
;;       'wl-draft-send
;;       'wl-draft-kill
;;       'mail-send-hook))

;; (setq elmo-maildir-folder-path custom/maildir-folder)

;; (setq mew-use-cached-passwd t)

;; (setq wl-stay-folder-window t)

;; (setq wl-fldmgr-sort-function 'wl-fldmgr-sort-standard)

;; (setq wl-fldmgr-add-complete-with-current-folder-list t)
;; (setq wl-folder-notify-deleted 'sync)

;; (setq wl-message-window-size '(2 . 2))
;; (setq wl-auto-select-next t)
;; (setq wl-folders-file "~/.folders")

;; (setq wl-folder-window-width 50)

;; (setq wl-folder-many-unsync-threshold 10)

;; (setq wl-folder-desktop-name "Home")

;; (setq wl-summary-subject-function 'identity)
;; ;; (setq wl-summary-no-subject-message "")

;; (setq wl-summary-width nil)

;; (setq wl-auto-prefetch-first t)
;; (setq wl-message-buffer-prefetch-threshold nil)

;; ;; (setq wl-folder-process-duplicates-alist
;; ;;                  '(("^\\+draft$" . nil) ("^\\+trash$" . nil)
;; ;;                    ("^\\*.*" . hide) (".*" . read)))


;; (setq wl-message-ignored-field-list '("^.*:"))
;; (setq wl-message-visible-field-list
;;   '("^\\(To\\|Cc\\):"
;;     "^Subject:"
;;     "^\\(From\\|Reply-To\\):"
;;     "^Organization:"
;;     "^Message-Id:"
;;     "^\\(Posted\\|Date\\):"
;;     ))
;; (setq  wl-message-sort-field-list
;;   '("^From"
;;     "^Organization:"
;;     "^X-Attribution:"
;;      "^Subject"
;;      "^Date"
;;      "^To"
;;      "^Cc"))

;; (setq wl-summary-flag-alist
;;       '((important "purple")
;;         (todo "red")
;;         (business "green" "B")
;;         (private "blue" "X")))


;; ;; wl-mime-charset is used for saving wl-folders-file

;; ;;  5.3.1 Cache File

;; ;; The messages which have to access via network (e.x. IMAP, NNTP folder) are cached as a local file so as to save network traffic or to enable off-line operation. The cache file is saved under the directory `~/.elmo/cache'. To expire cache, type M-x elmo-cache-expire-by-size. The command deletes cache files to the specified size by the order of last accessed time.

;; (setq elmo-msgdb-extra-fields
;;       '("x-ml-name"
;;         "reply-to"
;;         "sender"
;;         "mailing-list"
;;         "newsgroups"))

;; (defun wl-setup-headers ()
;;   (wl-draft-config-exec)
;;   (flyspell-mode t)
;;   (auto-fill-mode t))
;; (add-hook 'wl-mail-setup-hook 'wl-setup-headers)

;; ;; (setq wl-refile-rule-alist
;; ;;       '(("x-ml-name"
;; ;;          ("^Wanderlust" . "+wl")
;; ;;          ("^Elisp" . "+elisp"))
;; ;;         (("To" "Cc")
;; ;;          ("\\([a-z]+\\)@gohome\\.org" . "+\\1"))
;; ;;         ("From"
;; ;;          ("me@gohome\\.org" . ("To" ("you@gohome\\.org" .
;; ;;                                     "+from-me-to-you"))))))

;; (provide 'rc-mail-wl)

;;; rc-mail-wl.el ends here


;; -*- coding: utf-8 -*-
;;
;; Filename: rc-wanderlust.el
;; Created: Вт сен 17 21:06:40 2013 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; Reading f=f
;; (autoload 'fill-flowed "flow-fill")
;; (add-hook 'mime-display-text/plain-hook
;;           (lambda ()
;;             (when (string= "flowed"
;;                            (cdr (assoc "format"
;;                                        (mime-content-type-parameters
;;                                         (mime-entity-content-type entity)))))
;;               (fill-flowed))))

;; (mime-edit-insert-tag "text" "plain" "; format=flowed")




;; (add-hook 'wl-summary-mode-hook 'mc-install-read-mode)
;; (add-hook 'wl-mail-setup-hook 'mc-install-write-mode)


;; (eval-after-load "mailcrypt"
;;   '(setq mc-modes-alist
;;          (append
;;           '((wl-draft-mode (encrypt . mc-encrypt-message)
;;                            (sign . mc-sign-message))
;;             (wl-summary-mode (decrypt . mc-wl-decrypt-message)
;;                              (verify . mc-wl-verify-signature)))
;;           mc-modes-alist)))


;; ;;Cobbled together from posts by Erik Hetzner & Harald Judt to
;; ;; wl-en@lists.airs.net by Jonathan Groll (msg 4128)

;; (defun mime-edit-insert-multiple-files ()
;;   "Insert MIME parts from multiple files."
;;   (interactive)
;;   (let ((dir default-directory))
;;     (let ((next-file (expand-file-name
;;                       (read-file-name "Insert file as MIME message: "
;;                                       dir))))
;;       (setq file-list (file-expand-wildcards next-file))
;;       (while (car file-list)
;;         (mime-edit-insert-file (car file-list))
;;         (setq file-list (cdr file-list))))))

;; (global-set-key "\C-c\C-x\C-a" 'mime-edit-insert-multiple-files)

;; (add-hook
;;  'mime-view-mode-hook
;;  '(lambda ()
;;     "Disable 'v' for mime-play."
;;     ;; Key bindings
;;     (local-set-key [?v] () )
;;     ))

;; (setq wl-summary-showto-folder-regexp ".*Sent.*")

;; ;; You should set this variable if you use multiple e-mail addresses.
;; (setq wl-user-mail-address-list  '("my.name@gmail.com"
;;                                    "myname@gmail.com"
;;                                    "myname@company.com"))

;; ;; sort the summary
;; (defun my-wl-summary-sort-hook ()
;;   (wl-summary-rescan "date"))

;; (add-hook 'wl-summary-prepared-hook 'my-wl-summary-sort-hook)

;; ;;don't remember "n"/"p" direction when flagging messages:
;; (setq wl-summary-move-direction-toggle nil)

;; (require 'w3m)
;; (require 'mime-w3m)

;; (eval-after-load "w3m"
;;   '(progn
;;      (define-key w3m-mode-map [left] 'backward-char)
;;      (define-key w3m-mode-map [right] 'forward-char)
;;      (define-key w3m-mode-map [up] 'previous-line)
;;      (define-key w3m-mode-map [down] 'next-line)
;;      (define-key w3m-minor-mode-map [left] 'backward-char)
;;      (define-key w3m-minor-mode-map [right] 'forward-char)
;;      (define-key w3m-minor-mode-map [up] 'previous-line)
;;      (define-key w3m-minor-mode-map [down] 'next-line)
;;      ))

;; (setq wl-summary-search-parent-by-subject-regexp nil)

;; (setq wl-use-folder-petname '(modeline read-folder))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-wanderlust.el ends here


;; ;; -*- coding: utf-8 -*-
;; ;;
;; ;; Filename: rc-wanderlust.el
;; ;; Created: Вс авг 25 02:03:30 2013 (+0400)
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (autoload 'wl "wl" "Wanderlust" t)
;; (autoload 'wl-draft "wl-draft" "Write draft with Wanderlust." t)
;; (autoload 'wl-other-frame "wl" "Wanderlust on new frame." t)
;; (autoload 'wl-user-agent-compose "wl-draft" "Compose with Wanderlust." t)

;; (require 'octet)
;; ;; (require 'defun-wanderlust)

;; (octet-mime-setup)

;; (eval-after-load "wl"
;;   '(progn
;;       (elmo-cache-expire-by-age  14)
;;       (elmo-cache-expire-by-size 4096)
;;       (elmo-search-register-engine
;;        'mu 'local-file
;;        :prog "mu"
;;        :args '("find" pattern "-o" "plain" "-f" "l")
;;        :charset 'utf-8)
;;       ))

;; (setq wl-user-mail-address-list
;;       '("aaermolov@gmail.com"
;;         "aermolov@hostcomm.ru"))
;; ;; How messages with disposal mark ("d") are to be handled.
;; ;; remove = instant removal (same as "D"), thrash = move to wl-trash-folder
;; ;; string = move to string.
;; (setq wl-dispose-folder-alist
;;       '(("^%.*hostcomm\\.ru" . "%INBOX.Trash:\"aermolov@hostcomm.ru\"/clear@mail.hostcomm.ru")
;;         ("^%.*gmail\\.com" . "%[Gmail]/Trash:aaermolov/clear@imap.gmail.com:993!")
;;         ))
;; (setq wl-fcc-force-as-read t)
;; (setq wl-default-spec "%")
;; ;;is run when wl-draft-send-and-exit or wl-draft-send is invoked:
;; ;;(NOTE: "M-: wl-draft-parent-folder" => %INBOX:myname/clear@imap.gmail.com:993)
;; (setq wl-draft-config-alist
;;       '(
;;         ((string-match "hostcomm.ru" wl-draft-parent-folder)
;;          (template . "work")
;;          (wl-smtp-posting-user . "aermolov@hostcomm.ru")
;;          (wl-smtp-posting-server . "mail.hostcomm.ru")
;;          (wl-local-domain . "hostcomm.ru")
;;          (wl-smtp-posting-port . 465)
;;          (wl-smtp-authenticate-type ."plain")
;;          (wl-smtp-connection-type . 'ssl)
;;          ;; (wl-draft-folder . "%[Gmail]/Draft:aaermolov/clear@imap.gmail.com:993!")
;;          ;; ("Fcc" . "%INBOX.Sent:\"aermolov@hostcomm.ru\"/clear@mail.hostcomm.ru")
;;          ;; (wl-draft-folder . "%INBOX.Drafts:\"aermolov@hostcomm.ru\"/clear@mail.hostcomm.ru")
;;          )
;;         ;; ((string-match "inscomsolutions.ru" wl-draft-parent-folder)
;;         ;;  (template . "work")
;;         ;;  (wl-smtp-posting-user . "aermolov@inscomsolutions.ru")
;;         ;;  (wl-smtp-posting-server . "mail.hostcomm.ru")
;;         ;;  (wl-local-domain . "hostcomm.ru")
;;         ;;  (wl-smtp-posting-port . 465)
;;         ;;  (wl-smtp-authenticate-type ."plain")
;;         ;;  (wl-smtp-connection-type . 'ssl)
;;         ;;  ;; (wl-draft-folder . "%[Gmail]/Draft:aaermolov/clear@imap.gmail.com:993!")
;;         ;;  ;; ("Fcc" . "%INBOX.Sent:\"aermolov@hostcomm.ru\"/clear@mail.hostcomm.ru")
;;         ;;  ;; (wl-draft-folder . "%INBOX.Drafts:\"aermolov@hostcomm.ru\"/clear@mail.hostcomm.ru")
;;         ;;  )
;;         ((string-match "gmail.com" wl-draft-parent-folder)
;;          (template . "gmail")
;;          (wl-smtp-posting-user . "aaermolov")
;;          (wl-smtp-posting-server . "smtp.gmail.com")
;;          (wl-smtp-authenticate-type ."plain")
;;          (wl-smtp-connection-type . 'starttls)
;;          (wl-smtp-posting-port . 587)
;;          (wl-local-domain . "gmail.com")
;;          (wl-message-id-domain . "smtp.gmail.com"))))
;; ;;choose template with C-c C-j
;; (setq wl-template-alist
;;       '(("gmail"
;;          (wl-from . "Александр Ермолов <aaermolov@gmail.com>")
;;          ("From" . wl-from))
;;         ("work"
;;          (wl-from . "Александр Ермолов <aermolov@hostcomm.ru>")
;;          ("From" . wl-from))))
;; (setq wl-forward-subject-prefix "Fwd: ")    ;; use "Fwd: " not "Forward: "
;; ;; Uncomment the line below if you have problems with accented letters
;; ;; (setq-default mime-transfer-level 8) ;; default value is 7
;; (setq elmo-search-default-engine 'mu)
;; (setq wl-summary-auto-sync-marks nil)
;; ;; (setq smime-keys '(("aermolov@hostcomm.ru" "/home/octocat/hostcomm.pem")))

;; ;; select correct email address when we _start_ writing a draft.
;; ;; don't apply the templates when sending the draft otherwise
;; ;; choosing another template with C-c C-j won't have any effect
;; (add-hook 'wl-mail-setup-hook 'wl-draft-config-exec)
;; (remove-hook 'wl-draft-send-hook 'wl-draft-config-exec)

;; (global-set-key (kbd "C-c C-w") 'wl)

;; (provide 'rc-wanderlust)
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;; rc-wanderlust.el ends here
