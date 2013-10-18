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
(require 'table) ;; table
(require 'hideshow) ;; Hide/Show mode
(require 'undo-tree)
(require 'saveplace)
(require 'saveplace)
(require 'point-stack)
(require 'rst)
(require 'savekill)
(require 'volatile-highlights)
(require 'whole-line-or-region) ;; if no region is active, act on current line
(require 'highlight-symbol)

(require 'cua-base)
(require 'wc-mode)
(require 'cursor-chg)

(require 'iedit)
(require 'jump-char)

(require 'defun-editing)
(require 'defun-camelscore)
(require 'defun-joinlines)


;#############################################################################
;#   Customizations
;############################################################################
(global-undo-tree-mode t)
(delete-selection-mode t)
(volatile-highlights-mode t)
(show-paren-mode t)
;; (electric-indent-mode 1)
(whole-line-or-region-mode 1)
(toggle-cursor-type-when-idle 1)
(change-cursor-mode 1)

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

(setq x-select-enable-clipboard t);; Allow pasting selection outside of Emacs
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))
;; (setq interprogram-paste-function (quote x-cut-buffer-or-selection-value))

(define-coding-system-alias 'UTF-8 'utf-8)

;; Redraw the entire screen before checking for pending input events.
;; This will improve performance in general but might degrade performance of
;; key repeat.
(setq redisplay-dont-pause t)

(setq-default save-place t)
(setq default-input-method 'russian-computer)
(setq-default indicate-empty-lines t)
(set-default 'indent-tabs-mode nil);; Never insert tabs

(setq regex-tool-backend 'perl)

(setq text-mode-hook (quote (turn-on-auto-fill text-mode-hook-identify)))

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

(defadvice whole-line-or-region-kill-region
               (before whole-line-or-region-kill-read-only-ok activate)
      (interactive "p")
      (unless kill-read-only-ok (barf-if-buffer-read-only)))

;; When popping the mark, continue popping until the cursor actually moves
;; Also, if the last command was a copy - skip past all the expand-region cruft.
(defadvice pop-to-mark-command (around ensure-new-position activate)
  (let ((p (point)))
    (when (eq last-command 'save-region-or-current-line)
      ad-do-it
      ad-do-it
      ad-do-it)
    (dotimes (i 10)
      (when (= p (point)) ad-do-it))))

(defalias 'man 'woman) ;'Woman' offers completion better than 'man'.

(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)
;; (add-hook 'minibuffer-setup-hook 'conditionally-enable-parens-mode)

;; key bindings
(when (eq system-type 'darwin) ;; mac specific settings
  (cua-mode t)
  (setq mac-option-key-is-meta t)
  (setq mac-command-key-is-meta nil)
  ;; (setq mac-control-key-is-meta nil)
  (setq process-connection-type nil)
  (setq mac-command-modifier 'hyper)    ;meta|super
  (setq mac-pass-command-to-system nil)   ;;avoid hiding with M-h
  (global-set-key [(hyper x)] 'cua-cut-region)
  (global-set-key [(hyper c)] 'cua-copy-region)
  (global-set-key [(hyper v)] 'cua-paste)
  (global-set-key [kp-delete] 'delete-char) ;; sets fn-delete to be right-delete
  (setq mac-control-modifier 'control)
  ;; change command to meta, and ignore option to use weird Norwegian keyboard
  ;; (setq mac-option-modifier 'none)
  ;; (setq mac-command-modifier 'meta)
  ;; (setq ns-function-modifier 'hyper)
  )
(when (eq system-type 'gnu/linux)
  (setq x-alt-keysym 'meta))

;#############################################################################
;#   Keybindings
;############################################################################
(global-unset-key (kbd "C-z"))
(define-prefix-command 'custom-edit-keymap)
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
(define-key custom-edit-keymap (kbd "j") 'join-next-line-n)
(define-key custom-edit-keymap (kbd "C-;") 'join-next-line-semicolon-n)
(define-key custom-edit-keymap (kbd "C-r") 'join-region)
(define-key custom-edit-keymap (kbd "b") 'subword-mode)
(define-key custom-edit-keymap (kbd "c") 'wc-mode)
(define-key custom-edit-keymap (kbd "o") 'just-one-space)
(define-key custom-edit-keymap (kbd "0") 'compact-spaces-in-region)
(define-key custom-edit-keymap (kbd "f") 'copy-file-name-to-clipboard)
(define-key custom-edit-keymap (kbd "r") 'rename-file-and-buffer)
(global-set-key (kbd "C-z") 'custom-edit-keymap)

(global-set-key (kbd "M-<up>") 'smart-symbol-go-backward)
(global-set-key (kbd "M-<down>") 'smart-symbol-go-forward)

(global-set-key (kbd "C-x g") 'insert-register)
(global-set-key (kbd "C-x x") 'copy-to-register)
(global-set-key (kbd "C-c h m") 'woman)
(global-set-key (kbd "M-g") 'goto-line)
(global-set-key (kbd "M-]") 'custom/comment-or-uncomment-region)
(global-set-key (kbd "C-c C-u C-r") 'rename-uniquely)

(global-set-key (kbd "C-;") 'iedit-mode)

(global-set-key (kbd "<f6>") 'point-stack-push)
(global-set-key (kbd "<f7>") 'point-stack-pop)
(global-set-key (kbd "<f8>") 'point-stack-forward-stack-pop)
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

;; (global-set-key (kbd "C-p") 'go-back)
;; (global-set-key (kbd "<up>") 'go-back)

(global-set-key (kbd "C-c n") 'spawn-buffer)

;; remap C-a to `smarter-move-beginning-of-line'
(global-set-key [remap move-beginning-of-line]
                'smarter-move-beginning-of-line)


(provide 'rc-editing)

;;; emacs-rc-editing.el ends here
