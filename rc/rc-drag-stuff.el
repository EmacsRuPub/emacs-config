;;; rc-drag-stuff.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(require 'drag-stuff)

(turn-off-drag-stuff-mode)

(global-set-key (kbd "C-c d e") 'turn-on-drag-stuff-mode)
(global-set-key (kbd "C-c d d") 'turn-off-drag-stuff-mode)

(provide 'rc-drag-stuff)

;;; rc-drag-stuff.el ends here
