;;; rc-browser.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(when (not (eq system-type 'darwin)) ;; mac specific settings
  (setq browse-url-browser-function 'browse-url-generic)
  (setq browse-url-generic-program "/usr/bin/firefox"))

(provide 'rc-browser)

;;; rc-browser.el ends here
