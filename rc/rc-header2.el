;;; rc-header2.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(defsubst header-utf8 ()
  "Insert utf-8 def."
  (insert header-prefix-string  "-*- coding: utf-8 -*-\n"))

(setq make-header-hook '(header-utf8
                         header-blank
                         header-file-name
                         header-creation-date
                         header-end-line
                         header-eof))

(add-hook 'write-file-hooks 'auto-update-file-header)

(add-hook 'emacs-lisp-mode-hook 'auto-make-header)
(add-hook 'python-mode-hook     'auto-make-header)
(add-hook 'php-mode-hook        'auto-make-header)
(add-hook 'sh-mode-hook         'auto-make-header)
(add-hook 'lisp-mode-hook       'auto-make-header)
(add-hook 'java-mode-hook       'auto-make-header)

(provide 'rc-header2)

;;; rc-header2.el ends here
