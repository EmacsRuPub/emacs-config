;; -*- coding: utf-8 -*-
;;
;; Filename: rc-clients.el
;; Created:  Fri May 30 19:10:47 2014 +0400
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package term
  :config
  (progn
    (add-hook 'term-exec-hook 'custom/term-exec-hook)
    (define-key term-raw-map (kbd "C-c C-y") 'term-paste)
    (setq explicit-shell-file-name "/bin/zsh")
    ))

(use-package erc
  :defer t
  :init
  (use-package erc-pcomplete)
  (use-package erc-join)
  (use-package erc-lang)
  (use-package erc-fill)
  (use-package erc-log)
  (use-package erc-autoaway)
  (use-package erc-services)
  (use-package erc-menu)
  (use-package erc-ring)
  (use-package erc-match)
  (use-package erc-nicklist)
  (use-package erc-highlight-nicknames)
  :config
  (progn
    (erc-pcomplete-mode 1)
    (bind-key "s" 'custom/connect-slack-irc custom-clients-keymap)
    (bind-key "q" 'custom/leave-irc-server custom-clients-keymap)
    (bind-key "b" 'custom/select-erc-buffer custom-clients-keymap)
    (bind-key "u" 'custom/select-erc-unread-buffer custom-clients-keymap)
    (bind-key "i" '(lambda () (interactive) (custom/insert-erc-nick t)) custom-clients-keymap)
    (bind-key "z" 'custom/cite-chat-region custom-clients-keymap)
    (bind-key "M-<up>" 'custom/find-url-backward erc-mode-map)
    (bind-key "M-<down>" 'custom/find-url-forward erc-mode-map)
    (setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT" "MODE"
                                    "324" "329" "332" "333" "353" "477"))
    (setq erc-kill-queries-on-quit t)
    (setq erc-autojoin-channels-alist
          '(("irc.freenode.net" "#git" "#stumpwm")
            ))
    (setq erc-keywords '((".*Online.*" (:foreground "green"))
                         (".*Busy" (:foreground "red"))
                         (".*Away" (:foreground "red"))
                         (".*Idle" (:foreground "orange"))
                         ))
    (setq erc-nickserv-passwords
          '((freenode ((private/erc-nick-main . private/erc-password-main)
                       (private/erc-nick-work . private/erc-password-work)))))
    (setq erc-prompt-for-nickserv-password nil)
    (setq erc-nick private/erc-nick-main)
    (setq erc-track-priority-faces-only 'all)
    (setq erc-log-channels-directory custom/erc-logs-directory)
    (setq erc-autoaway-message custom/erc-autoaway-message)
    (setq erc-auto-query 'buffer)
    (setq erc-log-channels t)
    (setq erc-max-buffer-size 20000)

    (erc-autojoin-mode t)
    (erc-fill-mode t)
    (erc-nickserv-mode 1)
    (erc-ring-mode t)
    (erc-match-enable)
    (erc-match-mode 1)
    (erc-timestamp-mode t)
    (erc-log-enable)
    ))

(use-package twittering-mode
  :defer t
  :commands twit
  :init
  (setq twittering-use-master-password t))

(use-package mingus
  :config
  (bind-key "<Backspace>" 'mingus-del mingus-playlist-map)
  (defhydra hydra-mingus ()
    "
Control               Playlist
------------------------------
_<up>_ volume up        _s_ show playlist
_<down>_ volume down    _/_ search for tracks
_<right>_ seek forward
_<left>_ seek backward
"
    ("s" mingus "open mingus" :color blue)
    ("/" mingus-search "Search")
    ("<up>" (dotimes (i 5) (mingus-vol-up)) "Louder")
    ("<down>" (dotimes (i 5) (mingus-vol-down)) "Quieter")
    ("<right>" mingus-seek "seek forward")
    ("<left>" mingus-seek-backward "seek backward")
    ("q" nil "cancel"))
  (global-set-key (kbd "C-c m") 'hydra-mingus/body))

(use-package restclient
  :defer t
  :bind ("C-c C-r C-s" . custom/create-restclient-sandbox))

(use-package tramp
  :init
  (setq tramp-default-method "ssh")
  :config
  ;; Allow to use: /sudo:user@host:/path/to/file
  (add-to-list 'tramp-default-proxies-alist
                  '(".*" "\\`.+\\'" "/ssh:%h:")))

(use-package w3m
  :defer t
  :commands w3m
  :init
  (progn
    (use-package w3m-search)
    (add-hook 'w3m-display-hook
              (lambda (url)
                (rename-buffer
                 (format "*w3m: %s*" (or w3m-current-title
                                         w3m-current-url)) t))))
  :config
  (progn
    (setq w3m-coding-system 'utf-8)
    (setq w3m-file-coding-system 'utf-8)
    (setq w3m-file-name-coding-system 'utf-8)
    (setq w3m-input-coding-system 'utf-8)
    (setq w3m-output-coding-system 'utf-8)
    (setq w3m-terminal-coding-system 'utf-8)
    (setq w3m-use-cookies t)
    ;; special chars
    (standard-display-ascii ?\200 [15])
    (standard-display-ascii ?\201 [21])
    (standard-display-ascii ?\202 [24])
    (standard-display-ascii ?\203 [13])
    (standard-display-ascii ?\204 [22])
    (standard-display-ascii ?\205 [25])
    (standard-display-ascii ?\206 [12])
    (standard-display-ascii ?\210 [23])
    (standard-display-ascii ?\211 [14])
    (standard-display-ascii ?\212 [18])
    (standard-display-ascii ?\214 [11])
    (standard-display-ascii ?\222 [?\'])
    (standard-display-ascii ?\223 [?\"])
    (standard-display-ascii ?\224 [?\"])
    (standard-display-ascii ?\227 " -- ")
    (add-to-list 'w3m-search-engine-alist
                 '("emacs-wiki" "http://www.emacswiki.org/cgi-bin/wiki.pl?search=%s"))
    (define-key custom-search-keymap (kbd "w") 'w3m-select-buffer)))

(use-package gmail-notifier
  :defer t
  :bind (("<f9>" . gmail-notifier-check))
  :config
  (progn
    (gmail-notifier-start)
    (gmail-notifier-check)))

(use-package google-translate
  :defer t
  :init
  (progn
    (use-package google-translate-default-ui)
    (bind-key "t" 'google-translate-at-point custom-search-keymap)
    (bind-key "T" 'google-translate-query-translate custom-search-keymap)))

(use-package jabber
  :init
  (use-package jabber-autoloads) ;; For 0.7.90 and above:
  (use-package jabber-bookmarks)
  (use-package jabber-autoaway)
  :bind
  (("C-x C-j C-r" . jabber-switch-to-roster-buffer)
   ("C-x C-j C-a" . jabber-activity-switch-to)
   ("C-c C-o C-r" . custom/open-urls-in-region)
   ("C-x C-j C-j" . custom/helm-jabber-chat-with)
   ("C-x C-j C-s" . custom/jabber-muc-sendto))
  :config
  (progn
    (when custom/use-zenburn-in-jabber
      (set-face-attribute 'jabber-roster-user-chatty nil :foreground "#f0dfaf" :weight 'bold)
      (set-face-attribute 'jabber-roster-user-online nil :foreground "#dfaf8f" :weight 'bold)
      (set-face-attribute 'jabber-roster-user-away nil :foreground "#8fb28f")
      (set-face-attribute 'jabber-roster-user-xa nil :foreground "#7f9f7f")
      (set-face-attribute 'jabber-roster-user-offline nil :foreground "#606060")
      (set-face-attribute 'jabber-roster-user-dnd nil :foreground "#94bff3" :weight 'bold)
      (set-face-attribute 'jabber-roster-user-error nil :foreground "#e37170" :background "#332323")
      (set-face-attribute 'jabber-title-small nil :inherit 'variable-pitch :weight 'bold :height 1.2)
      (set-face-attribute 'jabber-title-medium nil :inherit 'variable-pitch :weight 'bold :height 1.2)
      (set-face-attribute 'jabber-title-large nil :inherit 'variable-pitch :weight 'bold :height 1.2)
      (set-face-attribute 'jabber-chat-prompt-local nil :foreground "#f0dfaf" :weight 'bold)
      (set-face-attribute 'jabber-chat-prompt-foreign nil :foreground "#dfaf8f" :weight 'bold)
      (set-face-attribute 'jabber-rare-time-face nil :foreground "#8fb28f"))
    (custom-set-faces '(jabber-chat-prompt-system ((t (:foreground "darkgreen" :weight bold)))))

    ;; Message alert hooks
    (define-jabber-alert echo "Show a message in the echo area"
      (lambda (msg)
        (unless (minibuffer-prompt)
          (message "%s" msg))))

    (defun my-jabber-connect-hook (jc)
      (jabber-send-presence "" "I'm online" 10)
      (let* ((state-data (fsm-get-state-data jc))
             (server (plist-get state-data :server)))
        (message "%s" server)
        ))
    (defhydra hydra-jabber-insert (global-map "<f6>")
      ("8" (lambda () (interactive) (insert ":-* ")) ":-*")
      ("l" (lambda () (interactive) (insert "*IN LOVE* ")) "*IN LOVE*")
      ("y" (lambda () (interactive) (insert ":-[ ")) ":-[")
      ("t" (lambda () (interactive) (insert "(c) ")) "(c)")
      ;;TODO: move other insertions here, for example, current time, etc.
      ("q" nil "cancel"))
    (setq fsm-debug nil)
    (setq gnutls-algorithm-priority "NORMAL:+COMP-DEFLATE")
    (setq jabber-account-list custom/jabber-account-list)
    (setq jabber-alert-info-message-hooks 'jabber-info-echo)
    (setq jabber-alert-message-hooks 'jabber-message-beep jabber-message-scroll)
    (setq jabber-alert-presence-hooks 'jabber-presence-update-roster)
    (setq jabber-alert-presence-message-function (lambda (who oldstatus newstatus statustext) nil))
    (setq jabber-auto-reconnect t)
    (setq jabber-backlog-number 100)
    (setq jabber-chat-buffer-format "*-jc-%n-*")
    (setq jabber-groupchat-buffer-format "*-jg-%n-*")
    (setq jabber-history-dir custom/jabber-history-dir)
    (setq jabber-history-enabled t)
    (setq jabber-mode-line-mode t)
    (setq jabber-muc-private-buffer-format "*-jmuc-priv-%g-%n-*")
    (setq jabber-nickname (capitalize global-username))
    (setq jabber-rare-time-format "%e %b %Y %H:00")
    (setq jabber-resource custom/jabber-resource)
    (setq jabber-roster-buffer "*-jroster-*")
    (setq jabber-roster-line-format " %c %-25n %u %-8s  %S")
    (setq jabber-use-global-history nil)
    (bind-key "C-c C-e" 'custom/cite-chat-region jabber-chat-mode-map)
    (bind-key "C-c u r" 'upcase-region jabber-chat-mode-map)
    (bind-key "C-M-r" 'custom/jabber-abbrev jabber-chat-mode-map)
    (bind-key "C-c C-o C-l" 'browse-url jabber-chat-mode-map)
    (add-hook 'jabber-post-connect-hook 'jabber-autoaway-start)
    (add-hook 'jabber-chat-mode-hook 'goto-address)
    (add-hook 'jabber-post-connect-hooks 'my-jabber-connect-hook)
    ))

(define-key comint-mode-map "\C-c\M-o" #'custom/comint-clear-buffer)

(provide 'rc-clients)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-clients.el ends here
