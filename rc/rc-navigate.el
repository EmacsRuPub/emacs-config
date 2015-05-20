;; -*- coding: utf-8 -*-
;;
;; Filename: rc-navigate.el
;; Created:  Thu May 29 17:37:11 2014 +0400
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package bookmark+
  :init
  (use-package crosshairs))

(use-package re-builder
  :defer t)

(use-package helm
  :defer t
  :bind ("C-x C-d" . helm-recentd)
  :init
  (use-package helm-config)
  (use-package helm-files)
  (use-package helm-info)
  (use-package helm-locate)
  (use-package helm-misc)
  (use-package helm-recentd)
  (use-package helm-grep)
  (use-package helm-projectile)
  (use-package helm-descbinds)
  :config
  (progn
    (setq helm-recentd--action
          (append
           helm-recentd--action
           (cond ((executable-find "urxvt")
                  '(("Open in Urxvt"
                     . (lambda (ignored)
                         (shell-command (format "urxvt -e $SHELL -c 'cd %s && $SHELL' &"
                                                (helm-recentd--get-target-string))))))))))
    (setq helm-recentd-sort 'frequency)
    (setq helm-quick-update t)
    (setq helm-split-window-in-side-p t)
    (setq helm-ff-search-library-in-sexp t)
    (setq helm-ff-file-name-history-use-recentf t)
    (setq helm-buffers-fuzzy-matching t)
    (setq helm-recentf-fuzzy-match t)
    (setq helm-locate-fuzzy-match t)
    (setq helm-M-x-fuzzy-match t)
    (setq helm-apropos-fuzzy-match t)
    (setq helm-apropos-fuzzy-match t)
    (setq helm-move-to-line-cycle-in-source t)
    (pushnew 'python-mode helm-buffers-favorite-modes)
    (bind-key "C-<down>" 'helm-next-source helm-map)
    (bind-key "C-<up>" 'helm-previous-source helm-map)
    (bind-key "h" 'helm-mini  custom-search-keymap)
    (bind-key "C-x b" 'helm-buffers-list)
    (bind-key "C-x j j" 'helm-bookmarks)
    (bind-key "C-x C-f" 'custom/helm-find-files)
    (bind-key "M-x" 'helm-M-x)
    (bind-key "q" 'helm-projectile custom-search-keymap)
    (bind-key "r" 'helm-do-grep custom-search-keymap)
    (bind-key "C-h a" 'helm-apropos)
    (bind-key "C-h r" 'helm-info-emacs)
    (bind-key "C-h r" 'helm-info-at-point)
    (bind-key "f" 'custom/helm-find-files custom-search-keymap)
    (bind-key "s" 'helm-semantic-or-imenu custom-search-keymap)
    (bind-key "p" 'helm-projectile-switch-project custom-search-keymap)
    (bind-key "c" 'helm-flycheck custom-search-keymap)
    ;TODO: investigate and bind 'helm-resume
    ;TODO: investigate and bind 'helm-multi-files
    (helm-mode t)
    (helm-adaptive-mode 1)
    (helm-autoresize-mode 1)
    (helm-descbinds-mode 1)             ; find the cause of "attempt to delete minibuffer window"
    ))

(use-package helm-ag
  :config
  (setq helm-ag-insert-at-point 'symbol)
  (setq helm-ag-fuzzy-match t)
  (bind-key "g" 'helm-ag-project-root custom-search-keymap))

(use-package helm-gtags
  :defer t
  :config
  (progn
    (setq helm-gtags-path-style 'relative)
    (setq helm-gtags-ignore-case t)
    (setq helm-gtags-auto-update t)
    (setq helm-gtags-use-input-at-cursor t)
    (setq helm-gtags-pulse-at-cursor t)
    (setq helm-gtags-suggested-key-mapping t)
    (bind-key "M-t" 'helm-gtags-find-tag helm-gtags-mode-map)
    (bind-key "M-r" 'helm-gtags-find-rtag helm-gtags-mode-map)
    (bind-key "C-M-s" 'helm-gtags-find-symbol helm-gtags-mode-map)
    ;; (bind-key "M-s" 'helm-gtags-select helm-gtags-mode-map)
    (bind-key "M-g M-p" 'helm-gtags-parse-file helm-gtags-mode-map)
    (bind-key "C-c <" 'helm-gtags-previous-history helm-gtags-mode-map)
    (bind-key "C-c >" 'helm-gtags-next-history helm-gtags-mode-map)
    (bind-key "M-." 'helm-gtags-dwim helm-gtags-mode-map)
    (bind-key "M-," 'helm-gtags-pop-stack helm-gtags-mode-map)
    (add-hook 'dired-mode-hook 'helm-gtags-mode)
    (add-hook 'c-mode-hook 'helm-gtags-mode)
    (add-hook 'c++-mode-hook 'helm-gtags-mode)))

(use-package swoop
  :config
  (progn
    (bind-key "m" 'swoop-multi custom-search-keymap)
    (bind-key "i" 'swoop custom-search-keymap)
    (bind-key "o" '(lambda () (interactive) (swoop "")) custom-search-keymap)
    (bind-key "<down>" 'swoop-action-goto-line-next swoop-map)
    (bind-key "<up>" 'swoop-action-goto-line-prev swoop-map)))

(use-package breadcrumb
  :config
  (defhydra hydra-breadcrumb (:exit t)
    "
Breadcrumb bookmarks:
  _<up>_:   prev   _S-<up>_:   local prev
  _<down>_: next   _S-<down>_: local next
  _s_: set  _c_: clear  _l_: list  _q_: quit
"
    ("<down>" bc-next nil :exit nil)
    ("<up>" bc-previous nil :exit nil)
    ("S-<down>" bc-local-next nil :exit nil)
    ("S-<up>" bc-local-previous nil :exit nil)
    ("l" bc-list nil)
    ("s" bc-set nil)
    ("c" bc-clear nil)
    ("q" nil nil)))
(global-set-key (kbd "<f12>") 'hydra-breadcrumb/body)

(use-package zoom-window
  :bind ("C-x C-z" . zoom-window-zoom)
  :config
  (setq zoom-window-mode-line-color "DarkGreen"))

(use-package ibuffer
  :defer t
  :config
  (progn
    (setq ibuffer-default-sorting-mode 'major-mode) ;recency
    (setq ibuffer-always-show-last-buffer :nomini)
    (setq ibuffer-default-shrink-to-minimum-size t)
    (setq ibuffer-jump-offer-only-visible-buffers t)
    (setq ibuffer-saved-filters
          '(("dired" ((mode . dired-mode)))
            ("leechcraft" ((filename . "leechcraft")))
            ("qxmpp" ((filename . "qxmpp")))
            ("xmonad" ((filename . "xmonad")))
            ("jabberchat" ((mode . jabber-chat-mode)))
            ("orgmode" ((mode . org-mode)))
            ("elisp" ((mode . emacs-lisp-mode)))
            ("fundamental" ((mode . fundamental-mode)))
            ("haskell" ((mode . haskell-mode)))))
    (setq ibuffer-saved-filter-groups custom/ibuffer-saved-filter-groups)
    (add-hook 'ibuffer-mode-hook
              (lambda () (ibuffer-switch-to-saved-filter-groups "default"))) ;; Make sure we're always using our buffer groups
    (add-hook 'ibuffer-mode-hook
              (lambda () (define-key ibuffer-mode-map (kbd "M-o") 'other-window))) ; was ibuffer-visit-buffer-1-window
    (bind-key "/ ." 'custom/ibuffer-filter-by-extname ibuffer-mode-map)
    ))

(use-package fuzzy
  :config
  (turn-on-fuzzy-isearch))

(use-package window-number
  :config
  (window-number-meta-mode))

(use-package windmove
  :init
  (use-package framemove)
  :bind
  (("C-s-<up>" . windmove-up)
   ("C-s-<down>" . windmove-down)
   ("C-s-<left>" . windmove-left)
   ("C-s-<right>" . windmove-right)
   ))

(use-package framemove
  :config
  (setq framemove-hook-into-windmove t))

(use-package ace-window
  :init
  (setq aw-background nil)
  (setq aw-leading-char-style 'char)
  (ace-window-display-mode)
  (set-face-attribute 'aw-mode-line-face nil :foreground "white")
  (custom-set-faces
     '(aw-leading-char-face
       ((t (:inherit ace-jump-face-foreground :height 3.0))))))

(use-package ace-link
  :config
  (progn
    (ace-link-setup-default)
    (define-key org-mode-map (kbd "M-o") 'ace-link-org)))

(use-package orglink
  :config
  ;; TODO: customize orglink-activate-in-modes
  (global-orglink-mode))

(setq scroll-preserve-screen-position 'always)

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
  ("<C-up>" custom/win-resize-enlarge-vert "move splitter up")
  ("<C-down>" custom/win-resize-minimize-vert "move splitter dow")
  ("<C-left>" custom/win-resize-enlarge-horiz "move splitter left")
  ("<C-right>" custom/win-resize-minimize-horiz "move splitter right")
  ("g" avy-goto-char "goto char within window" :color blue)
  ("G" avy-goto-word-0 "goto word within window" :color blue)
  ("=" text-scale-increase)
  ("-" text-scale-decrease)
  ("f" make-frame-command)
  ("F" delete-other-frames)              ;; TODO: maybe provide current frame deletion also
  ("q" nil "cancel"))

(defhydra hydra-scope (global-map "C-x s") ; was save-some-buffers
  ("r" narrow-to-region)
  ("d" narrow-to-defun)
  ("c" narrow-to-defun+comments-above)
  ("w" widen)
  ;TODO: maybe add org narrowing
  ("q" nil "cancel"))

(defhydra hydra-entries (global-map "<f3>")
  ("!" flycheck-first-error "ace" :color blue)
  ("<up>" flycheck-previous-error "previous error")
  ("<down>" flycheck-next-error "next error")
  ("<prior>" custom/find-url-backward "previous url")
  ("<next>" custom/find-url-forward "next url")
  ("<left>" previous-error "previous error")
  ("<right>" next-error "next error")
  ("k" smerge-prev "previous conflict")
  ("j" smerge-next "next conflict")
  ("<return>" custom/process-thing-at-point "execute ;)" :color blue)
  ("q" nil "cancel"))

(defhydra hydra-smart-moving (global-map "C-c 9")
  ("<left>" smart-backward "smart seek backward")
  ("<down>" smart-down "smart seek down")
  ("<up>" smart-up "smart seek up")
  ("<right>" smart-forward "smart seek forward")
  ("q" nil "cancel"))

(global-unset-key (kbd "C-s"))
(global-unset-key (kbd "C-r"))
(global-unset-key (kbd "C-M-s"))
(global-unset-key (kbd "C-M-r"))
(global-unset-key (kbd "C-x C-b"))
(global-set-key (kbd "C-s") 'phi-search)
(global-set-key (kbd "C-r") 'phi-search-backward)
(define-key isearch-mode-map (kbd "C-o") 'custom/isearch-occur)

(provide 'rc-navigate)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-navigate.el ends here
