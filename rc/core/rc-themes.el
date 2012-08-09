;;; rc-themes.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(require 'color-theme)
(require 'color-theme-darkmate)
(require 'color-theme-sanityinc-solarized)
(require 'parenface)


;#############################################################################
;#   Text coloring
;############################################################################
(defvar bg-colors "emacs background colors list")
(defvar fg-colors "emacs foreground colors list")

(setq bg-colors '("cornsilk" "gray0" "gray18" "gray40"))
(setq fg-colors '("gainsboro" "navy"))
(setq mouse-colors '("firebrick" "yellow"))

(set-cursor-color "chartreuse2")

(color-theme-initialize)
(color-theme-zenburn)
;; (color-theme-twilight)

;#############################################################################
;#   Fonts
;############################################################################
(defvar custom/fonts-def "User's font definitions")

(setq custom/fonts-def
      '(("Consolas:size=12" "Consolas")
        ("Terminus:size=14" "Terminus")
        ("TerminusBold:size=12" "TerminusBold")
        ("Monaco:size=12" "Monaco")
        ("Code2000:size=12" "Code2000")
        ))

(defun set-xwindows-font (idx)
 (if (eq window-system 'x)
     (progn
	(set-default-font (nth 0 (nth idx custom/fonts-def)))
	;; (set-fontset-font "fontset-default" ; (frame-parameter nil 'font)
	;; 		  'cyrillic '((nth 1 (nth idx 'custom/fonts-def)) . "unicode-bmp"))
	)))

(set-xwindows-font 0)

(set-face-foreground 'paren-face "blue4")

;;; rc-themes.el ends here

