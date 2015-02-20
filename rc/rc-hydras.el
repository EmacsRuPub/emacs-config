;;; rc-hydras.el ---

;; Copyright (C) 2015 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:

(defhydra hydra-window (global-map "<f2>")
  "window"
  ("<left>" windmove-left "left")
  ("<down>" windmove-down "down")
  ("<up>" windmove-up "up")
  ("<right>" windmove-right "right")
  ("w" ace-window "ace" :color blue)
  ("3" (lambda ()
         (interactive)
         (split-window-right)
         (windmove-right)
         (switch-to-next-buffer))
   "vert")
  ("2" (lambda ()
         (interactive)
         (split-window-below)
         (windmove-down)
         (switch-to-next-buffer))
   "horiz")
  ("u" hydra-universal-argument "universal")
  ("s" (lambda () (interactive) (ace-window 4)) "swap" :color blue)
  ("d" (lambda () (interactive) (ace-window 16)) "delete" :color blue)
  ("o" delete-other-windows "1" :color blue)
  ("i" ace-maximize-window "a1" :color blue)
  ("q" nil "cancel"))

(defhydra hydra-programming (global-map "M-P")
  "programming"
  ("s" slime "run slime" :color blue)
  ("l" slime-selector "slime selector" :color blue)
  ("q" nil "cancel"))

(defhydra hydra-entries (global-map "<f3>")
  ("!" flycheck-first-error "ace" :color blue)
  ("<up>" flycheck-previous-error "previous error")
  ("<down>" flycheck-next-error "next error")
  ("<prior>" custom/find-url-backward "previous url")
  ("<next>" custom/find-url-forward "next url")
  ("q" nil "cancel"))

(provide 'rc-hydras)

;;; rc-hydras.el ends here
