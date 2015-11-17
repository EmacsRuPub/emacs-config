;;; custom-clients.el ---

;; Copyright (C) 2015 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:

(define-namespace custom/

;;TODO: parametrize shell for terminal
(defun terminal ()
  "Switch to terminal. Launch if nonexistent."
  (interactive)
  (if (get-buffer "*ansi-term*")
      (switch-to-buffer "*ansi-term*")
    (ansi-term "/bin/zsh"))
  (get-buffer-process "*ansi-term*"))

(defalias 'tt 'terminal)

(defun connect-slack-irc ()
  (interactive)
  (erc-tls
   :server private/irc-mira-slack-server
   :full-name private/erc-full-name
   :nick private/irc-mira-slack-nick
   :password private/irc-mira-slack-password))

;; FIXME should be able to quit server
;; being invoked from barely any buffer
(defun leave-irc-server ()
  (interactive)
  (erc-quit-server "Leaving"))

(defun select-erc-buffer ()
  (interactive)
  (switch-to-buffer
   (helm-comp-read
    "Select ERC buffer:" (mapcar #'buffer-name (erc-buffer-list)))))

(defun select-erc-unread-buffer ()
  (interactive)
  (switch-to-buffer
   (helm-comp-read
    "Select unread ERC buffer:"
    (mapcar #'buffer-name
            (mapcar (lambda (x) (nth 0 x)) erc-modified-channels-alist)))))
;;TODO: check if '(mapcar #'buffer-name (erc-buffer-list #'buffer-modified-p)) works

(defun insert-erc-nick (&optional atsign)
  (interactive)
  (insert
   (concatenate 'string
                (when atsign
                  "@")
                (helm-comp-read "nick: " (pcomplete-erc-nicks)) ": ")
   ))

(defun comint-clear-buffer ()
  (interactive)
  (let ((comint-buffer-maximum-size 0))
    (comint-truncate-buffer)))

(defun my-bbdb-tab-complete ()
  (interactive)
  (if (mail-abbrev-in-expansion-header-p)
      (bbdb-complete-name)
    (message-tab)))

(defun term-exec-hook ()
  (let* ((buff (current-buffer))
         (proc (get-buffer-process buff)))
    (set-process-sentinel
     proc
     `(lambda (process event)
        (if (string= event "finished\n")
            (kill-buffer ,buff))))))

;;TODO: maybe make org-protocol solution instead
(defun youtube-dl ()
  (interactive)
  (let* ((str (current-kill 0))
         (default-directory "~/Downloads")
         (proc (get-buffer-process (ansi-term "/bin/bash"))))
    (term-send-string
     proc
     (concat "cd ~/Downloads && youtube-dl " str "\n"))))

)

(provide 'custom-clients)

;;; custom-clients.el ends here
