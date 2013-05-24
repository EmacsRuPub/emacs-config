;; -*- coding: utf-8 -*-
;;
;; Filename: rc-themes.el
;; Created: Чт апр  4 18:48:40 2013 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; We know we have consolas on OS X, so use it
;; ;; We also need to do this as near the beginning as possible, since it crashes
;; ;; otherwise?
;; (defun qdot/set-platform-font ()
;;   "Set the default font for the system type."
;;   (interactive)
;;   (when (and macosx-p
;; (when (member "Consolas" (font-family-list))
;; (set-face-font 'default "consolas-11"))))
;;   (when mswindows-p
;;     (set-face-font 'default "consolas-8"))
;;   (when linux-p
;;     (when (member "Inconsolata" (font-family-list))
;;       (set-face-font 'default "inconsolata-11"))))

;; (qdot/set-platform-font)

;; ;; Great for black background
;; (set-face-background 'hl-line "gray8")

;; Other background colors
;; (set-face-background 'hl-line "#181800")
;; (set-face-background 'hl-line "lemon chiffon")
;; (set-face-background 'hl-line "#220")
;; (set-face-background 'hl-line "#110")
;; (set-face-background 'hl-line "#222")
;; (set-face-background 'hl-line "#111")

;; Other foreground colors
;; (set-face-foreground 'hl-line "white")
;; (set-face-foreground 'hl-line nil)

;; ;;; Fonts

;; (when (eq system-type 'darwin)
;;   ;; default Latin font (e.g. Consolas)
;;   ;; default font size (point * 10)
;;   (set-face-attribute 'default nil :family "Monaco" :height 120 :weight 'normal))

;; ;; To change a font size globally:
;; ;; (set-face-attribute 'default nil :height 360)
;; ;; (set-face-attribute 'default nil :height 240)
;; ;; (set-face-attribute 'default nil :height 160)
;; ;; (set-face-attribute 'default nil :height 120)

;; ;; To change the font size interactively per buffer:
;; ;; Up: C-x C-+, C-x C-=
;; ;; Down: C-x C--
;; ;; Reset: C-x C-0

;; (set-face-background 'region "#464740")
;; (set-face-background 'hl-line "#222222")
;; (set-face-background 'yas/field-highlight-face "#333399")
;; (set-face-foreground 'font-lock-warning-face "#ff6666")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-themes.el ends here
