;; -*- coding: utf-8 -*-
;;
;; Filename: rc-navigate.el
;; Created:  Thu May 29 17:37:11 2014 +0400
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq special-display-regexps (remove "[ ]?\\*[hH]elp.*" special-display-regexps))
(setq special-display-regexps (remove "[ ]?\\*info.*\\*[ ]?" special-display-regexps))
(setq special-display-regexps (remove "[ ]?\\*Messages\\*[ ]?" special-display-regexps))

(use-package bookmark+
  :init
  (use-package crosshairs))

(use-package re-builder
  :defer t)

(use-package helm
  :defer t
  :bind ("C-x C-d" . helm-recentd)
  :init
  (use-package helm-files)
  (use-package helm-info)
  (use-package helm-locate)
  (use-package helm-misc)
  (use-package helm-recentd)
  (use-package helm-grep)
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
    (pushnew 'python-mode helm-buffers-favorite-modes)
    (bind-key "h" 'helm-mini  custom-search-keymap)
    (bind-key "o" 'helm-occur  custom-search-keymap)
    (bind-key "f" 'custom/helm-find-files custom-search-keymap)
    (bind-key "s" 'helm-semantic-or-imenu custom-search-keymap)))

(use-package ido
  :init
  (use-package ido-ubiquitous)
  (use-package ido-vertical-mode)
  (use-package flx-ido)
  (use-package thingatpt)
  (use-package imenu)
  :bind (("C-x b" . ido-switch-buffer)
         ("M-s b" . ido-switch-buffer-by-major-mode)
         ("M-s B" . ido-switch-buffer-by-ext-name))
  :config
  (progn
    (ido-mode 'both)
    (ido-ubiquitous-mode 1)
    (ido-load-history)
    (ido-vertical-mode)
    (flx-ido-mode 1)
    (ido-ubiquitous-use-new-completing-read yas/expand 'yasnippet)
    (ido-ubiquitous-use-new-completing-read yas/visit-snippet-file 'yasnippet)

    (setq ido-enable-flex-matching t)
    (setq ido-enable-regexp t)
    (setq ido-everywhere t)
    (setq ido-enable-prefix nil)
    (setq ido-auto-merge-work-directories-length -1)
    (setq ido-create-new-buffer 'always)
    (setq ido-use-filename-at-point 'guess)
    (setq ido-show-dot-for-dired t)
    (setq confirm-nonexistent-file-or-buffer nil)
    (setq ido-enable-tramp-completion nil)
    (setq ido-enable-last-directory-history t)
    (setq ido-confirm-unique-completion nil)
    (setq ido-max-work-directory-list 30)
    (setq ido-max-work-file-list 100)
    (setq ido-max-directory-size 1000000)
    (setq ido-use-url-at-point t)
    (setq ido-use-virtual-buffers t)
    (setq ido-case-fold t) ; case insensitive
    (setq ido-max-prospects 16)
    (setq ido-use-faces nil)
    (setq ido-default-file-method 'selected-window)
    (setq ido-default-buffer-method 'selected-window)
    (setq ido-completing-read-use-initial-input-as-default-commands
          '(ibuffer-filter-by-mode
            ibuffer-filter-by-used-mode))
    (set-default 'imenu-auto-rescan t) ;; Always rescan buffer for imenu

    (put 'diredp-do-bookmark-in-bookmark-file 'ido 'ignore)
    (put 'diredp-set-bookmark-file-bookmark-for-marked 'ido 'ignore)

    (ad-enable-advice
     'ido-read-internal
     'around
     'ido-completing-read-use-initial-input-as-default)

    (ad-activate 'ido-read-internal)

    (add-to-list 'ido-work-directory-list-ignore-regexps tramp-file-name-regexp)

    (add-hook 'ido-setup-hook
              (lambda()
                (define-key ido-completion-map (kbd "C-M-p") (lookup-key ido-completion-map (kbd "C-p")))
                (define-key ido-completion-map (kbd "C-M-n") (lookup-key ido-completion-map (kbd "C-n"))) ; currently, this makes nothing. Maybe they'll make C-n key lately.
                (define-key ido-completion-map (kbd "C-p") 'ido-preview-backward)
                (define-key ido-completion-map (kbd "C-n") 'ido-preview-forward)
                (define-key ido-completion-map (kbd "M-m") 'ido-merge-work-directories)
                (define-key ido-file-completion-map (kbd "C-w") 'ido-delete-backward-updir)
                (define-key ido-file-completion-map (kbd "C-x C-w") 'ido-copy-current-file-name)
                ))
    ;; Increase minibuffer size when ido completion is active
    (add-hook 'ido-minibuffer-setup-hook
              (lambda ()
                (make-local-variable 'resize-minibuffer-window-max-height)
                (setq resize-minibuffer-window-max-height 1)
                (ido-disable-line-truncation)
                (define-key ido-completion-map (kbd "<up>") 'ido-prev-match)
                (define-key ido-common-completion-map (kbd "<up>") 'ido-prev-match)
                (define-key ido-buffer-completion-map (kbd "<up>") 'ido-prev-match)
                (define-key ido-file-completion-map (kbd "<up>") 'ido-prev-match)
                (define-key ido-file-dir-completion-map (kbd "<up>") 'ido-prev-match)
                (define-key ido-completion-map (kbd "<down>") 'ido-next-match)
                (define-key ido-common-completion-map (kbd "<down>") 'ido-next-match)
                (define-key ido-buffer-completion-map (kbd "<down>") 'ido-next-match)
                (define-key ido-file-completion-map (kbd "<down>") 'ido-next-match)
                (define-key ido-file-dir-completion-map (kbd "<down>") 'ido-next-match)
                (define-key ido-common-completion-map (kbd "DEL") 'ido-backspace)
                ))))

(use-package smex
  :init
  (smex-initialize)
  :bind (("M-x" . smex)
         ("M-X" . smex-major-mode-commands)
         ("C-c C-c M-x" . execute-extended-command)))

(use-package wgrep
  :defer t
  :config
  (progn
    (add-hook 'ag-mode-hook 'wgrep-ag-setup)
    (bind-key "C-x C-s" 'wgrep-save-all-buffers ag-mode-map)
    (bind-key "C-x C-s" 'wgrep-save-all-buffers grep-mode-map)))

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

(use-package ace-jump-mode
  :defer t
  :bind ("C-x SPC" . ace-jump-mode-pop-mark)
  :config
  (progn
    (setq ace-jump-mode-scope 'visible)
    (ace-jump-mode-enable-mark-sync)
    (bind-key "a" 'ace-jump-char-mode custom-search-keymap)
    (bind-key "A" 'ace-jump-word-mode custom-search-keymap)))

(use-package swoop
  :config
  (progn
    (bind-key "m" 'swoop-multi custom-search-keymap)
    (bind-key "i" 'swoop custom-search-keymap)
    (bind-key "<down>" 'swoop-action-goto-line-next swoop-map)
    (bind-key "<up>" 'swoop-action-goto-line-prev swoop-map)))

(use-package neotree
  :config
  (bind-key "n" 'neotree-toggle custom-search-keymap))

(use-package breadcrumb
  :config
  (progn
    (bind-key (kbd "j") 'bc-list custom-search-keymap)
    (bind-key (kbd "SPC") 'bc-set custom-search-keymap)))

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
    (bind-key "/ ." 'ibuffer-filter-by-extname ibuffer-mode-map)
    ))

(use-package fuzzy
  :config
  (turn-on-fuzzy-isearch))

(use-package ag
  :config
  (setq ag-highlight-search t))

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

(use-package buffer-move
  :bind
  (("C-S-c <up>" . buf-move-up)
   ("C-S-c <down>" . buf-move-down)
   ("C-S-c <left>" . buf-move-left)
   ("C-S-c <right>" . buf-move-right)))

(global-unset-key (kbd "C-s"))
(global-unset-key (kbd "C-r"))
(global-unset-key (kbd "C-M-s"))
(global-unset-key (kbd "C-M-r"))
(global-unset-key (kbd "C-x C-b"))
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "<C-M-down>") 'win-resize-minimize-vert)
(global-set-key (kbd "<C-M-up>") 'win-resize-enlarge-vert)
(global-set-key (kbd "<C-M-right>") 'win-resize-minimize-horiz)
(global-set-key (kbd "<C-M-left>") 'win-resize-enlarge-horiz)
(define-key isearch-mode-map (kbd "C-o") 'isearch-occur)
(define-key custom-search-keymap (kbd "r") 'rgrep)

(provide 'rc-navigate)

;; TODO: See if we can customize Bookmarks[+] further

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-navigate.el ends here
