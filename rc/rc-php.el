;;; rc-php.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(require 'php-mode) ;;подгружаем php режим
(require 'php-electric) ;;режим autocompletion конструкций языка
(require 'ac-php-doc)

(setq php-manual-path "/home/octocat/documentation/php-chunked-xhtml/")

(defun custom/php-mode-hook ()
  ;; style customization
  (setq tab-width 4) ;; was 4
  (setq indent-tabs-mode nil)
  (setq c-basic-offset 4)
  (setq show-trailing-whitespace t) ;; show trailing whitespace
)

(add-hook 'php-mode-hook 'custom/php-mode-hook)
(add-hook 'php-mode-hook 'set-up-php-ac)
(add-hook 'php-mode-hook 'common-hooks/prog-helpers)

(provide 'rc-php)

;;; rc-php.el ends here
