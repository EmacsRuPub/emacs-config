;; -*- coding: utf-8 -*-
;;
;; Filename: rc-navigate.el
;; Created:  Thu May 29 17:37:11 2014 +0400
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package bookmark+
  :init
  (use-package crosshairs)
  :config
  (setq bmkp-last-bookmark-file (at-data-dir "/bookmarks")))

(use-package re-builder
  :defer t)

(use-package helm
  :defer t
  :init
  (use-package helm-config)
  (use-package helm-files)
  (use-package helm-info)
  (use-package helm-locate)
  (use-package helm-misc)
  (use-package helm-grep)
  (use-package wgrep-helm) ;TODO: maybe configure
  (use-package helm-projectile)
  (use-package helm-descbinds)
  (use-package helm-themes)
  (use-package helm-helm-commands)
  (use-package helm-dired-recent-dirs)
  :config
  (progn
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
    (setq helm-adaptive-history-file (at-data-dir "/helm-adaptive-history"))
    (pushnew 'python-mode helm-buffers-favorite-modes)
    (bind-key "C-<down>" 'helm-next-source helm-map)
    (bind-key "C-<up>" 'helm-previous-source helm-map)
    (bind-key "C-x b" 'helm-buffers-list)
    (bind-key "C-x j j" 'helm-bookmarks)
    (bind-key "M-x" 'helm-M-x)
    (bind-key "C-h a" 'helm-apropos)
    (bind-key "C-h r" 'helm-info-emacs)
    (bind-key "C-h r" 'helm-info-at-point)
    (bind-key "C-x C-r" 'helm-recentf)
    ;;TODO: investigate and bind 'helm-resume
    ;;TODO: investigate and bind 'helm-multi-files
    (helm-mode t)
    (helm-adaptive-mode 1)
    (helm-autoresize-mode 1)
    (helm-descbinds-mode 1)             ; find the cause of "attempt to delete minibuffer window"
    ))

(use-package helm-ag
  :config
  (setq helm-ag-insert-at-point 'symbol)
  (setq helm-ag-fuzzy-match t)
  ;;TODO: add other common escapes
  (defadvice helm-ag--query (after escape-search-term activate)
    (setq helm-ag--last-query (replace-regexp-in-string "\\*" "\\\\*" helm-ag--last-query))))

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
    (bind-key "<down>" 'swoop-action-goto-line-next swoop-map)
    (bind-key "<up>" 'swoop-action-goto-line-prev swoop-map)))

(use-package zoom-window
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
            ("foss" ((filename . "foss")))
            ("pets" ((filename . "pets")))
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

(use-package windmove
  :init
  (use-package framemove)
  :bind
  (("C-s-<up>" . windmove-up)
   ("C-s-<down>" . windmove-down)
   ("C-s-<left>" . windmove-left)
   ("C-s-<right>" . windmove-right)
   ))

(use-package windsize)

(use-package framemove
  :config
  (setq framemove-hook-into-windmove t))

(use-package ace-window
  :init
  (setq aw-background nil)
  (setq aw-leading-char-style 'char)
  :config
  (set-face-attribute 'aw-mode-line-face nil :foreground "white")
  (custom-set-faces
     '(aw-leading-char-face
       ((t (:inherit ace-jump-face-foreground :height 3.0))))))

(use-package ace-link
  :config
  (ace-link-setup-default))

(use-package dired
  :config
  (setq dired-recursive-deletes 'top) ;; Allows recursive deletes
  (setq dired-dwim-target t)
  (setq dired-listing-switches "-lah1v --group-directories-first")
  (global-set-key (kbd "C-c x") 'direx:jump-to-directory)
  ;; (global-set-key (kbd "C-c C-j") 'dired-jump)
  (bind-key "C-c C-s" 'dired-toggle-sudo dired-mode-map)
  (bind-key "C-c C-m" 'custom/get-file-md5 dired-mode-map)
  (bind-key "!" 'custom/sudo-dired dired-mode-map)
  (bind-key "C-a" 'custom/dired-back-to-start-of-files dired-mode-map)
  (bind-key "C-x C-k" 'dired-do-delete dired-mode-map) ;; Delete with C-x C-k to match file buffers and magit
  (bind-key "`" 'custom/dired-open-term dired-mode-map)
  (define-key dired-mode-map (vector 'remap 'beginning-of-buffer) 'custom/dired-back-to-top)
  (define-key dired-mode-map (vector 'remap 'end-of-buffer) 'custom/dired-jump-to-bottom))

(use-package dired+
  :config
  ;; TODO: check if this is not obsolete yet
  (setq diredp-ignored-file-name 'green-face)
  (setq diredp-other-priv 'white-face)
  (setq diredp-rare-priv 'white-red-face)
  (setq diredp-compressed-file-suffix 'darkyellow-face))

(use-package wdired
  :defer t
  :config
  (progn
    (setq wdired-allow-to-change-permissions 'advanced)
    (setq wdired-allow-to-change-permissions t)
    (bind-key "C-a" 'custom/dired-back-to-start-of-files wdired-mode-map)
    (bind-key (vector 'remap 'beginning-of-buffer) 'custom/dired-back-to-top wdired-mode-map)
    (bind-key (vector 'remap 'end-of-buffer) 'custom/dired-jump-to-bottom wdired-mode-map)
    (bind-key "r" 'wdired-change-to-wdired-mode dired-mode-map)
    ))

(use-package dired-x)
(use-package dired-toggle-sudo)

(use-package discover-my-major
  ;TODO: bind to key
  )

(use-package phi-search-mc
  :config
  (phi-search-mc/setup-keys)
  (add-hook 'isearch-mode-hook 'phi-search-from-isearch-mc/setup-keys)
)

(use-package recursive-narrow)

(use-package swiper
  :config
  (setq ivy-display-style 'fancy)
  (custom-set-faces
   '(swiper-minibuffer-match-face-1
     ((t :background "#dddddd")))
   '(swiper-minibuffer-match-face-2
     ((t :background "#bbbbbb" :weight bold)))
   '(swiper-minibuffer-match-face-3
     ((t :background "#bbbbff" :weight bold)))
   '(swiper-minibuffer-match-face-4
     ((t :background "#ffbbff" :weight bold)))))

(use-package transpose-frame
  :config
  (defhydra hydra-transpose-frame ()
    "frames geometry management"
    ("t" transpose-frame "transpose")
    ("i" flip-frame "flip")
    ("o" flop-frame "flop")
    ("r" rotate-frame "rotate")
    ("<left>" rotate-frame-anticlockwise "rotate <-")
    ("<right>" rotate-frame-clockwise "rotate ->")
    ("q" nil "cancel"))
  (global-set-key (kbd "C-<f2>") 'hydra-transpose-frame/body))

;; Reload dired after making changes
(--each '(dired-do-rename
          dired-create-directory
          wdired-abort-changes)
        (eval `(defadvice ,it (after revert-buffer activate)
                 (revert-buffer))))

(setq scroll-preserve-screen-position 'always)

;;TODO: plan docstring
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
  ("<C-up>" windsize-up "move splitter up")
  ("<C-down>" windsize-down "move splitter down")
  ("<C-left>" windsize-left "move splitter left")
  ("<C-right>" windsize-right "move splitter right")
  ("g" avy-goto-char "goto char within window" :color blue)
  ("G" avy-goto-word-0 "goto word within window" :color blue)
  ("=" text-scale-increase)
  ("-" text-scale-decrease)
  ("f" make-frame-command)
  ("F" delete-other-frames)              ;; TODO: maybe provide current frame deletion also
  ("q" nil "cancel"))

(defhydra hydra-scope (:color blue)
"
Narrow to            Widen
------------------------------------
_r_egion             _w_iden
_d_efun              _z_oom window
defun + _c_omments
"
  ("r" narrow-to-region)
  ("d" narrow-to-defun)
  ("c" narrow-to-defun+comments-above)
  ("w" widen)
  ("z" zoom-window-zoom)
  ("N" recursive-narrow-or-widen-dwim)
  ("W" recursive-widen-dwim)
  ;TODO: maybe add org narrowing
  ("q" nil "cancel"))
(global-set-key (kbd "<f9>") 'hydra-scope/body)

;;TODO: plan docstring
(defhydra hydra-entries ()
  ("!" flycheck-first-error "ace" :color blue)
  ("<up>" flycheck-previous-error "previous error")
  ("<down>" flycheck-next-error "next error")
  ("<prior>" custom/find-url-backward "previous url")
  ("<next>" custom/find-url-forward "next url")
  ("<left>" previous-error "previous error")
  ("<right>" next-error "next error")
  ("k" smerge-prev "previous conflict")
  ("j" smerge-next "next conflict")
  ("r" custom/open-urls-in-region :color blue)
  ("=" custom/skip-to-next-blank-line)
  ("-" custom/skip-to-previous-blank-line)
  ("h" git-gutter:previous-hunk)
  ("l" git-gutter:next-hunk)
  ("<return>" custom/process-thing-at-point "execute ;)" :color blue)
  ("q" nil "cancel"))
(global-set-key (kbd "<f3>") 'hydra-entries/body)

(defhydra hydra-navigate (:color blue)
  "
Search                 Various
------------------------------
_r_ recursive grep     _h_ helm-mini
_s_ semantic/imenu     _q_ projectile
_m_ multi swoop        _f_ find files
_i_ find occurencies   _p_ switch project
_o_ find in buffer     _c_ helm-flycheck
_g_ ag in project      _w_ select w3m buffer
                     _t_ google-translate at point
                     _T_ google translate
                     _l_ org headlines
"
  ("h" helm-mini)
  ("q" helm-projectile)
  ("r" helm-do-grep)
  ("f" custom/helm-find-files)
  ("s" helm-semantic-or-imenu)
  ("p" helm-projectile-switch-project)
  ("c" helm-flycheck)
  ("m" swoop-multi)
  ("i" swoop)
  ("o" (lambda () (interactive) (swoop "")))
  ("g" helm-ag-project-root)
  ("w" w3m-select-buffer)
  ("t" google-translate-at-point)
  ("T" google-translate-query-translate)
  ("l" helm-org-headlines))
(global-set-key (kbd "C-`") 'hydra-navigate/body)

(global-unset-key (kbd "C-s"))
(global-unset-key (kbd "C-r"))
(global-unset-key (kbd "C-M-s"))
(global-unset-key (kbd "C-M-r"))
(global-unset-key (kbd "C-x C-b"))
(global-set-key (kbd "C-s") 'phi-search)
(global-set-key (kbd "C-r") 'phi-search-backward)

(provide 'rc-navigate)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-navigate.el ends here
