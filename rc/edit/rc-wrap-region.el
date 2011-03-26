;;; rc-wrap-region.el --- 

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords: 
;; Requirements: 
;; Status: not intended to be distributed yet

(require 'wrap-region)

(wrap-region-global-mode t)

(wrap-region-add-wrapper "*" "*")

;;; rc-wrap-region.el ends here
