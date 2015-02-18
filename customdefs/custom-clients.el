;;; custom-clients.el ---

;; Copyright (C) 2015 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:

;TODO: parametrize shell for terminal
(defun terminal ()
  "Switch to terminal. Launch if nonexistent."
  (interactive)
  (if (get-buffer "*ansi-term*")
      (switch-to-buffer "*ansi-term*")
    (ansi-term "/bin/zsh"))
  (get-buffer-process "*ansi-term*"))

(defalias 'tt 'terminal)

(defun connect-office-irc ()
  (interactive)
  (erc-tls
   :server private/erc-server-office
   :full-name private/erc-full-name
   :nick private/erc-nick-office
   :password private/erc-password-office))

(defun connect-gitter-irc ()
  (interactive)
  (erc-tls
   :server private/erc-server-gitter
   :full-name private/erc-full-name
   :nick private/erc-nick-gitter
   :password private/erc-password-gitter))

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

(defun comint-clear-buffer ()
  (interactive)
  (let ((comint-buffer-maximum-size 0))
    (comint-truncate-buffer)))

(defun my-bbdb-tab-complete ()
  (interactive)
  (if (mail-abbrev-in-expansion-header-p)
      (bbdb-complete-name)
    (message-tab)))

(provide 'custom-clients)

;;; custom-clients.el ends here
