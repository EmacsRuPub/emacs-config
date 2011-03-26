;;; rc-icicles.el --- 

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords: 
;; Requirements: 
;; Status: not intended to be distributed yet

(require 'icicles)
(require 'lacarte)
(require 'icicles-iswitchb)

(icy-mode t) ;; Turn on Icicle mode.

(global-set-key "\C-cmi" 'icy-mode)

(defadvice switch-to-buffer (after custom/turn-off-icicles-org ())
  "Turns off Icicles in Orgmode buffers."
  (if (eq major-mode 'org-mode) (icy-mode nil) (icy-mode t)))
(ad-activate 'switch-to-buffer)

;;; rc-icicles.el ends here
