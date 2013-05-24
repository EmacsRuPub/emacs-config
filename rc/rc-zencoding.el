;;; rc-zencoding.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(require 'zencoding-mode)

(add-hook 'sgml-mode-hook 'zencoding-mode)
(add-hook 'nxml-mode-hook 'zencoding-mode)
(add-hook 'django-mode 'zencoding-mode)

(key-chord-define-global "p-" 'zencoding-expand-yas)

(provide 'rc-zencoding)

;;; rc-zencoding.el ends here
