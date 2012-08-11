;;; emacs-rc-wincontrol.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(require 'window-number)
(require 'buffer-move)
(require 'quick-jump)
(require 'framemove)
(require 'buff-menu+)

(window-number-meta-mode)
(quick-jump-default-keybinding)
(setq framemove-hook-into-windmove t)

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
(global-set-key (kbd "<C-M-down>") 'win-resize-minimize-vert)
(global-set-key (kbd "<C-M-up>") 'win-resize-enlarge-vert)
(global-set-key (kbd "<C-M-right>") 'win-resize-minimize-horiz)
(global-set-key (kbd "<C-M-left>") 'win-resize-enlarge-horiz)

;; buffer controls
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "<f11>") 'buffer-menu)

(global-set-key (kbd "C-S-c <up>") 'buf-move-up)
(global-set-key (kbd "C-S-c <down>") 'buf-move-down)
(global-set-key (kbd "C-S-c <left>") 'buf-move-left)
(global-set-key (kbd "C-S-c <right>") 'buf-move-right)

(global-set-key (kbd "C-c <up>") 'windmove-up)
(global-set-key (kbd "C-c <down>") 'windmove-down)
(global-set-key (kbd "C-c <left>") 'windmove-left)
(global-set-key (kbd "C-c <right>") 'windmove-right)

;;; emacs-rc-wincontrol.el ends here
