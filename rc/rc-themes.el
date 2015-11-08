;; -*- coding: utf-8 -*-
;;
;; Filename: rc-themes.el
;; Created:  Fri May 24 22:41:54 2013 +0400
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package unicode-fonts :ensure t)

(use-package deep-thought-theme :ensure t :disabled t)
(use-package material-theme :ensure t :disabled t)
(use-package nzenburn-theme :ensure t :disabled t)
(use-package zenburn-theme :ensure t)

(defvar bg-colors "emacs background colors list")
(defvar fg-colors "emacs foreground colors list")

(setq bg-colors '("cornsilk" "gray0" "gray18" "gray40"))
(setq fg-colors '("gainsboro" "navy"))
(setq mouse-colors '("firebrick" "yellow"))

(use-package smart-mode-line
  :ensure t
  :init
  (use-package rich-minority :ensure t)
  :config
  (setq sml/no-confirm-load-theme t)
  (setq sml/theme 'respectful)
  (setq sml/battery-format " %p%% ")
  (sml/setup)
  (set-face-attribute 'sml/discharging nil :foreground "tomato"))

(set-cursor-color "chartreuse2")
(custom/set-xwindows-font "consolas-base")

(load-theme 'zenburn t)

(unicode-fonts-setup)

(when (boundp 'zenburn-colors-alist)
  (set-face-attribute 'default nil :background "#1A1A1A")
  (set-face-attribute 'region nil :background (cdr (assoc "zenburn-bg-2" zenburn-colors-alist))))

(set-face-attribute 'hydra-face-blue nil :foreground "#00bfff")

(provide 'rc-themes)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-themes.el ends here
