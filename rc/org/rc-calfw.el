;;; rc-calfw.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

;#############################################################################
;#   Load extensions
;############################################################################
(require 'calfw)


;#############################################################################
;#   Keybindings
;############################################################################
(global-set-key (kbd "C-c c") 'cfw:open-calendar-buffer)

(provide 'rc-calfw)

;;; rc-calfw.el ends here
