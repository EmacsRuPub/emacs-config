;;; emacs-rc-wincontrol.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet


(autoload 'save-current-configuration "revive" "Save status" t)
(autoload 'resume "revive" "Resume Emacs" t)
(autoload 'wipe "revive" "Wipe Emacs" t)

(require 'window-number)
(require 'buffer-move)

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
         ("opossum" (filename . "opossum"))
         ("webdrive" (filename . "webdrive"))
         ("xmonad" (filename . "xmonad"))
         ("emacs" (filename . "emacs"))
         ("doc" (or
                 (mode . latex-mode)
                 (mode . metapost-mode)
                 (mode . doc-view-mode)
                 (mode . markdown-mode)))
         ("build" (or
                   (mode . cmake-mode)
                   (mode . makefile-mode)
                   (mode . makefile-gmake-mode)))
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

(require 'revive+)
(setq revive-plus:all-frames t)
(revive-plus:demo)

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

(global-set-key (kbd "C-s-<up>") 'windmove-up)
(global-set-key (kbd "C-s-<down>") 'windmove-down)
(global-set-key (kbd "C-s-<left>") 'windmove-left)
(global-set-key (kbd "C-s-<right>") 'windmove-right)

(define-key ibuffer-mode-map (kbd "/ .") 'ibuffer-filter-by-extname)

(define-prefix-command 'custom-windowing-keymap)
(define-key custom-windowing-keymap (kbd "s") 'save-current-configuration)
(define-key custom-windowing-keymap (kbd "r") 'resume)
(define-key custom-windowing-keymap (kbd "c") 'wipe)
(global-set-key (kbd "<f2>") 'custom-windowing-keymap)

(provide 'rc-wincontrol)

;;; emacs-rc-wincontrol.el ends here
