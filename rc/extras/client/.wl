;; Appearance customization
(setq wl-stay-folder-window t)
(setq wl-folder-window-width 40)
(setq wl-message-window-size '(1 . 2))
(setq wl-draft-preview-attributes-buffer-lines 7)
(setq wl-summary-width nil)
(setq wl-summary-line-format "%n%T%P %W %D-%M-%Y %h:%m %t%[%c %f% %] %s")

(setq elmo-archive-use-cache nil) ;; disable cache for archives folders
(setq elmo-enable-disconnected-operation t) ;; offline mode on

(setq wl-summary-auto-refile-skip-marks nil)

(setq wl-refile-rule-alist
			'(("From"
				 ("^\"Sun Microsystems\"" . "+from/vendor_news")
				 ("^Sun Microsystems" . "+from/vendor_news")
				 ("atlassian.com>$" . "+from/vendor_news")
 				 ("@idealprice.ru>$" . "+from/vendor_news")
 				 ("<mailer@sender5.mail.ru>$" . "+from/vendor_news")
				 ;; 
				 ("<shtukabodhisanva@mail.ru>$" . "+private")
				 ("<liv.lebedeva@gmail.com>$" . "+private")
				 ("<katia-k@bk.ru>$" . "+private")
				 ("<rishkarainy@gmail.com>$" . "+private")
				 ("^4erdak.org" . "+private")
				 ;; 
				 ("<robot@moikrug.ru>$" . "+from/social")
 				 ("<myadmin@corp.mail.ru>$" . "+from/social")
				 ("twitter.com>$" . "+from/social")
				 ("<noreply@i-kino.com>$" . "+from/social")
 				 ("gq.net.ru>$" . "+from/social")
				 ;; 
				 ("^LADOSHKI" . "+from/ladoshki")
				 ("^\"Open Source\"" . "+from/nix_oss")
				 ("^The Geek Stuff" . "+from/geekstuff")
				 ("ozon.ru>$" . "+from/ozon")
				 ("ozon.ru$" . "+from/ozon")
				 ("^Imhonet News" . "+from/imhonet")
				 ("^info@site.hh.ru" . "+job")
				 ("ladoshki.com>$" . "+from/ladoshki")
				 ("intuit.ru>$" . "+from/intuit")
				 ("citforum.ru>$" . "+from/citforum")
				 ("^Smi2" . "+from/smi2")
				 ("^\"noreply@smi2.ru\"" . "+from/smi2")

				 ("<lj_notify@livejournal.com>$" . "+from/lj_notify")
 				 ("@linuxcenter.ru$" . "+from/linux")
 				 ("@samag.ru$" . "+from/nix_oss")
 				 ("noreply@drugme.ru$" . "+from/health")
				 ("^Рассылки@Mail.Ru" . "+from/vendor_news")
				 ("^MailList.ru: Новости Агавы" . "+from/vendor_news")
 				 ("wikidot.com>$" . "+from/vendor_news")
 				 ("<users@russianinternetweek.ru>$" . "+from/rocid")
				 ;;
				)
				("To"
				 ("^\"comp.hard.pcnews\"" . "+from/compnews")
				 ("^\"comp.hard.articles\"" . "+from/compnews")
				 ("^\"comp.hard.original050288\"" . "+from/compnews")
				 ("^\"comp.hard.interesno\"" . "+from/compnews")
				 ("^\"comp.hard.pcnews\"" . "+from/compnews")
				 ;; 
				 ("^\"news.3dfx\"" . "+from/graphics")
				 ("^\"comp.hard.nvworld\"" . "+from/graphics")
				 ("^\"news.reactor\"" . "+from/graphics")
				 ;; 
				 ("^\"comp.hard.encyclopedia\"" . "+from/hardware")
				 ("^\"comp.hard.nap\"" . "+from/hardware")
				 ("^\"hard.upgrade\"" . "+from/hardware")
				 ;; 
				 ("^\"industry.mcomm.mobisetnews\"" . "+from/mobile")
				 ("^\"comp.inet.news.sota1anons\"" . "+from/mobile")
				 ("^\"industry.mcomm.mobisetnews.mobisetreviews\"" . "+from/mobile")
				 ("^\"tech.helpix\"" . "+from/mobile")
				 ;;
				 ("^\"science.news.news\"" . "+from/science")
				 ("^\"science.news.izvestiascience\"" . "+from/science")
				 ("^\"science.exact.gap\"" . "+from/science")
				 ("^\"job.education.grants\"" . "+from/science")
				 ("^\"comp.soft.winsoft.science\"" . "+from/science")
				 ("^\"science.news.elementynews\"" . "+from/science")
				 ;;
				 ("^\"inet.bugtraq" . "+from/security")
				 ("^\"inet.safety.bezpeka\"" . "+from/security")
				 ("^\"inet.safety.securemergency\"" . "+from/security")
				 ;; 
				 ("^\"radio.oldradio\"" . "+from/romantic")
				 ("^\"inet.revew.ilesite\"" . "+from/romantic")
				 ;; 
				 ("^\"tech.airwar\"" . "+from/nebo")
				 ("^\"science.news.membrana\"" . "+from/membrana")
				 ("^\"tech.siberia\"" . "+from/ieee")
				 ("^\"science.news.inno\"" . "+from/inno")
				 ("^\"comp.soft.winsoft.fsdev\"" . "+from/winsoft.free")
				 ("^uneex" . "+from/uneex")
				 ("^\"comp.soft.linux.lcnews\"" . "+from/linux")
				 ("^\"comp.soft.linux.nixp" . "+from/linux")
				 ;;
				 ("^\"comp.soft.prog.programist\"" . "+from/programming")
				)
			 )
)

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
;; 	  (lambda ()
;; 	    (local-set-key "f" 'browse-url)))

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
;; 	  (lambda ()
;;  	    (when (string= "flowed"
;;  			   (cdr (assoc "format"
;;  				       (mime-content-type-parameters
;;  					(mime-entity-content-type entity)))))
;;  	      (fill-flowed))))

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