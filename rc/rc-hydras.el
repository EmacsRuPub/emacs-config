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
  ("<left>" previous-error "previous error")
  ("<right>" next-error "next error")
  ("q" nil "cancel"))

(defhydra hydra-toggle (global-map "<f11>" :color blue)
  ("d" toggle-debug-on-error "debug on error")
  ("w" whitespace-mode "whitespace mode"))

(defhydra hydra-mingus (global-map "C-c m s")
  ("s" mingus "open mingus")
  ("<right>" mingus-seek "seek forward")
  ("<left>" mingus-seek-backward "seek backward")
  ("q" nil "cancel"))

(defhydra hydra-smart-moving (global-map "C-c 9")
  ("<left>" smart-backward "smart seek backward")
  ("<down>" smart-down "smart seek down")
  ("<up>" smart-up "smart seek up")
  ("<right>" smart-forward "smart seek forward")
  ("q" nil "cancel"))

;; Transpose stuff with M-t
(global-unset-key (kbd "M-t")) ;; which used to be transpose-words
(defhydra hydra-transpose (global-map "M-t")
  ("M-b" backward-word "prev word")
  ("M-f" forward-word "next word")
  ("<up>" previous-line "prev line")
  ("<down>" next-line "next line")
  ("<left>" backward-char "prev char")
  ("<right>" forward-char "next char")
  ("C-_" undo-tree-undo "undo last")
  ("w" transpose-words "on words")
  ("s" transpose-sexps "on sexps")
  ("p" transpose-params "on params")
  ("a" anchored-transpose "anchored")
  ("q" nil "cancel"))

(defhydra hydra-scope (global-map "C-x s") ; was save-some-buffers
  ("r" narrow-to-region)
  ("d" narrow-to-defun)
  ("c" narrow-to-defun+comments-above)
  ("w" widen)
  ;TODO: maybe add org narrowing
  ("q" nil "cancel"))

(provide 'rc-hydras)

;;; rc-hydras.el ends here
