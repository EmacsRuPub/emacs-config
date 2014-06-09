;; -*- coding: utf-8 -*-
;;
;; Filename: rc-clients.el
;; Created: Пт май 30 18:58:37 2014 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(autoload 'twit "twittering-mode" nil t)
(autoload 'mingus "mingus" nil t)


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

(eval-after-load "erc"
  '(progn
     (global-set-key (kbd "C-c r s") 'connect-office-irc)
     (global-set-key (kbd "C-c r q") 'leave-irc-server)
     (global-set-key (kbd "C-c r b") 'select-erc-buffer)
     (setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT"))
     ))

(eval-after-load "twittering-mode"
  '(progn
     (setq twittering-use-master-password t)
     ))

(eval-after-load "mingus"
  '(progn
     (global-set-key (kbd "C-c <right>") 'mingus-seek)
     (global-set-key (kbd "C-c <left>") 'mingus-seek-backward)
     (global-set-key (kbd "C-c s") 'mingus)
     (define-key mingus-playlist-map (kbd "<Backspace>") 'mingus-del)
     ))


(provide 'rc-clients)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-clients.el ends here
