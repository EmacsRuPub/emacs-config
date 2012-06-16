;;; rc-ace-jump-mode.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(require 'ace-jump-mode)
;; (define-key global-map (kbd "C-c SPC") 'ace-jump-mode)
(global-set-key "\C-cj" 'ace-jump-mode)

;;; rc-ace-jump-mode.el ends here
