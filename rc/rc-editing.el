;; -*- coding: utf-8 -*-
;;
;; Filename: rc-editing.el
;; Created:  Fri May 24 22:41:54 2013 +0400
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package rst)
(use-package saveplace)
(use-package table) ;; table
(use-package footnote)
(use-package snakehump :ensure t)
(use-package highlight-sexp :ensure t)
(use-package adaptive-wrap :ensure t)
(use-package anchored-transpose :ensure t)
(use-package edit-indirect :ensure t)
(use-package epoch-view :ensure t)
(use-package hungry-delete :ensure t)
(use-package multifiles :ensure t)
(use-package narrow-indirect :ensure t)
(use-package replace+ :ensure t)
(use-package scratch :ensure t)

(setq auto-revert-verbose nil)
(setq comment-style 'indent)
(setq default-input-method 'russian-computer)
(setq delete-by-moving-to-trash t);; Move files to trash when deleting
(setq global-auto-revert-non-file-buffers t)
(setq indent-tabs-mode nil)
(setq kill-whole-line t)
(setq kmacro-ring-max 16)
(setq mark-even-if-inactive t)
(setq next-line-add-newlines nil)
(setq redisplay-dont-pause t) ;; Redraw the entire screen before checking for pending input events.
(setq sentence-end-double-space nil)
(setq tab-always-indent t)
(setq transient-mark-mode t)
(setq undo-limit 1000000)
(setq user-full-name (capitalize global-username))
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))
;; don't let the cursor go into minibuffer prompt
(setq minibuffer-prompt-properties
      '(read-only t point-entered minibuffer-avoid-prompt face minibuffer-prompt))

(set-default 'indent-tabs-mode nil);; Never insert tabs
(setq-default fill-column 200)
(setq-default indicate-empty-lines t)
(setq-default save-place t)
(setq-default tab-width 4)
(setq-default transient-mark-mode t)
(setq-default truncate-lines t);; Don't break lines for me, please

(setq x-stretch-cursor t)
(setq blink-matching-paren nil)
(setq show-paren-delay 0)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
(setq mouse-wheel-progressive-speed nil)

(delete-selection-mode t)
(electric-indent-mode -1)
(global-auto-revert-mode 1);; Auto refresh buffers
(show-paren-mode t)
(transient-mark-mode 1)

(make-variable-buffer-local 'transient-mark-mode)
(put 'transient-mark-mode 'permanent-local t)

(define-coding-system-alias 'UTF-8 'utf-8)
(defalias 'man 'woman) ;'Woman' offers completion better than 'man'.

(use-package xclip
  :ensure t
  :config
  (xclip-mode 1))

(use-package dtrt-indent
  :ensure t
  :config
  (dtrt-indent-mode))

(use-package savekill
  :ensure t
  :config
  (setq save-kill-file-name (at-data-dir "/kill-ring-saved.el")))

(use-package drag-stuff
  :ensure t
  :defer t
  :config
  (progn
    (setq drag-stuff-modifier '(meta shift))
    (turn-off-drag-stuff-mode)
    ))

(use-package expand-region
  :ensure t
  :defer t
  :bind ("C-=" . er/expand-region))

(use-package undo-tree
  :defer t
  :ensure t
  :config
  (progn
    (global-undo-tree-mode t)
    (setq undo-tree-mode-lighter "")
    (setq undo-tree-visualizer-timestamps t)
    (setq undo-tree-visualizer-diff t)
    ))

(use-package recentf
  :defer t
  :init
  (use-package recentf-ext :ensure t)
  :config
  (progn
    (recentf-mode t) ;enable recent files mode.
    (setq recentf-max-saved-items 250)
    (setq recentf-max-menu-items 15)
    ;; get rid of `find-file-read-only' and replace it with something more useful.
    ))

(use-package multiple-cursors
  :ensure t
  :config
  (setq mc/list-file (at-data-dir "/.mc-lists.el")))

(use-package region-bindings-mode
  :ensure t
  :config
  (region-bindings-mode-enable)
  (setq region-bindings-mode-disable-predicates '((lambda () buffer-read-only)))
  (bind-key "M-<down>" 'mc/mark-next-like-this region-bindings-mode-map)
  (bind-key "M-<up>" 'mc/mark-previous-like-this region-bindings-mode-map)
  (bind-key "8" 'mc/mark-all-like-this region-bindings-mode-map)
  (bind-key "6" 'mc/edit-beginnings-of-lines region-bindings-mode-map)
  (bind-key "4" 'mc/edit-ends-of-lines region-bindings-mode-map)
  (bind-key "3" 'mc/mark-more-like-this-extended region-bindings-mode-map)
  (bind-key "5" 'mc/mark-all-in-region region-bindings-mode-map)
  (bind-key "9" 'mc/mark-all-like-this-in-defun region-bindings-mode-map)
  (bind-key "0" 'mc/mark-all-like-this-dwim region-bindings-mode-map)
  (bind-key "`" 'mc/sort-regions region-bindings-mode-map)
  (bind-key "1" 'mc/insert-numbers region-bindings-mode-map)
  (bind-key "<up>" 'mc/reverse-regions region-bindings-mode-map))

(use-package volatile-highlights
  :ensure t
  :config
  (volatile-highlights-mode t))

(use-package wc-mode :ensure t)

(use-package whole-line-or-region ;; if no region is active, act on current line
  :ensure t
  :defer t
  :config
  (progn
    (whole-line-or-region-mode 1)
    (setq whole-line-or-region-extensions-alist
          '((comment-dwim whole-line-or-region-comment-dwim-2 nil)
            (copy-region-as-kill whole-line-or-region-copy-region-as-kill nil)
            (kill-region whole-line-or-region-kill-region nil)
            (kill-ring-save whole-line-or-region-kill-ring-save nil)
            (yank whole-line-or-region-yank nil)
            ))))

(use-package comment-dwim-2
  :ensure t
  :config
  (global-set-key (kbd "M-]") 'comment-dwim-2))

(use-package generic
  :defer t
  :init
  (use-package generic-x)
  :config
  (progn
    (define-generic-mode 'keymap-mode
      '("#")
      '("control" "meta" "shift" "alt" "altgr" "compose" "keycode")
      nil
      '(".keymap\\'" ".map\\'")
      nil)
    (setq generic-default-modes (delete 'javascript-generic-mode
                                        generic-default-modes))))

(use-package yatemplate
  :init
  (auto-insert-mode)
  :config
  (setq yatemplate-dir (at-config-basedir "resources/auto-insert"))
  (yatemplate-fill-alist))

(use-package rebox2
  :ensure t
  ;;TODO: bind commands
  )

(use-package smartparens
  :ensure t
  :config
  (use-package smartparens-config)
  (smartparens-global-strict-mode t)
  (show-smartparens-global-mode t)
  (sp-use-smartparens-bindings)
  (define-key smartparens-mode-map (kbd "C-M-t") 'sp-transpose-sexp)
  (bind-key "M-F" nil smartparens-mode-map)
  (bind-key "M-B" nil smartparens-mode-map)
  (bind-key "M-<backspace>" nil smartparens-mode-map)
  (define-key sp-keymap (kbd "C-S-a") 'sp-beginning-of-sexp)
  (define-key sp-keymap (kbd "C-S-d") 'sp-end-of-sexp)
  (define-key emacs-lisp-mode-map (kbd ")") 'sp-up-sexp)
  (define-key sp-keymap (kbd "C-<left_bracket>") 'sp-select-previous-thing)
  (define-key sp-keymap (kbd "C-c s r n") 'sp-narrow-to-sexp)
  (define-key sp-keymap (kbd "C-c s t") 'sp-prefix-tag-object)
  (define-key sp-keymap (kbd "C-c s p") 'sp-prefix-pair-object)
  (define-key sp-keymap (kbd "C-c s y") 'sp-prefix-symbol-object)
  (define-key sp-keymap (kbd "C-c s c") 'sp-convolute-sexp)
  (define-key sp-keymap (kbd "C-c s a") 'sp-absorb-sexp)
  (define-key sp-keymap (kbd "C-c s w") 'sp-rewrap-sexp)
  (define-key sp-keymap (kbd "C-c s e") 'sp-emit-sexp)
  (define-key sp-keymap (kbd "C-c s p") 'sp-add-to-previous-sexp)
  (define-key sp-keymap (kbd "C-c s n") 'sp-add-to-next-sexp)
  (define-key sp-keymap (kbd "C-c s j") 'sp-join-sexp)
  (define-key sp-keymap (kbd "C-c s s") 'sp-split-sexp))

(use-package vimrc-mode
  :ensure t
  :defer t
  :mode ".vim\\(rc\\)?$")

(use-package whitespace
  :defer t)

(use-package wrap-region
  :ensure t
  :config
  (progn
    (wrap-region-global-mode 1)
    (wrap-region-add-wrapper "*" "*")
    (wrap-region-add-wrapper "(" ")")
    (wrap-region-add-wrapper "{-" "-}" "#")
    (wrap-region-add-wrapper "/* " " */" "#" '(javascript-mode css-mode))))

(use-package mark
  :ensure t
  :config
  (defhydra hydra-mark ()
    ("<right>" forward-mark "forward-mark")
    ("<left>" backward-mark "backward-mark")
    ("<down>" show-marks "show-marks"))
  (global-set-key (kbd "<f12>") 'hydra-mark/body))

(use-package page-break-lines
  :ensure t
  :config
  (turn-on-page-break-lines-mode))

;; (use-package macro-math
;;   :config
;;   (global-set-key "\C-x~" 'macro-math-eval-and-round-region)
;;   (global-set-key "\C-x=" 'macro-math-eval-region))

(use-package miniedit
  :defer t
  :ensure t
  :commands minibuffer-edit
  :init (miniedit-install))

(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)
(add-hook 'text-mode-hook 'turn-on-auto-fill)
(add-hook 'text-mode-hook 'text-mode-hook-identify)

;; Transpose stuff with M-t
(global-unset-key (kbd "M-t")) ;; which used to be transpose-words
;;TODO: plan docstring
(defhydra hydra-transpose ()
  ("M-b" backward-word "prev word")
  ("M-f" forward-word "next word")
  ("<up>" previous-line "prev line")
  ("<down>" next-line "next line")
  ("<left>" backward-char "prev char")
  ("<right>" forward-char "next char")
  ("_" undo-tree-undo "undo last")
  ("w" custom/transpose-words "on words")
  ("s" transpose-sexps "on sexps")
  ("p" transpose-params "on params")
  ("a" anchored-transpose "anchored")
  ("q" nil "cancel"))
(global-set-key (kbd "M-t") 'hydra-transpose/body)

;;TODO: plan docstring
(defhydra hydra-edit (:color blue)
  ("0" custom/compact-spaces-in-region)
  ("2" custom/duplicate-and-comment-line)
  ("4" snakehump-next-at-point)
  ("<left>" jump-char-backward)
  ("<right>" jump-char-forward)
  ("C-SPC" comment-dwim)
  ("C-r" custom/join-region)
  ("M-a" indent-region)
  ("SPC" untabify)
  ("TAB" tabify)
  ("[" comment-region)
  ("]" uncomment-region)
  ("`" redraw-display)
  ("b" subword-mode)
  ("c" wc-mode)
  ("d" diff-buffer-with-file)
  ("f" custom/copy-file-name-to-clipboard)
  ("i" custom/insert-current-date-time)
  ("o" just-one-space)
  ("p" whitespace-mode)
  ("r" query-replace)
  ("n" custom/rename-file-and-buffer)
  ("s" sort-lines)
  ("t" delete-trailing-whitespace)
  ("u" delete-duplicate-lines)
  ("v" view-mode)
  ("x" query-replace-regexp)
  ("a" custom/append-cited-region)
  ("g" insert-register)
  ("e" copy-to-register)
  ("m" rename-uniquely)
  ("S" scratch)
  ("y" revbufs)
  ("k" custom/kill-save-rectangle)
  ("/" comment-box)
  ("w" wrap-to-fill-column-mode)
  ("=" edit-indirect-region)
  ("q" nil "cancel"))
(global-set-key (kbd "C-z") 'hydra-edit/body)

(defhydra hydra-toggle (:color blue)
  "
TOGGLE: de_b_ug on error (%(format \"%S\" debug-on-error))
        _d_ / _D_ toggle drag-stuff mode on/off (%(format \"%S\" drag-stuff-mode))
        _w_hitespace mode
"
  ("b" toggle-debug-on-error "debug on error")
  ("w" whitespace-mode "whitespace mode")
  ("d" turn-on-drag-stuff-mode "enable drag-stuff mode")
  ("D" turn-off-drag-stuff-mode "disable drag-stuff mode")
  ("h" highlight-sexp-mode "toggle highlight-sexp mode"))
(global-set-key (kbd "<f11>") 'hydra-toggle/body)

(defhydra hydra-cases (:color pink)
  "
_d_ / _d_ downcase word/region
_u_ / _u_ upcase word/region
_I_       capitalize region
"
  ("d" downcase-word)
  ("d" downcase-region :color blue)
  ("u" upcase-word)
  ("u" upcase-region :color blue)
  ("I" upcase-initials-region :color blue))
(global-set-key (kbd "<f10>") 'hydra-cases/body)

(global-set-key (kbd "M-g") 'goto-line)
(global-set-key (kbd "M-\"") 'eval-region)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-$") 'mf/mirror-region-in-multifile)
;; (global-set-key "\C-x\ f" 'find-file) ; I never use set-fill-column and I hate hitting it by accident.
(global-set-key [remap move-beginning-of-line] 'custom/smarter-move-beginning-of-line)
(global-set-key (kbd "M-SPC") 'cycle-spacing) ;; TODO: maybe place into some hydra
(global-set-key (kbd "C-c r p") '(lambda () ;;TODO: make hydra for such custom helm sources
                                   (interactive)
                                   (helm :sources '(custom/helm-source-portage-files))))

(setq whitespace-style '(indentation::space
                         space-after-tab
                         space-before-tab
                         trailing
                         lines-tail
                         tab-mark
                         face
                         tabs))

(provide 'rc-editing)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-editing.el ends here
