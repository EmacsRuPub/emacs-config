;; -*- coding: utf-8 -*-
;;
;; Filename: rc-deft.el
;; Created: Пт мар 14 22:48:06 2014 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq deft-extension "org")
(setq deft-directory "~/org/deft/")
(setq deft-text-mode 'org-mode)

(global-set-key (kbd "<f12>") 'deft)

(provide 'rc-deft)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-deft.el ends here
