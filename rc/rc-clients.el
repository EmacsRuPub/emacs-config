;; -*- coding: utf-8 -*-
;;
;; Filename: rc-clients.el
;; Created:  Fri May 30 19:10:47 2014 +0400
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(autoload 'gmail-notifier-start "gmail-notifier" nil t)

(gmail-notifier-start)
(gmail-notifier-check)

(defun custom/term-exec-hook ()
  (let* ((buff (current-buffer))
         (proc (get-buffer-process buff)))
    (set-process-sentinel
     proc
     `(lambda (process event)
        (if (string= event "finished\n")
            (kill-buffer ,buff))))))

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
  :config
  (progn
    (erc-pcomplete-mode 1)
    (setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT"
                                    "324" "329" "332" "333" "353" "477"))))
    (bind-key "s" 'connect-office-irc custom-clients-keymap)
    (bind-key "q" 'leave-irc-server custom-clients-keymap)
    (bind-key "b" 'select-erc-buffer custom-clients-keymap)
    (bind-key "i" 'insert-erc-nick custom-clients-keymap)
    (bind-key "M-<up>" 'custom/find-url-backward erc-mode-map)
    (bind-key "M-<down>" 'custom/find-url-forward erc-mode-map)

(use-package twittering-mode
  :defer t
  :commands twit
  :init
  (setq twittering-use-master-password t))

(use-package mingus
  :defer t
  :commands mingus
  :bind (("C-c <right>" . mingus-seek)
         ("C-c <left>" . mingus-seek-backward)
         ("C-c s" . mingus))
  :config
  (bind-key "<Backspace>" 'mingus-del mingus-playlist-map))

(use-package restclient
  :defer t
  :bind ("C-c C-r C-s" . create-restclient-sandbox))

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

;TODO: try use-package
(with-eval-after-load "gmail-notifier"
  (global-set-key [f8] 'open-gmail)
  (global-set-key [f9] 'gmail-notifier-check))

(with-eval-after-load "google-translate"
  (require 'google-translate-default-ui)
  (define-key custom-search-keymap (kbd "t") 'google-translate-at-point)
  (define-key custom-search-keymap (kbd "T") 'google-translate-query-translate))

(define-key comint-mode-map "\C-c\M-o" #'comint-clear-buffer)

(provide 'rc-clients)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-clients.el ends here
