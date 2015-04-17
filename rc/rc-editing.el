;; -*- coding: utf-8 -*-
;;
;; Filename: rc-editing.el
;; Created:  Fri May 24 22:41:54 2013 +0400
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(autoload 'footnote-mode "footnote" nil t) ;; footnote mode

(require 'rst)
(require 'savekill)
(require 'saveplace)
(require 'table) ;; table

(delete-selection-mode t)
(dtrt-indent-mode)
(electric-indent-mode -1)
(global-auto-revert-mode 1);; Auto refresh buffers
(show-paren-mode t)
(toggle-cursor-type-when-idle 1)
(transient-mark-mode 1)

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
(setq x-select-enable-clipboard t);; Allow pasting selection outside of Emacs
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

(make-variable-buffer-local 'transient-mark-mode)
(put 'transient-mark-mode 'permanent-local t)

(define-coding-system-alias 'UTF-8 'utf-8)
(defalias 'man 'woman) ;'Woman' offers completion better than 'man'.

(use-package drag-stuff
  :defer t
  :bind
  (("C-c d e" . turn-on-drag-stuff-mode)
   ("C-c d d" . turn-off-drag-stuff-mode))
  :config
  (progn
    (turn-off-drag-stuff-mode)
    ))

(use-package expand-region
  :defer t
  :bind ("C-=" . er/expand-region))

(use-package undo-tree
  :config
  (progn
    (global-undo-tree-mode t)
    (setq undo-tree-mode-lighter "")))

(use-package recentf
  :defer t
  :init
  (use-package recentf-ext)
  :config
  (progn
    (recentf-mode t) ;enable recent files mode.
    (setq recentf-max-saved-items 250)
    (setq recentf-max-menu-items 15)
    ;; get rid of `find-file-read-only' and replace it with something more useful.
    (global-set-key (kbd "C-x C-r") 'helm-recentf)))

(use-package region-bindings-mode
  :config
  (region-bindings-mode-enable)
  (setq region-bindings-mode-disable-predicates '((lambda () buffer-read-only)))
  (bind-key "C-<down>" 'mc/mark-next-like-this region-bindings-mode-map)
  (bind-key "C-<up>" 'mc/mark-previous-like-this region-bindings-mode-map)
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
  :config
  (volatile-highlights-mode t)
  (diminish 'volatile-highlights-mode))

(use-package wc-mode
  :config
  (bind-key "c" 'wc-mode custom-edit-keymap))

(use-package whole-line-or-region ;; if no region is active, act on current line
  :defer t
  :config
  (progn
    (whole-line-or-region-mode 1)
    (diminish 'whole-line-or-region-mode)
    (setq whole-line-or-region-extensions-alist
          '((comment-dwim whole-line-or-region-comment-dwim-2 nil)
            (copy-region-as-kill whole-line-or-region-copy-region-as-kill nil)
            (kill-region whole-line-or-region-kill-region nil)
            (kill-ring-save whole-line-or-region-kill-ring-save nil)
            (yank whole-line-or-region-yank nil)
            ))))

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

(use-package file-template
  :config
  (progn
    (setq file-template-paths `(,(concat config-basedir "resources/auto-insert"))) ;TODO: move to constants
    (setq file-template-mapping-alist
          '(("\\.el$" . "template.el")
            ("\\.py$" . "template.py")
            ("\\.sh$" . "template.sh")
            ("\\.org$" . "template.org")
            ))
    (setq file-template-insert-automatically t)
    (push '("F" . (file-name-base (buffer-file-name))) file-template-tag-alist)
    (push '("D" . (current-time-string)) file-template-tag-alist)
    (add-hook 'find-file-not-found-hooks 'file-template-find-file-not-found-hook)))

(use-package rebox2
  :bind (("M-q" . rebox-dwim)
         ("S-M-q" . rebox-cycle)))

(use-package paredit
  :defer t
  :config
  (progn
    (bind-key "M-s" nil paredit-mode-map)
    (bind-key "M-<up>" nil paredit-mode-map)
    (bind-key "M-<down>" nil paredit-mode-map)
    (bind-key "C-<up>" nil paredit-mode-map)
    (bind-key "C-<down>" nil paredit-mode-map)
    (bind-key "C-M-s" 'paredit-splice-sexp paredit-mode-map)
    (paredit-everywhere-mode 1)
    ))

(use-package vimrc-mode
  :defer t
  :mode ".vim\\(rc\\)?$")

(use-package whitespace
  :defer t
  :config
  (progn
    (bind-key "p" 'whitespace-mode custom-edit-keymap)
    (bind-key "t" 'delete-trailing-whitespace custom-edit-keymap)))

(use-package wrap-region
  :config
  (progn
    (wrap-region-global-mode 1)
    (wrap-region-add-wrapper "*" "*")
    (wrap-region-add-wrapper "(" ")")
    (wrap-region-add-wrapper "{-" "-}" "#")
    (wrap-region-add-wrapper "/* " " */" "#" '(javascript-mode css-mode))))

(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)
(add-hook 'text-mode-hook 'turn-on-auto-fill)
(add-hook 'text-mode-hook 'text-mode-hook-identify)

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

(defhydra hydra-jabber-insert (global-map "<f6>")
  ("8" custom-jabber/insert-kiss-smile ":-*")
  ("l" custom-jabber/insert-inlove-smile "*IN LOVE*")
  ("y" custom-jabber/insert-shy-smile ":-[")
  ("t" custom-jabber/insert-copyright-sign "(c)*")
  ;TODO: move other insertions here, for example, current time, etc.
  ("q" nil "cancel"))

(define-key custom-edit-keymap (kbd "i") 'insert-current-date-time)
(define-key custom-edit-keymap (kbd "d") 'diff-buffer-with-file)
(define-key custom-edit-keymap (kbd "q") 'query-replace)
(define-key custom-edit-keymap (kbd "x") 'query-replace-regexp)
(define-key custom-edit-keymap (kbd "u") 'uniq)
(define-key custom-edit-keymap (kbd "s") 'sort-lines)
(define-key custom-edit-keymap [tab] 'tabify)
(define-key custom-edit-keymap (kbd "SPC") 'untabify)
(define-key custom-edit-keymap (kbd "M-a") 'indent-region)
(define-key custom-edit-keymap (kbd "C-SPC") 'comment-dwim)
(define-key custom-edit-keymap (kbd "v") 'view-mode)
(define-key custom-edit-keymap (kbd "4") 'camelscore-word-at-point)
(define-key custom-edit-keymap (kbd "9") 'quote-string-with-period-and-nextline)
(define-key custom-edit-keymap (kbd "S-9") 'double-quote-string-with-period-and-nextline)
(define-key custom-edit-keymap (kbd "[") 'comment-region)
(define-key custom-edit-keymap (kbd "]") 'uncomment-region)
(define-key custom-edit-keymap (kbd "<left>") 'jump-char-backward)
(define-key custom-edit-keymap (kbd "<right>") 'jump-char-forward)
(define-key custom-edit-keymap (kbd "C-SPC") 'join-next-line-space-n)
(define-key custom-edit-keymap (kbd "J") 'join-next-line-n)
(define-key custom-edit-keymap (kbd "C-;") 'join-next-line-semicolon-n)
(define-key custom-edit-keymap (kbd "C-r") 'join-region)
(define-key custom-edit-keymap (kbd "b") 'subword-mode)
(define-key custom-edit-keymap (kbd "o") 'just-one-space)
(define-key custom-edit-keymap (kbd "0") 'compact-spaces-in-region)
(define-key custom-edit-keymap (kbd "f") 'copy-file-name-to-clipboard)
(define-key custom-edit-keymap (kbd "r") 'rename-file-and-buffer)
(define-key custom-edit-keymap (kbd "2") 'duplicate-line)
(define-key custom-edit-keymap (kbd "`") 'redraw-display)

(global-set-key (kbd "C-x g") 'insert-register)
(global-set-key (kbd "C-x x") 'copy-to-register)
(global-set-key (kbd "C-c h m") 'helm-man-woman)
(global-set-key (kbd "M-g") 'goto-line)
(global-set-key (kbd "M-]") 'custom/comment-or-uncomment-region)
(global-set-key (kbd "C-c C-u C-r") 'rename-uniquely)

(global-set-key (kbd "M-\"") 'eval-region)

;I never use set-fill-column and I hate hitting it by accident.
(global-set-key "\C-x\ f" 'find-file)
(global-set-key (kbd "C-x r M-k") 'kill-save-rectangle) ;; Give it a memorable key binding

(global-set-key (kbd "C-c n") 'scratch)
(global-set-key (kbd "C-c y") 'revbufs)

(global-set-key (kbd "M-y") 'helm-show-kill-ring)

(global-set-key (kbd "C-c i c") 'minimap-create)
(global-set-key (kbd "C-c i k") 'minimap-kill)

(global-set-key (kbd "C-`") 'mf/mirror-region-in-multifile)

;; key definition example
;; (define-key region-bindings-mode-map "a" 'mc/mark-all-like-this)

;; remap C-a to `smarter-move-beginning-of-line'
(global-set-key [remap move-beginning-of-line]
                'smarter-move-beginning-of-line)

(global-set-key (kbd "C-c r p") '(lambda ()
                                   (interactive)
                                   (helm :sources '(custom/helm-source-portage-files))))

(provide 'rc-editing)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-editing.el ends here
