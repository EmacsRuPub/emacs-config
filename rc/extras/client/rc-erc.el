;;; emacs-rc-erc.el --- 

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords: 
;; Requirements: 
;; Status: not intended to be distributed yet

;#############################################################################
;#   Load extensions
;############################################################################
(require 'erc)
(require 'erc-join)
(require 'erc-lang)
(require 'erc-fill)
(require 'erc-log)
(require 'erc-autoaway)
(require 'erc-services)
(require 'erc-menu)

;; (and
;;  (require 'erc-highlight-nicknames)
;;  (add-to-list 'erc-modules 'highlight-nicknames)
;;  (erc-update-modules))


;#############################################################################
;#   Initialization
;############################################################################
(erc-autojoin-mode t)
(erc-fill-mode t)
(erc-nickserv-mode 1)


;#############################################################################
;#   Customizations
;############################################################################
(setq erc-user-full-name custom/erc-full-name)
(setq erc-email-userid custom/gmail-address)
(setq erc-log-insert-log-on-open nil)
(setq erc-log-channels t)
(setq erc-log-channels-directory custom/erc-logs-directory)
(setq erc-save-buffer-on-part t)
(setq erc-hide-timestamps nil)
(setq erc-max-buffer-size 20000)
(setq erc-autoaway-idle-seconds 1200)
(setq erc-autoaway-message "I'm gone (autoaway after %i seconds)")
(setq erc-auto-discard-away t)
(setq erc-auto-query 'buffer)
(setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT"))
(setq erc-prompt-for-nickserv-password nil)
(setq erc-nickserv-passwords
      '((freenode     ((custom/erc-nick . custom/erc-nickserv-password)
		       (custom/erc-nick . custom/erc-nickserv-password)))))
(setq erc-encoding-coding-alist (quote (("#debian-russian" . cyrillic-koi8) ("#altlinux" . cyrillic-koi8) ("#unix.ru" . cyrillic-koi8) ("#fidorus" . cyrillic-koi8))))
(setq erc-nick custom/erc-main-nick)
(setq erc-nick-uniquifier "_")
(setq erc-prompt-for-password nil)
(setq erc-kill-queries-on-quit t)
;; (setq erc-server-coding-system (quote (koi8-r . koi8-r)))
(setq erc-server-coding-system (quote (cp1251 . cp1251)))


;#############################################################################
;#   Network and channel presets
;############################################################################
;; (setq erc-autojoin-channels-alist
      ;; '(("freenode.net" "#couchdb" "#haskell" "#git" "#xmonad")
	;; ("irc.freenode.net" "#git")
        ;; ("freenode.net" "#clojure")
	;; ("irc.int.ru" "#unix")
	;; ("irc.fu-berlin.de" "#unix.ru" "#fidorus")
	;; ("fu-berlin.de" "#unix.ru" "#fidorus")
	;; ))

;; (defun erc-connect ()
;;   "Connect to IRC."
;;   (interactive)
;;   (progn
;;     (erc-select :server "irc.int.ru" :port 6667 :nick custom/erc-nick)
;;     (erc-select :server "irc.freenode.net" :port 6667 :nick custom/erc-nick)
;; ;;    (erc-select :server "irc.fu-berlin.de" :port 6667 :nick "alexott")
;; 	))


;#############################################################################
;#   BitlBee
;############################################################################
(defvar bitlbee-password "geheim")

(defun bitlbee-identify ()
  "If we're on the bitlbee server, send the identify command to the &bitlbee channel."
  (when (and (string= "localhost" erc-session-server)
	     (string= "&bitlbee" (buffer-name)))
    (erc-message "PRIVMSG" (format "%s identify %s" 
				   (erc-default-target) 
				   bitlbee-password))))
(add-hook 'erc-join-hook 'bitlbee-identify)

(defun erc-cmd-ICQWHOIS (uin)
  "Queries icq-user with UIN `uin', and returns the result."
  (let* ((result (myerc-query-icq-user uin))
	 (fname (cdr (assoc 'fname result)))
	 (lname (cdr (assoc 'lname result)))
	 (nick (cdr (assoc 'nick result))))
    (erc-display-message nil 'notice (current-buffer) (format "%s (%s %s)" nick fname lname))))

;;; emacs-rc-erc.el ends here
