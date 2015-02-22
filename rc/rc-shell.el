;; -*- coding: utf-8 -*-
;;
;; Filename: rc-shell.el
;; Created:  Fri May 24 22:41:54 2013 +0400
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'ansi-color)

(use-package eshell
  :config
  (progn
    (defun eshell-handle-ansi-color ()
      (ansi-color-apply-on-region eshell-last-output-start
                                  eshell-last-output-end))
    (add-to-list 'eshell-output-filter-functions 'eshell-handle-ansi-color)))

(provide 'rc-shell)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-shell.el ends here
