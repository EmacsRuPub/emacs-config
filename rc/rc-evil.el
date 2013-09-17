;; -*- coding: utf-8 -*-
;;
;; Filename: rc-evil.el
;; Created: Вт авг 27 10:53:18 2013 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'evil)
(require 'evil-nerd-commenter)
(require 'surround)

(evilnc-default-hotkeys)
(global-surround-mode 1)

(global-set-key (kbd "C-c v i") 'evil-mode)

(provide 'rc-evil)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-evil.el ends here
