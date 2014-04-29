;;; emacs-rc-tramp.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

;#############################################################################
;#   Load extensions
;############################################################################
(require 'tramp) ;; load tramp

(setq tramp-default-method "ssh")
(setq tramp-chunksize 500)

(provide 'rc-tramp)

;;; emacs-rc-tramp.el ends here
