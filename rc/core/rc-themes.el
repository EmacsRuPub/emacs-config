;;; rc-themes.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(load-file "~/site-lisp/system/color-theme-darkmate.el")

(require 'color-theme)

;#############################################################################
;#   Text coloring
;############################################################################
(defvar bg-colors "emacs background colors list")
(defvar fg-colors "emacs foreground colors list")

(setq bg-colors '("cornsilk" "gray0" "gray18" "gray40"))
(setq fg-colors '("gainsboro" "navy"))

;; (set-foreground-color (nth 0 fg-colors))
;; (set-background-color (nth 0 bg-colors))
;; (set-cursor-color "firebrick")
(set-cursor-color "chartreuse2")
;; (set-mouse-color "yellow")

(color-theme-initialize)
(color-theme-zenburn)
;; (color-theme-gtk-ide)
;; (color-theme-darkmate)

;#############################################################################
;#   Fonts
;############################################################################
(defvar custom/fonts-def "User's font definitions")

(setq custom/fonts-def '(
	("Consolas:size=12" "Consolas")
	("Terminus:size=12" "Terminus")
	("Monaco:size=8" "Monaco")
	("Verdana:size=10" "Verdana")
	))

(defun set-xwindows-font (idx)
 (if (eq window-system 'x)
     (progn
	(set-default-font (nth 0 (nth idx custom/fonts-def)))
	;; (set-fontset-font "fontset-default" ; (frame-parameter nil 'font)
	;; 		  'cyrillic '((nth 1 (nth idx 'custom/fonts-def)) . "unicode-bmp"))
	)))

(set-xwindows-font 0)

;;; rc-themes.el ends here

