;;; rc-region-bindings.el ---

;; Copyright (C) 2012 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:

(require 'region-bindings-mode)

(region-bindings-mode-enable)

;; key definition example
;; (define-key region-bindings-mode-map "a" 'mc/mark-all-like-this)

(provide 'rc-region-bindings)

;;; rc-region-bindings.el ends here
