(require 'gmail-notifier)

(gmail-notifier-start)
(gmail-notifier-check)

;; (setq gmail-notifier-timer-interval 120)

(defun open-gmail ()
  (interactive)
  (browse-url "https://mail.google.com"))

(global-set-key [f8] 'open-gmail)
(global-set-key [f9] 'gmail-notifier-check)

(provide 'rc-gmail)
