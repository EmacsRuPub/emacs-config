;; -*- coding: utf-8 -*-
;;
;; Filename: rc-pim.el
;; Created: Вс май  4 23:29:48 2014 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(autoload 'sauron-start "sauron" "Sauron" t)
(autoload 'deft "deft" "Deft" t)

(eval-after-load "sauron"
  '(progn
     ;; note, you add (setq sauron-debug t) to get errors which can debug if
     ;; there's something wrong; normally, we catch such errors, since e.g an error
     ;; in one of the hooks may cause ERC to fail (i.e., the message won't come
     ;; trough).
     (setq sauron-separate-frame nil)
     (setq sauron-hide-mode-line t)
     (setq sauron-max-line-length 120)

     (global-set-key (kbd "C-c r s") 'sauron-start)
     (global-set-key (kbd "C-c r p") 'sauron-stop)
     (global-set-key (kbd "C-c r t") 'sauron-toggle-hide-show)
     (global-set-key (kbd "C-c r c") 'sauron-clear)
     ))

(eval-after-load "deft"
  '(progn
     (setq deft-extension "org")
     (setq deft-directory "~/deft/")
     (setq deft-text-mode 'org-mode)

     ;; (global-set-key (kbd "<f12>") 'deft)
     ))

(require 'calfw)

(global-set-key (kbd "C-c c") 'cfw:open-calendar-buffer)

(provide 'rc-pim)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-pim.el ends here
