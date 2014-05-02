;;; rc-interface.el ---

;; Copyright (C) 2012 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:

(load-library "time")

(require 'uniquify)
(require 'popwin)

(setq size-indication-mode t)
(setq column-number-mode t)
(setq line-number-mode t)
(setq use-dialog-box nil)
(setq scalable-fonts-allowed t)
(setq inhibit-startup-screen t)
(setq inhibit-startup-message t)
(setq frame-title-format custom/frame-title-format)
(setq split-width-threshold nil)
(setq custom-buffer-done-kill t)
(setq initial-scratch-message nil)
(setq enable-recursive-minibuffers t)

(setq echo-keystrokes 0.1);; Show keystrokes in progress

;; Non-customizable variables
(setq gc-cons-percentage 0.3)
(setq print-gensym t)
(setq print-circle t)
(setq redisplay-dont-pause t)

;; date|time
(setq display-time-mail-file t)
(setq display-time-form-list (list 'time 'load))
(setq display-time-day-and-date t)
(setq display-time-string-forms
  '( day " " monthname " (" dayname ") " 24-hours ":" minutes))

(setq disabled-command-function nil)
(and (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; uniquify
(setq uniquify-buffer-name-style 'post-forward)
(setq uniquify-separator "/")
(setq uniquify-ignore-buffers-re "^\\*") ; don't muck with special buffers

(menu-bar-mode -1)

;; Blinking cursors are distracting - turn blink OFF
(and (fboundp 'blink-cursor-mode) (blink-cursor-mode (- (*) (*) (*))))

(blink-cursor-mode t)
(tool-bar-mode 0)
(global-hl-line-mode t)
(tooltip-mode nil)
(global-font-lock-mode t)
(display-battery-mode 1)

;; use y/n instead of yes/no
(fset 'yes-or-no-p 'y-or-n-p)

;;часы в статусе
(display-time)

(setq font-lock-maximum-decoration t)
(setq color-theme-is-global t)
(setq truncate-partial-width-windows nil)

(provide 'rc-interface)

;;; rc-interface.el ends here
