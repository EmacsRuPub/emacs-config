;;; rc-sauron.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(require 'sauron)

;; note, you add (setq sauron-debug t) to get errors which can debug if
;; there's something wrong; normally, we catch such errors, since e.g an error
;; in one of the hooks may cause ERC to fail (i.e., the message won't come
;; trough).

(setq sauron-separate-frame nil)
(setq sauron-hide-mode-line t)
(setq sauron-max-line-length 120)
;; (setq sauron-watch-patterns
;;       '("emacs-fu" "emacsfu" "wombat" "capybara" "yak" "gnu" "\\bmu\\b"))
;; (setq sauron-watch-nicks
;;       '("Tom" "Dick" "Harry"))

(global-set-key (kbd "C-c r s") 'sauron-start)
(global-set-key (kbd "C-c r p") 'sauron-stop)
(global-set-key (kbd "C-c r t") 'sauron-toggle-hide-show)
(global-set-key (kbd "C-c r c") 'sauron-clear)

;; ;; events to ignore
;; (add-hook 'sauron-event-block-functions
;;   (lambda (origin prio msg &optional props)
;;     (or
;;       (string-match "^*** Users" msg)))) ;; filter out IRC spam

(provide 'rc-sauron)

;;; rc-sauron.el ends here
