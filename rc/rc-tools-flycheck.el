;; -*- coding: utf-8 -*-
;;
;; Filename: rc-tools-flycheck.el
;; Created: Вс авг  4 00:59:42 2013 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-hook 'after-init-hook #'global-flycheck-mode)

(eval-after-load "flycheck"
  '(add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode)
  )

(setq flycheck-check-syntax-automatically '(save))

(global-set-key (kbd "C-x <up>") 'flycheck-previous-error)
(global-set-key (kbd "C-x <down>") 'flycheck-next-error)
(global-set-key (kbd "C-x !") 'flycheck-first-error)

(provide 'rc-tools-flycheck)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-tools-flycheck.el ends here
