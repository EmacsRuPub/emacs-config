;;; rc-themes.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(require 'themes-definitions)

;#############################################################################
;#   Text coloring
;############################################################################
(defvar bg-colors "emacs background colors list")
(defvar fg-colors "emacs foreground colors list")

(setq bg-colors '("cornsilk" "gray0" "gray18" "gray40"))
(setq fg-colors '("gainsboro" "navy"))
(setq mouse-colors '("firebrick" "yellow"))

(set-cursor-color "chartreuse2")

(load-theme 'zenburn t)

(set-face-attribute 'default nil :background (cdr (assoc "zenburn-bg-1" zenburn-colors-alist)))

;#############################################################################
;#   Fonts
;############################################################################

(set-xwindows-font "consolas-base")

(provide 'rc-themes)

;;; rc-themes.el ends here
