;;; rc-zencoding.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(require 'emmet-mode)

(add-hook 'sgml-mode-hook 'zencoding-mode)
(add-hook 'nxml-mode-hook 'zencoding-mode)
(add-hook 'django-mode 'zencoding-mode)

;; Example tuning
;; (add-hook 'emmet-mode-hook (lambda () (setq emmet-indentation 2))) ;; indent 2 spaces.
;; (setq emmet-move-cursor-between-quotes t) ;; default nil
;; (setq emmet-move-cursor-after-expanding nil) ;; default t

(provide 'rc-zencoding)

;;; rc-zencoding.el ends here
