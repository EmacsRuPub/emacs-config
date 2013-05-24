;;; rc-enable.el ---

;; Copyright (C) 2012 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:

;;; Enable functions that are disabled by default

;; Upcase and downcase regions
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; Sets the current horizontal position for C-n and C-p
(put 'set-goal-column 'disabled nil)

;; Restrict buffer editing to a region
(put 'narrow-to-region 'disabled nil)

;; Dired functions
(put 'dired-find-alternate-file 'disabled nil)

;;{{{ Horizontal scrolling
(put 'scroll-left 'disabled nil)
(put 'scroll-right 'disabled nil)
;;}}}

(provide 'rc-enable)

;;; rc-enable.el ends here
