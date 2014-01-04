;; -*- coding: utf-8 -*-
;;
;; Filename: rc-paredit.el
;; Created: Сб янв  4 19:18:05 2014 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(eval-after-load "paredit"
  '(progn
    (define-key paredit-mode-map (kbd "M-s") nil)
    (define-key paredit-mode-map (kbd "M-<up>") nil)
    (define-key paredit-mode-map (kbd "M-<down>") nil)
    (define-key paredit-mode-map (kbd "C-<up>") nil)
    (define-key paredit-mode-map (kbd "C-<down>") nil)
    ))

(provide 'rc-paredit)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-paredit.el ends here
