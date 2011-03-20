;;; emacs-rc-wincontrol.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords: 
;; Requirements: 
;; Status: not intended to be distributed yet

(load-file "~/site-lisp/wm/window-number.el")
(require 'window-number)

(window-number-meta-mode)
;; (windmove-default-keybindings 'meta)
;; (windmove-default-keybindings)

;#############################################################################
;#   Window resizing
;############################################################################
(defun win-resize-top-or-bot ()
  "Figure out if the current window is on top, bottom or in the middle"
  (let* ((win-edges (window-edges))
         (this-window-y-min (nth 1 win-edges))
         (this-window-y-max (nth 3 win-edges))
         (fr-height (frame-height)))
    (cond
     ((eq 0 this-window-y-min) "top")
     ((eq (- fr-height 1) this-window-y-max) "bot")
     (t "mid"))))

(defun win-resize-left-or-right ()
  "Figure out if the current window is to the left, right or in the middle"
  (let* ((win-edges (window-edges))
         (this-window-x-min (nth 0 win-edges))
         (this-window-x-max (nth 2 win-edges))
         (fr-width (frame-width)))
    (cond
     ((eq 0 this-window-x-min) "left")
     ((eq (+ fr-width 4) this-window-x-max) "right")
     (t "mid"))))

(defun win-resize-enlarge-vert ()
  (interactive)
  (cond
   ((equal "top" (win-resize-top-or-bot)) (enlarge-window -1))
   ((equal "bot" (win-resize-top-or-bot)) (enlarge-window 1))
   ((equal "mid" (win-resize-top-or-bot)) (enlarge-window -1))
   (t (message "nil"))))

(defun win-resize-minimize-vert ()
  (interactive)
  (cond
   ((equal "top" (win-resize-top-or-bot)) (enlarge-window 1))
   ((equal "bot" (win-resize-top-or-bot)) (enlarge-window -1))
   ((equal "mid" (win-resize-top-or-bot)) (enlarge-window 1))
   (t (message "nil"))))

(defun win-resize-enlarge-horiz ()
  (interactive)
  (cond
   ((equal "left" (win-resize-left-or-right)) (enlarge-window-horizontally -1))
   ((equal "right" (win-resize-left-or-right)) (enlarge-window-horizontally 1))
   ((equal "mid" (win-resize-left-or-right)) (enlarge-window-horizontally -1))))

(defun win-resize-minimize-horiz ()
  (interactive)
  (cond
   ((equal "left" (win-resize-left-or-right)) (enlarge-window-horizontally 1))
   ((equal "right" (win-resize-left-or-right)) (enlarge-window-horizontally -1))
   ((equal "mid" (win-resize-left-or-right)) (enlarge-window-horizontally 1))))

;#############################################################################
;#   Buffers management
;############################################################################
(setq ibuffer-saved-filters 
      (quote (("dired" ((mode . dired-mode)))
	      ("leechcraft" ((filename . "leechcraft")))
	      ("qxmpp" ((filename . "qxmpp")))
	      ("xmonad" ((filename . "xmonad")))
	      ("jabberchat" ((mode . jabber-chat-mode)))
	      ("orgmode" ((mode . org-mode)))
	      ("elisp" ((mode . emacs-lisp-mode)))
	      ("fundamental" ((mode . fundamental-mode)))
	      ("haskell" ((mode . haskell-mode))))))

;; (setq special-display-regexps (remove "[ ]?\\*[hH]elp.*" special-display-regexps))
;; (setq special-display-regexps (remove "[ ]?\\*info.*\\*[ ]?" special-display-regexps))
;; (setq special-display-regexps (remove "[ ]?\\*Messages\\*[ ]?" special-display-regexps))


;#############################################################################
;#   Keybindings
;############################################################################

;; windows resizing
(global-set-key [C-M-down] 'win-resize-minimize-vert)
(global-set-key [C-M-up] 'win-resize-enlarge-vert)
(global-set-key [C-M-right] 'win-resize-minimize-horiz)
(global-set-key [C-M-left] 'win-resize-enlarge-horiz)

;; buffer controls
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key [?\C-,] 'previous-buffer)
(global-set-key [?\C-.] 'next-buffer)
;; (global-set-key [f6] 'bury-buffer)

;;; emacs-rc-wincontrol.el ends here
