;;; rc-popup-test.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(add-to-list 'load-path "~/site-lisp/popup/")

(require 'popup)
(require 'popup-select-window)
(global-set-key "\C-cpp" 'popup-select-window)

;;; Extend Sample
;; * Change highlight face
(setq popup-select-window-window-highlight-face
			'(:foreground "white" :background "navy"))
;; * Disable modeline highlight
(setq popup-select-window-use-modeline-highlight nil)
;; * Disable buffer highlight
(setq popup-select-window-use-buffer-highlight nil)
;; * Change active modeline color to blue
(setq popup-select-window-active-modeline-bgcolor "blue")
;; * Change nonactive modeline color to gray
(setq popup-select-window-inactive-modeline-bgcolor "gray")

;;; rc-popup-test.el ends here
