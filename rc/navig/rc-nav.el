;;; rc-nav.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(require 'nav)

(nav-disable-overeager-window-splitting)

(global-set-key [f5] 'nav-toggle)

(provide 'rc-nav)

;;; rc-nav.el ends here
