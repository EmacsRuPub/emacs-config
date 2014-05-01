;;; rc-ecb.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(require 'semantic/analyze)
(provide 'semantic-analyze)
(provide 'semantic-ctxt)
(provide 'semanticdb)
(provide 'semanticdb-find)
(provide 'semanticdb-mode)
(provide 'semantic-load)

;; fix for emacs 24
(unless (boundp 'stack-trace-on-error)
  (defvar stack-trace-on-error nil))

(require 'ecb)

(global-set-key (kbd "C-x t q") 'ecb-toggle-ecb-windows)
(global-set-key (kbd "C-x t a") 'ecb-activate)
(global-set-key (kbd "C-x t d") 'ecb-deactivate)

(provide 'rc-ecb)

;;; rc-ecb.el ends here
