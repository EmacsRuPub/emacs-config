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
;; (require 'drag-stuff)
(require 'saveplace)
(require 'minimap)
(require 'camelCase)
(require 'saveplace)
(require 'uniquify)
(require 'point-stack)
(require 'auto-complete)
(require 'rst)
(require 'savekill)

(autoload 'paredit-mode "paredit" "Minor mode for pseudo-structurally editing Lisp code." t)
;; (add-hook 'emacs-lisp-mode-hook       (lambda () (paredit-mode +1)))
;; (add-hook 'lisp-mode-hook             (lambda () (paredit-mode +1)))
;; (add-hook 'lisp-interaction-mode-hook (lambda () (paredit-mode +1)))


;#############################################################################
;#   Customizations
;############################################################################
(put 'upcase-region 'disabled nil)

(global-undo-tree-mode)
(auto-compression-mode t)
(delete-selection-mode t)
(show-paren-mode t)
(global-hl-line-mode 1)
;; (pc-selection-mode nil nil (pc-select))
;;(drag-stuff-global-mode t)
(mouse-avoidance-mode 'banish)
(global-auto-complete-mode t)

(defvar custom-programming-brackets-syntax-table
  (let ((table (make-syntax-table)))
    (modify-syntax-entry ?) "w" table)
    (modify-syntax-entry ?] "w" table)
    table))
;; TODO it fails to indent correctly. try to work it around by 'with'
;; when selecting region
;; (add-hook 'python-mode-hook (lambda () (set-syntax-table custom-programming-brackets-syntax-table)))
;; (add-hook 'php-mode-hook (lambda () (set-syntax-table custom-programming-brackets-syntax-table)))

(setq whitespace-modes (quote (awk-mode)))
(setq interprogram-paste-function (quote x-cut-buffer-or-selection-value))
(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator "/")
(setq uniquify-after-kill-buffer-p t) ; rename after killing uniquified
(setq uniquify-ignore-buffers-re "^\\*") ; don't muck with special buffers
(setq fill-column 120)
(setq indent-tabs-mode nil)
(setq text-mode-hook (quote (turn-on-auto-fill text-mode-hook-identify)))
(setq comment-style 'indent)
(setq user-full-name "Octocat")
(setq kill-whole-line t)
(setq next-line-add-newlines nil)
(setq tab-always-indent t)
(setq tab-width 4)
(setq transient-mark-mode t)
(setq x-select-enable-clipboard t)
(setq use-dialog-box nil)
(setq whitespace-global-mode nil)
(setq whitespace-silent t)
(defvar user-temporary-file-directory (expand-file-name "~/autosave/"))
;; (setq x-select-request-type (quote (UTF8_STRING COMPOUND_TEXT TEXT STRING)))
;; (setq save-place-file "~/.emacs.d/saveplace")
(setq-default save-place t)
(setq default-input-method 'russian-computer)
(setq show-paren-style 'mixed)
;; key bindings
(when (eq system-type 'darwin) ;; mac specific settings
  (setq mac-option-key-is-meta t)
  (setq mac-command-key-is-meta nil)
  (setq mac-command-modifier 'control)
  (global-set-key [kp-delete] 'delete-char) ;; sets fn-delete to be right-delete
  )

;#############################################################################
;#   Keybindings
;############################################################################
(global-set-key (kbd "C-c e c") 'insert-current-date-time)
(global-set-key (kbd "C-c e d") 'diff-buffer-with-file)
(global-set-key (kbd "C-c e q") 'query-replace)
(global-set-key (kbd "C-c e u") 'uniq)
(global-set-key (kbd "C-c e s") 'sort-lines)
(global-set-key (kbd "C-c e t") 'tabify)
(global-set-key (kbd "C-c e y") 'untabify)
(global-set-key (kbd "C-c e n") 'narrow-to-region)
(global-set-key (kbd "C-c e w") 'widen)
(global-set-key (kbd "C-c w e") 'whitespace-mode)
(global-set-key (kbd "C-c w d") 'delete-trailing-whitespace)
(global-set-key (kbd "C-x M-a") 'indent-region)
(global-set-key (kbd "C-x g") 'insert-register)
(global-set-key (kbd "C-x x") 'copy-to-register)
(global-set-key (kbd "%") 'match-paren)
(global-set-key (kbd "C-c h m") 'woman)
(global-set-key (kbd "M-g") 'goto-line)
(global-set-key (kbd "M-]") 'custom/comment-or-uncomment-region)
(global-set-key (kbd "C-c C-u C-r") 'rename-uniquely)
(global-set-key (kbd "C-c v") 'view-mode)

(global-set-key (kbd "<f9>") 'quote-string-with-period-and-nextline)
(global-set-key (kbd "<S-f9>") 'double-quote-string-with-period-and-nextline)

(define-key global-map (kbd "C-;") 'iedit-mode)
(define-key isearch-mode-map (kbd "C-;") 'iedit-mode)

(global-set-key (kbd "\C-c m n") 'minimap-create)
(global-set-key (kbd "\C-c m k") 'minimap-kill)
(global-set-key (kbd "<f6>") 'point-stack-push)
(global-set-key (kbd "<f7>") 'point-stack-pop)
(global-set-key (kbd "<f8>") 'point-stack-forward-stack-pop)
(global-set-key (kbd "M-\"") 'eval-region)

;; TODO: find more appropriate place for below keybindings
(global-set-key (kbd "\C-c p m") (lambda () (interactive) (find-file "/sudo::/etc/portage/package.mask/package.common.mask")))
(global-set-key (kbd "\C-c p u") (lambda () (interactive) (find-file "/sudo::/etc/portage/package.use")))
(global-set-key (kbd "\C-c p k") (lambda () (interactive) (find-file "/sudo::/etc/make.conf")))

;; (global-set-key (kbd "C-c m k") 'kmacro-end-and-call-macro)

(global-set-key (kbd "C-c f") 'fci-mode)

;;; emacs-rc-editing.el ends here
