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
  ("s" (lambda () (interactive) (ace-window 4)) "swap")
  ("d" (lambda () (interactive) (ace-window 16)) "delete")
  ("1" delete-other-windows "1" :color blue)
  ("i" ace-maximize-window "a1" :color blue)
  ("<C-up>" win-resize-minimize-vert "move splitter up")
  ("<C-down>" win-resize-enlarge-vert "move splitter dow")
  ("<C-left>" win-resize-minimize-horiz "move splitter left")
  ("<C-right>" win-resize-enlarge-horiz "move splitter right")
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

(defhydra hydra-toggle (global-map "<f11>" :color blue)
  ("d" toggle-debug-on-error "debug on error")
  ("w" whitespace-mode "whitespace mode"))

(provide 'rc-hydras)

;;; rc-hydras.el ends here
