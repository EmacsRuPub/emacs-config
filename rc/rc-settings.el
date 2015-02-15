;; -*- coding: utf-8 -*-
;;
;; Filename: rc-settings.el
;; Created:  Fri May 23 23:08:51 2014 +0400
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(load-library "time")

(require 'uniquify)
(require 'popwin)
(require 'tail)

;;; Enable functions that are disabled by default
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'set-goal-column 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)
(put 'scroll-left 'disabled nil)
(put 'scroll-right 'disabled nil)
(put 'erase-buffer 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

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
(setq visible-bell t)
(setq inhibit-startup-echo-area-message "octocat")
(setq eval-expression-print-length nil)
(setq echo-keystrokes 0.1)
(setq gc-cons-percentage 0.3)
(setq print-gensym t)
(setq print-circle t)
(setq redisplay-dont-pause t)
(setq display-time-mail-file t)
(setq display-time-form-list (list 'time 'load))
(setq display-time-day-and-date t)
(setq display-time-string-forms
  '( day " " monthname " (" dayname ") " 24-hours ":" minutes))
(setq disabled-command-function nil)
(setq uniquify-buffer-name-style 'post-forward)
(setq uniquify-separator "/")
(setq uniquify-ignore-buffers-re "^\\*")
(setq uniquify-strip-common-suffix nil)
(setq tail-max-size 20)
(setq font-lock-maximum-decoration t)
(setq color-theme-is-global t)
(setq truncate-partial-width-windows nil)
(setq backup-by-copying t)
(setq backup-by-copying-when-linked t)
(setq backup-directory-alist `(("." . ,emacs-tmp-dir)))
(setq auto-save-file-name-transforms `((".*" ,emacs-tmp-dir t)))
(setq delete-old-versions -1)
(setq version-control t)

(and (fboundp 'scroll-bar-mode) (scroll-bar-mode 0))
(prefer-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8 'utf-8-unix)
(set-default buffer-file-coding-system 'utf-8-unix)
(set-default default-buffer-file-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)
(menu-bar-mode -1)
(scroll-bar-mode 0)
(blink-cursor-mode 0)
(tool-bar-mode 0)
;; (global-hl-line-mode t) ;FIXME: regeression (24.4): corresponding overlay value is nil
(tooltip-mode nil)
(global-font-lock-mode t)
(display-battery-mode 1)
(display-time)
(fset 'yes-or-no-p 'y-or-n-p)

(defun custom/after-init-hook ()
  (with-eval-after-load "diminish"
    (diminish 'abbrev-mode)
    (diminish 'auto-complete-mode " α")
    (diminish 'auto-fill-function)
    (diminish 'visual-line-mode)
    (diminish 'volatile-highlights-mode)
    (diminish 'whole-line-or-region-mode)
    ))

(add-hook 'after-init-hook 'custom/after-init-hook)

(global-set-key (kbd "C-c t f") 'tail-file)

(provide 'rc-settings)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-settings.el ends here
