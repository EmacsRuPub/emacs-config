;; -*- coding: utf-8 -*-
;;
;; Filename: rc-smart-forward.el
;; Created: Вс окт  6 23:10:39 2013 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'smart-forward)

(global-set-key (kbd "C-c C-<right>") 'smart-forward)
(global-set-key (kbd "C-c C-<left>") 'smart-backward)
(global-set-key (kbd "C-c [") 'smart-up)
(global-set-key (kbd "C-c ]") 'smart-down)

(provide 'rc-smart-forward)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-smart-forward.el ends here
