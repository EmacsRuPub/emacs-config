;;; rc-mail-wl.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(require 'wl)
(require 'elmo)
;; autoload configuration
;; (Not required if you have installed Wanderlust as XEmacs package)
(autoload 'wl "wl" "Wanderlust" t)
(autoload 'wl-other-frame "wl" "Wanderlust on new frame." t)
(autoload 'wl-draft "wl-draft" "Write draft with Wanderlust." t)
(autoload 'wl-user-agent-compose "wl-draft" nil t)


(setq wl-init-file (at-config-basedir "rc/.wl"))

;; SMTP server for mail posting. Default: nil
(setq wl-smtp-posting-server "localhost")
(setq wl-local-domain custom/wl-domain)
(setq wl-message-id-domain custom/wl-domain)
;; NNTP server for news posting. Default: nil
;; (setq wl-nntp-posting-server "your.nntp.example.com")

(require 'mel-b-el)
(defalias 'base64-internal-decode-string 'base64-decode-string)

(setq setqmime-browse-url-function 'browse-url-firefox)

;; wl-from "Me <me@example.com>"                  ;; my From:


;; ==============================

(if (boundp 'mail-user-agent)
    (setq mail-user-agent 'wl-user-agent))
(if (fboundp 'define-mail-user-agent)
    (define-mail-user-agent
      'wl-user-agent
      'wl-user-agent-compose
      'wl-draft-send
      'wl-draft-kill
      'mail-send-hook))

(setq elmo-maildir-folder-path custom/maildir-folder)

(setq mew-use-cached-passwd t)

(setq wl-stay-folder-window t)

(setq wl-fldmgr-sort-function 'wl-fldmgr-sort-standard)

(setq wl-fldmgr-add-complete-with-current-folder-list t)
(setq wl-folder-notify-deleted 'sync)

(setq wl-message-window-size '(2 . 2))
(setq wl-auto-select-next t)
(setq wl-folders-file "~/.folders")

(setq wl-folder-window-width 50)

(setq wl-folder-many-unsync-threshold 10)

(setq wl-folder-desktop-name "Home")

(setq wl-summary-subject-function 'identity)
;; (setq wl-summary-no-subject-message "")

(setq wl-summary-width nil)

(setq wl-auto-prefetch-first t)
(setq wl-message-buffer-prefetch-threshold nil)

;; (setq wl-folder-process-duplicates-alist
;;                  '(("^\\+draft$" . nil) ("^\\+trash$" . nil)
;;                    ("^\\*.*" . hide) (".*" . read)))


(setq wl-message-ignored-field-list '("^.*:"))
(setq wl-message-visible-field-list
  '("^\\(To\\|Cc\\):"
    "^Subject:"
    "^\\(From\\|Reply-To\\):"
    "^Organization:"
    "^Message-Id:"
    "^\\(Posted\\|Date\\):"
    ))
(setq  wl-message-sort-field-list
  '("^From"
    "^Organization:"
    "^X-Attribution:"
     "^Subject"
     "^Date"
     "^To"
     "^Cc"))

(setq wl-summary-flag-alist
      '((important "purple")
        (todo "red")
        (business "green" "B")
        (private "blue" "X")))


;; wl-mime-charset is used for saving wl-folders-file

;;  5.3.1 Cache File

;; The messages which have to access via network (e.x. IMAP, NNTP folder) are cached as a local file so as to save network traffic or to enable off-line operation. The cache file is saved under the directory `~/.elmo/cache'. To expire cache, type M-x elmo-cache-expire-by-size. The command deletes cache files to the specified size by the order of last accessed time.

(setq elmo-msgdb-extra-fields
      '("x-ml-name"
        "reply-to"
        "sender"
        "mailing-list"
        "newsgroups"))

(defun wl-setup-headers ()
  (wl-draft-config-exec)
  (flyspell-mode t)
  (auto-fill-mode t))
(add-hook 'wl-mail-setup-hook 'wl-setup-headers)

;; (setq wl-refile-rule-alist
;;       '(("x-ml-name"
;;          ("^Wanderlust" . "+wl")
;;          ("^Elisp" . "+elisp"))
;;         (("To" "Cc")
;;          ("\\([a-z]+\\)@gohome\\.org" . "+\\1"))
;;         ("From"
;;          ("me@gohome\\.org" . ("To" ("you@gohome\\.org" .
;;                                     "+from-me-to-you"))))))

(provide 'rc-mail-wl)

;;; rc-mail-wl.el ends here
