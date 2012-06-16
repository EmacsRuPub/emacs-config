;;; rc-php.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(require 'php-mode) ;;подгружаем php режим
(require 'php-electric) ;;режим autocompletion конструкций языка

;; (add-hook 'php-mode-hook 'camelCase-mode)

;; move where appropriate
(setq glasses-face "bold")
(setq glasses-separator "")
(setq glasses-original-separator "")

;;; rc-php.el ends here
