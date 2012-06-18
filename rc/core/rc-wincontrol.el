;;; emacs-rc-wincontrol.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords: 
;; Requirements: 
;; Status: not intended to be distributed yet

(require 'window-number)

(window-number-meta-mode)
;; (windmove-default-keybindings 'meta)
;; (windmove-default-keybindings)


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
(global-set-key (kbd "C-,") 'previous-buffer)
(global-set-key (kbd "C-.") 'next-buffer)
;; (global-set-key (kbd "<f6>") 'bury-buffer)
(global-set-key (kbd "C-x w") 'workspace-goto)

;;; emacs-rc-wincontrol.el ends here
