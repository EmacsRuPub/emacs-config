;; -*- coding: utf-8 -*-
;;
;; Filename: rc-themes.el
;; Created:  Fri May 24 22:41:54 2013 +0400
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defvar bg-colors "emacs background colors list")
(defvar fg-colors "emacs foreground colors list")

(setq bg-colors '("cornsilk" "gray0" "gray18" "gray40"))
(setq fg-colors '("gainsboro" "navy"))
(setq mouse-colors '("firebrick" "yellow"))

(setq sml/no-confirm-load-theme t)
(sml/setup)

(set-cursor-color "chartreuse2")
(custom/set-xwindows-font "consolas-base")

(load-theme 'zenburn t)

(unicode-fonts-setup)

(when (boundp 'zenburn-colors-alist)
  (set-face-attribute 'default nil :background (cdr (assoc "zenburn-bg-1" zenburn-colors-alist)))
  (set-face-attribute 'region nil :background (cdr (assoc "zenburn-bg-2" zenburn-colors-alist))))

(provide 'rc-themes)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-themes.el ends here
