;;; emacs-rc-shell.el --- 

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords: 
;; Requirements: 
;; Status: not intended to be distributed yet

;#############################################################################
;#   Eshell
;############################################################################
(require 'ansi-color)
(require 'eshell)

(defun eshell-handle-ansi-color ()
      (ansi-color-apply-on-region eshell-last-output-start
                                  eshell-last-output-end))
    (add-to-list 'eshell-output-filter-functions 'eshell-handle-ansi-color)


;#############################################################################
;#   Shell
;############################################################################
(global-set-key (kbd "C-c z") (lambda () (interactive) (ansi-term "/bin/zsh")))

;;; emacs-rc-shell.el ends here
