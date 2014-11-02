;; -*- coding: utf-8 -*-
;;
;; Filename: rc-clients.el
;; Created: Пт май 30 18:58:37 2014 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(autoload 'gmail-notifier-start "gmail-notifier" nil t)

(gmail-notifier-start)
(gmail-notifier-check)

(defun connect-office-irc ()
  (interactive)
  (erc-tls
   :server private/erc-server-office
   :full-name private/erc-full-name
   :nick private/erc-nick-office
   :password private/erc-password-office))

;; FIXME should be able to quit server
;; being invoked from barely any buffer
(defun leave-irc-server ()
  (interactive)
  (erc-quit-server "Leaving"))

(defun select-erc-buffer ()
  (interactive)
  (switch-to-buffer
   (ido-completing-read
    "Select ERC buffer:" (mapcar #'buffer-name (erc-buffer-list)))))

(defun insert-erc-nick ()
  (interactive)
  (insert
   (concatenate 'string
                (ido-completing-read "nick" (pcomplete-erc-nicks)) ": ")
   ))

(defun open-gmail ()
  (interactive)
  (browse-url "https://mail.google.com"))

(use-package erc
  :init
  (use-package erc-pcomplete)
  :config
  (progn
    (erc-pcomplete-mode 1)
    (define-key custom-clients-keymap (kbd "s") 'connect-office-irc)
    (define-key custom-clients-keymap (kbd "q") 'leave-irc-server)
    (define-key custom-clients-keymap (kbd "b") 'select-erc-buffer)
    (define-key custom-clients-keymap (kbd "i") 'insert-erc-nick)
    (define-key erc-mode-map (kbd "M-<up>") 'custom/find-url-backward)
    (define-key erc-mode-map (kbd "M-<down>") 'custom/find-url-forward)
    (setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT"
                                    "324" "329" "332" "333" "353" "477"))))

(use-package twittering-mode
  :commands twit
  :init
  (setq twittering-use-master-password t))

(use-package mingus
  :commands mingus
  :bind (("C-c <right>" . mingus-seek)
         ("C-c <left>" . mingus-seek-backward)
         ("C-c s" . mingus))
  :config
  (bind-key "<Backspace>" 'mingus-del mingus-playlist-map))

(use-package restclient
  :bind ("C-c C-r C-s" . create-restclient-sandbox))

(use-package tramp
  :init
  (setq tramp-default-method "ssh")
  :config
  ;; Allow to use: /sudo:user@host:/path/to/file
  (add-to-list 'tramp-default-proxies-alist
                  '(".*" "\\`.+\\'" "/ssh:%h:")))

(use-package w3m
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
                 '("emacs-wiki" "http://www.emacswiki.org/cgi-bin/wiki.pl?search=%s"))))


;TODO: try use-package
(eval-after-load "gmail-notifier"
  '(progn
     (global-set-key [f8] 'open-gmail)
     (global-set-key [f9] 'gmail-notifier-check)
     ))

(eval-after-load "google-translate"
  '(progn
     (require 'google-translate-default-ui)
     (define-key custom-search-keymap (kbd "t") 'google-translate-at-point)
     (define-key custom-search-keymap (kbd "T") 'google-translate-query-translate)
     ))

(provide 'rc-clients)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-clients.el ends here
