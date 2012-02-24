;;; emacs-rc-appearance.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(require 'tree-widget)
(require 'mwheel)

(load-library "time")

;#############################################################################
;#   Appearance variables
;############################################################################
(setq size-indication-mode t)
(setq column-number-mode t)
(setq use-dialog-box nil)
(setq scalable-fonts-allowed t)
(setq inhibit-startup-screen t)
(setq inhibit-startup-message t)
(setq frame-title-format "emacs - %b")
(setq split-width-threshold nil)
(setq custom-buffer-done-kill t)
(setq initial-scratch-message nil)

;; date|time
(setq display-time-mail-file t)
(setq display-time-form-list (list 'time 'load))
(setq display-time-day-and-date t)
(setq display-time-string-forms
  '( day " " monthname " (" dayname ") " 24-hours ":" minutes))


;#############################################################################
;#   Appearance function calls
;############################################################################
(mwheel-install)
(blink-cursor-mode t)
(tool-bar-mode 0)
(global-hl-line-mode t)
(show-paren-mode t)
(tooltip-mode nil)
(global-font-lock-mode t)

;; use y/n instead of yes/no
(fset 'yes-or-no-p 'y-or-n-p)

;;часы в статусе
(display-time)

;;; emacs-rc-appearance.el ends here
