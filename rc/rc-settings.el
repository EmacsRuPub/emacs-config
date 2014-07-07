;; -*- coding: utf-8 -*-
;;
;; Filename: rc-settings.el
;; Created: Пт май 23 21:51:46 2014 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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

;; some useful funcs
(put 'erase-buffer 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; encoding settings
(prefer-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8 'utf-8-unix)
(set-default buffer-file-coding-system 'utf-8-unix)
(set-default default-buffer-file-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)

(load-library "time")

(require 'uniquify)
(require 'popwin)
(require 'tail)

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

(setq tail-max-size 20)

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

(defun custom/after-init-hook ()
  (eval-after-load "diminish"
    '(progn
       (diminish 'abbrev-mode)
       (diminish 'auto-complete-mode " α")
       (diminish 'auto-fill-function)
       (diminish 'global-visual-line-mode)
       (diminish 'undo-tree-mode)
       (diminish 'visual-line-mode)
       (diminish 'volatile-highlights-mode)
       (diminish 'projectile-mode "prj")
       (diminish 'git-gutter-mode)
       (diminish 'eldoc-mode "ED")
       (diminish 'whole-line-or-region-mode)
       )))

(add-hook 'after-init-hook 'custom/after-init-hook)

(global-set-key (kbd "C-c t f") 'tail-file)

(setq backup-by-copying t)              ; don't clobber symlinks
(setq backup-by-copying-when-linked t)  ; Copy linked files, don't rename.
(setq backup-directory-alist `(("." . ,emacs-tmp-dir)))    ; don't litter my fs tree
(setq auto-save-file-name-transforms `((".*" ,emacs-tmp-dir t)))
(setq delete-old-versions t)
(setq kept-new-versions 16)
(setq kept-old-versions 2)
(setq version-control t)               ; use versioned backups

(provide 'rc-settings)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-settings.el ends here
