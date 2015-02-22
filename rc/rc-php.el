;; -*- coding: utf-8 -*-
;;
;; Filename: rc-php.el
;; Created:  Thu May 1 16:30:43 2014 +0400
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package php-mode
  :init
  (use-package php-electric) ;; autocompletion
  (use-package ac-php-doc)
  :config
  (progn
    (setq php-manual-path custom/php-manual-path)
    (defun custom/php-mode-hook ()
      ;; style customization
      (setq tab-width 4) ;; was 4
      (setq indent-tabs-mode nil)
      (setq c-basic-offset 4)
      (setq show-trailing-whitespace t) ;; show trailing whitespace
      )
    (add-hook 'php-mode-hook 'custom/php-mode-hook)
    (add-hook 'php-mode-hook 'set-up-php-ac)
    (add-hook 'php-mode-hook 'common-hooks/prog-helpers)))

(provide 'rc-php)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-php.el ends here
