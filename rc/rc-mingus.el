;; -*- coding: utf-8 -*-
;;
;; Filename: rc-mingus.el
;; Created: Чт дек 12 19:42:49 2013 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global-set-key (kbd "C-c <right>") 'mingus-seek)
(global-set-key (kbd "C-c <left>") 'mingus-seek-backward)
(global-set-key (kbd "C-c s") 'mingus)
(define-key mingus-playlist-map (kbd "<Backspace>") 'mingus-del)

(provide 'rc-mingus)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-mingus.el ends here
