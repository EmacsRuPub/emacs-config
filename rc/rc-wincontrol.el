;;; emacs-rc-wincontrol.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(require 'window-number)
(require 'buffer-move)
(require 'buff-menu+)

(require 'defun-wincontrol)

(window-number-meta-mode)

;#############################################################################
;#   Buffers management
;############################################################################
(require 'ibuffer)
(setq ibuffer-default-sorting-mode 'major-mode) ;recency
(setq ibuffer-always-show-last-buffer :nomini)
(setq ibuffer-default-shrink-to-minimum-size t)
(setq ibuffer-jump-offer-only-visible-buffers t)

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

(setq ibuffer-saved-filter-groups
      '(("default"
         ("dired" (mode . dired-mode))
         ("source" (or
                    (mode . c-mode)
                    (mode . c++-mode)
                    (mode . objc-mode)
                    (mode . cperl-mode)
                    (mode . perl-mode)
                    (mode . java-mode)
                    (filename . "\\.rb\\'")))
         ("web" (or
                 (filename . "\\.js\\'")
                 (filename . "\\.erb\\'")
                 (mode . html-mode)
                 (mode . nxml-mode)
                 (mode . nxhtml-mode)
                 (mode . haml-mode)
                 (mode . css-mode)
                 (mode . sass-mode)
                 (mode . coffee-mode)))
         ("doc" (or
                 (mode . latex-mode)
                 (mode . metapost-mode)
                 (mode . doc-view-mode)
                 (mode . markdown-mode)))
         ("build" (or
                   (mode . cmake-mode)
                   (mode . makefile-mode)
                   (mode . makefile-gmake-mode)
                   (filename . "Gemfile\\'")
                   (filename . "Gemfile\\.lock\\'")
                   (filename . "[Rr]akefile\\'")))
         ("pim" (or
                 (name . "^\\*Calendar\\*$")
                 (name . "^diary$")
                 (mode . org-mode)))
         ("system" (or
                    (mode . help-mode)
                    (mode . completion-list-mode)
                    (mode . apropos-mode)
                    (name . "^\\*.*\\*$")
                    (filename . "\.emacs\.d")
                    (mode . custom-mode))))))


(setq special-display-regexps (remove "[ ]?\\*[hH]elp.*" special-display-regexps))
(setq special-display-regexps (remove "[ ]?\\*info.*\\*[ ]?" special-display-regexps))
(setq special-display-regexps (remove "[ ]?\\*Messages\\*[ ]?" special-display-regexps))

(add-hook 'ibuffer-mode-hook (lambda () (ibuffer-switch-to-saved-filter-groups "default"))) ;; Make sure we're always using our buffer groups
(add-hook 'ibuffer-mode-hook (lambda () (define-key ibuffer-mode-map (kbd "M-o") 'other-window))) ; was ibuffer-visit-buffer-1-window

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

(define-key ibuffer-mode-map (kbd "/ .") 'ibuffer-filter-by-extname)

(provide 'rc-wincontrol)

;;; emacs-rc-wincontrol.el ends here
