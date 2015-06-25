;; -*- coding: utf-8 -*-
;;
;; Filename: rc-editing.el
;; Created:  Fri May 24 22:41:54 2013 +0400
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package rst)
(use-package savekill)
(use-package saveplace)
(use-package table) ;; table
(use-package footnote)

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

(defun set-book-readonly ()
  (when (or (s-contains? "book" (buffer-file-name))
            (s-contains? "fiction" (buffer-file-name)))
    (read-only-mode)))
(add-hook 'find-file-hook 'set-book-readonly)

(use-package drag-stuff
  :defer t
  :config
  (progn
    (setq drag-stuff-modifier '(meta shift))
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
    ))

(use-package region-bindings-mode
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
  :config
  (volatile-highlights-mode t))

(use-package wc-mode)

(use-package whole-line-or-region ;; if no region is active, act on current line
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
  ;;TODO: bind commands
  )

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
  :defer t)

(use-package wrap-region
  :config
  (progn
    (wrap-region-global-mode 1)
    (wrap-region-add-wrapper "*" "*")
    (wrap-region-add-wrapper "(" ")")
    (wrap-region-add-wrapper "{-" "-}" "#")
    (wrap-region-add-wrapper "/* " " */" "#" '(javascript-mode css-mode))))

(use-package autopair
  :config
  (autopair-global-mode))

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
  ("2" custom/duplicate-line)
  ("4" custom/camelscore-word-at-point)
  ("9" custom/quote-string-with-period-and-nextline)
  ("<left>" jump-char-backward)
  ("<right>" jump-char-forward)
  ("C-;" custom/join-next-line-semicolon-n)
  ("C-SPC" comment-dwim)
  ("C-SPC" custom/join-next-line-space-n)
  ("C-r" custom/join-region)
  ("J" custom/join-next-line-n)
  ("M-a" indent-region)
  ("S-9" custom/double-quote-string-with-period-and-nextline)
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
  ("u" custom/uniq)
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
  ("D" turn-off-drag-stuff-mode "disable drag-stuff mode"))
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
(global-set-key (kbd "M-]") 'custom/comment-uncomment-region)
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
