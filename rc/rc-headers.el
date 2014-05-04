;; -*- coding: utf-8 -*-
;;
;; Filename: rc-headers.el
;; Created: Вс май  4 23:45:25 2014 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'rebox2)

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

(global-set-key (kbd "M-q") 'rebox-dwim)
(global-set-key (kbd "S-M-q") 'rebox-cycle)

(provide 'rc-headers)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-headers.el ends here
