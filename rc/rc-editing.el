;;; emacs-rc-editing.el --- Editing settings

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

;#############################################################################
;#   Load extensions
;############################################################################
(require 'cua-base)
(require 'cursor-chg)
(require 'drag-stuff)
(require 'expand-region)
(require 'hideshow) ;; Hide/Show mode
(require 'multiple-cursors)
(require 'recentf)
(require 'recentf-ext)
(require 'region-bindings-mode)
(require 'rst)
(require 'savekill)
(require 'saveplace)
(require 'table) ;; table
(require 'unicad)
(require 'volatile-highlights)
(require 'wc-mode)
(require 'whole-line-or-region) ;; if no region is active, act on current line
(require 'generic)
(require 'generic-x)
(require 'rebox2)
(require 'file-template)

;#############################################################################
;#   Customizations
;############################################################################
(delete-selection-mode t)
(volatile-highlights-mode t)
(show-paren-mode t)
(whole-line-or-region-mode 1)
(toggle-cursor-type-when-idle 1)
(change-cursor-mode 1)
(electric-indent-mode -1)
(dtrt-indent-mode)

(with-eval-after-load "undo-tree"
  (global-undo-tree-mode t))

(wrap-region-global-mode 1)
(wrap-region-add-wrapper "*" "*")
(wrap-region-add-wrapper "(" ")")
(wrap-region-add-wrapper "{-" "-}" "#")
(wrap-region-add-wrapper "/* " " */" "#" '(javascript-mode css-mode))

(turn-off-drag-stuff-mode)

(region-bindings-mode-enable)

(setq whitespace-modes 'awk-mode)
(setq-default fill-column 200)
(setq indent-tabs-mode nil)
(setq comment-style 'indent)
(setq user-full-name (capitalize global-username))
(setq kill-whole-line t)
(setq next-line-add-newlines nil)
(setq tab-always-indent t)
(setq tab-width 4)
(setq transient-mark-mode t)
(setq whitespace-global-mode nil)
(setq whitespace-silent t)
(setq sentence-end-double-space nil)
(setq undo-limit 1000000)
(setq delete-by-moving-to-trash t);; Move files to trash when deleting
(setq-default truncate-lines t);; Don't break lines for me, please
(setq mark-even-if-inactive t)
(setq kmacro-ring-max 16)

(setq x-select-enable-clipboard t);; Allow pasting selection outside of Emacs
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))

(define-coding-system-alias 'UTF-8 'utf-8)

;; enable recent files mode.
(recentf-mode t)

(setq recentf-max-saved-items 250)
(setq recentf-max-menu-items 15)

;; Redraw the entire screen before checking for pending input events.
;; This will improve performance in general but might degrade performance of
;; key repeat.
(setq redisplay-dont-pause t)

(setq-default save-place t)
(setq default-input-method 'russian-computer)
(setq-default indicate-empty-lines t)
(set-default 'indent-tabs-mode nil);; Never insert tabs

(setq regex-tool-backend 'perl)

(setq text-mode-hook '(turn-on-auto-fill text-mode-hook-identify))

(setq fci-rule-color "#111122")

(setq undo-tree-mode-lighter "");; Represent undo-history as an actual tree (visualize with C-x u)

;; Show active region
(transient-mark-mode 1)
(make-variable-buffer-local 'transient-mark-mode)
(put 'transient-mark-mode 'permanent-local t)
(setq-default transient-mark-mode t)

;; If something updates under us and we haven't changed the buffer
;; ourselves, reload without asking. Handy for git.
(global-auto-revert-mode 1);; Auto refresh buffers
;; Also auto refresh dired, but be quiet about it
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)

(setq whole-line-or-region-extensions-alist
  '((comment-dwim whole-line-or-region-comment-dwim-2 nil)
    (copy-region-as-kill whole-line-or-region-copy-region-as-kill nil)
    (kill-region whole-line-or-region-kill-region nil)
    (kill-ring-save whole-line-or-region-kill-ring-save nil)
    (yank whole-line-or-region-yank nil)
  ))

(setq browse-kill-ring-quit-action 'save-and-restore)

(setq file-template-paths `(,(concat config-basedir "resources/auto-insert"))) ;TODO: move to constants
(setq file-template-mapping-alist
      '(("\\.el$" . "template.el")
        ("\\.py$" . "template.py")
        ("\\.sh$" . "template.sh")
        ))
(setq file-template-insert-automatically t)
(push '("F" . (file-name-base (buffer-file-name))) file-template-tag-alist)
(push '("D" . (current-time-string)) file-template-tag-alist)
(add-hook 'find-file-not-found-hooks 'file-template-find-file-not-found-hook)

(defalias 'man 'woman) ;'Woman' offers completion better than 'man'.

(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

(with-eval-after-load "paredit"
  (define-key paredit-mode-map (kbd "M-s") nil)
  (define-key paredit-mode-map (kbd "M-<up>") nil)
  (define-key paredit-mode-map (kbd "M-<down>") nil)
  (define-key paredit-mode-map (kbd "C-<up>") nil)
  (define-key paredit-mode-map (kbd "C-<down>") nil)
  (define-key paredit-mode-map (kbd "C-M-s") 'paredit-splice-sexp)
  (paredit-everywhere-mode 1))

(with-eval-after-load "list-register"
  (global-set-key (kbd "C-x r v") 'list-register))

(use-package vimrc-mode
             :mode ".vim\\(rc\\)?$")

(define-generic-mode 'keymap-mode
  '("#")
  '("control" "meta" "shift" "alt" "altgr" "compose" "keycode")
  nil
  '(".keymap\\'" ".map\\'")
  nil)

(setq generic-default-modes (delete 'javascript-generic-mode
                                    generic-default-modes))


;#############################################################################
;#   Keybindings
;############################################################################
(define-key custom-edit-keymap (kbd "i") 'insert-current-date-time)
(define-key custom-edit-keymap (kbd "d") 'diff-buffer-with-file)
(define-key custom-edit-keymap (kbd "q") 'query-replace)
(define-key custom-edit-keymap (kbd "x") 'query-replace-regexp)
(define-key custom-edit-keymap (kbd "u") 'uniq)
(define-key custom-edit-keymap (kbd "s") 'sort-lines)
(define-key custom-edit-keymap [tab] 'tabify)
(define-key custom-edit-keymap (kbd "SPC") 'untabify)
(define-key custom-edit-keymap (kbd "n") 'narrow-to-region)
(define-key custom-edit-keymap (kbd "w") 'widen)
(define-key custom-edit-keymap (kbd "p") 'whitespace-mode)
(define-key custom-edit-keymap (kbd "t") 'delete-trailing-whitespace)
(define-key custom-edit-keymap (kbd "M-a") 'indent-region)
(define-key custom-edit-keymap (kbd "C-SPC") 'comment-dwim)
(define-key custom-edit-keymap (kbd "v") 'view-mode)
(define-key custom-edit-keymap (kbd "4") 'camelscore-word-at-point)
(define-key custom-edit-keymap (kbd "9") 'quote-string-with-period-and-nextline)
(define-key custom-edit-keymap (kbd "S-9") 'double-quote-string-with-period-and-nextline)
(define-key custom-edit-keymap (kbd "<left>") 'previous-error)
(define-key custom-edit-keymap (kbd "<right>") 'next-error)
(define-key custom-edit-keymap (kbd "<up>") 'move-line-up)
(define-key custom-edit-keymap (kbd "<down>") 'move-line-down)
(define-key custom-edit-keymap (kbd "[") 'comment-region)
(define-key custom-edit-keymap (kbd "]") 'uncomment-region)
(define-key custom-edit-keymap (kbd "<left>") 'jump-char-backward)
(define-key custom-edit-keymap (kbd "<right>") 'jump-char-forward)
(define-key custom-edit-keymap (kbd "C-SPC") 'join-next-line-space-n)
(define-key custom-edit-keymap (kbd "J") 'join-next-line-n)
(define-key custom-edit-keymap (kbd "C-;") 'join-next-line-semicolon-n)
(define-key custom-edit-keymap (kbd "C-r") 'join-region)
(define-key custom-edit-keymap (kbd "b") 'subword-mode)
(define-key custom-edit-keymap (kbd "c") 'wc-mode)
(define-key custom-edit-keymap (kbd "o") 'just-one-space)
(define-key custom-edit-keymap (kbd "0") 'compact-spaces-in-region)
(define-key custom-edit-keymap (kbd "f") 'copy-file-name-to-clipboard)
(define-key custom-edit-keymap (kbd "r") 'rename-file-and-buffer)
(define-key custom-edit-keymap (kbd "2") 'duplicate-line)
(define-key custom-edit-keymap (kbd "h") 'smart-backward)
(define-key custom-edit-keymap (kbd "j") 'smart-down)
(define-key custom-edit-keymap (kbd "k") 'smart-up)
(define-key custom-edit-keymap (kbd "l") 'smart-forward)

(global-set-key (kbd "C-x g") 'insert-register)
(global-set-key (kbd "C-x x") 'copy-to-register)
(global-set-key (kbd "C-c h m") 'woman)
(global-set-key (kbd "M-g") 'goto-line)
(global-set-key (kbd "M-]") 'custom/comment-or-uncomment-region)
(global-set-key (kbd "C-c C-u C-r") 'rename-uniquely)

(global-set-key (kbd "M-\"") 'eval-region)

;I never use set-fill-column and I hate hitting it by accident.
(global-set-key "\C-x\ f" 'find-file)
(global-set-key (kbd "C-x r M-k") 'kill-save-rectangle) ;; Give it a memorable key binding

;; Transpose stuff with M-t
(global-unset-key (kbd "M-t")) ;; which used to be transpose-words
(global-set-key (kbd "M-t l") 'transpose-lines)
(global-set-key (kbd "M-t w") 'transpose-words)
(global-set-key (kbd "M-t s") 'transpose-sexps)
(global-set-key (kbd "M-t p") 'transpose-params)

(global-set-key (kbd "C-c n") 'scratch)
(global-set-key (kbd "C-c y") 'revbufs)

(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-=") 'er/expand-region)

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)

(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-*") 'mc/mark-all-like-this)

(global-set-key (kbd "C-^") 'mc/edit-beginnings-of-lines)
(global-set-key (kbd "C-$") 'mc/edit-ends-of-lines)

(global-set-key (kbd "C-#") 'mc/mark-more-like-this-extended)
(global-set-key (kbd "C-%") 'mc/mark-all-in-region)
(global-set-key (kbd "C-(") 'mc/mark-all-like-this-in-defun)
(global-set-key (kbd "C-)") 'mc/mark-all-like-this-dwim)

(global-set-key (kbd "C-~") 'mc/sort-regions)
(global-set-key (kbd "C-!") 'mc/insert-numbers)
(global-set-key (kbd "C-|") 'mc/reverse-regions)

(global-set-key (kbd "C-c i c") 'minimap-create)
(global-set-key (kbd "C-c i k") 'minimap-kill)

(global-set-key (kbd "C-c d e") 'turn-on-drag-stuff-mode)
(global-set-key (kbd "C-c d d") 'turn-off-drag-stuff-mode)

(global-set-key (kbd "C-`") 'mf/mirror-region-in-multifile)

;; key definition example
;; (define-key region-bindings-mode-map "a" 'mc/mark-all-like-this)

;; get rid of `find-file-read-only' and replace it with something
;; more useful.
(global-set-key (kbd "C-x C-r") 'ido-recentf-open)

;; remap C-a to `smarter-move-beginning-of-line'
(global-set-key [remap move-beginning-of-line]
                'smarter-move-beginning-of-line)

(global-set-key (kbd "C-c r c") (lambda () (interactive) (sudo-find-file "/etc/portage/make.conf")))
(global-set-key (kbd "C-c r m") (lambda () (interactive) (sudo-find-file "/etc/portage/package.mask/main")))
(global-set-key (kbd "C-c r M") (lambda () (interactive) (sudo-find-file "/etc/portage/package.unmask")))
(global-set-key (kbd "C-c r u") (lambda () (interactive) (sudo-find-file "/etc/portage/package.use")))
(global-set-key (kbd "C-c r l") (lambda () (interactive) (sudo-find-file "/etc/portage/package.license")))
(global-set-key (kbd "C-c r k") (lambda () (interactive) (sudo-find-file "/etc/portage/package.keywords")))
(global-set-key (kbd "C-c r a") (lambda () (interactive) (sudo-find-file "/etc/portage/package.accept_keywords")))

(global-set-key (kbd "M-q") 'rebox-dwim)
(global-set-key (kbd "S-M-q") 'rebox-cycle)

(provide 'rc-editing)

;;; emacs-rc-editing.el ends here
