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
(require 'rst)
(require 'savekill)
(require 'volatile-highlights)
(require 'whole-line-or-region) ;; if no region is active, act on current line
(require 'highlight-symbol)
(require 'browse-kill-ring)
(require 'expand-region)
(require 'multiple-cursors)
(require 'drag-stuff)
(require 'region-bindings-mode)
(require 'recentf)
(require 'recentf-ext)

(require 'cua-base)
(require 'wc-mode)
(require 'cursor-chg)
(require 'unicad)

(require 'custom-camelscore)
(require 'custom-joinlines)

;#############################################################################
;#   Custom definitions
;############################################################################
;; current date and time.
(defun insert-current-date-time()
  "Insert the current date and time at point."
  (interactive "*")
  (insert (format-time-string "[%d.%m.%Y - %H:%M]" (current-time))))

(defun custom/comment-or-uncomment-region (arg)
  (interactive "*P")
  (comment-normalize-vars)
  (if
      (and (not mark-active)
           (save-excursion (beginning-of-line) (not (looking-at "\\s-*$"))))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg)))

(defun uniq ()
  "Trying to leave only unique strings from selection"
  (interactive)
  (let ((beg (point))
        (end (mark))
        (hash (make-hash-table :test 'equal))
        )
    (if (not end)
        (error "Please, mark text to uniquify")
      (save-excursion
        (narrow-to-region beg end)
        (goto-char (point-min))
        ;; store strings in hash
        (while (not (eobp))
          (beginning-of-line)
          (puthash (buffer-substring (point) (point-at-eol)) 0 hash)
          (forward-line 1))
        (delete-region beg end)
        ;; insert strings from hash
        (maphash (lambda (key val)
                   (insert key "\n")
                   (message "%s" key))
                 hash)
        (widen)))))

(defun smarter-move-beginning-of-line (arg)
  "Move point back to indentation of beginning of line.

Move point to the first non-whitespace character on this line.
If point is already there, move to the beginning of the line.
Effectively toggle between the first non-whitespace character and
the beginning of the line.

If ARG is not nil or 1, move forward ARG - 1 lines first.  If
point reaches the beginning or end of the buffer, stop there."
  (interactive "^p")
  (setq arg (or arg 1))
  ;; Move lines first
  (when (/= arg 1)
    (let ((line-move-visual nil))
      (forward-line (1- arg))))
  (let ((orig-point (point)))
    (back-to-indentation)
    (when (= orig-point (point))
      (move-beginning-of-line 1))))

(defun smart-open-line ()
  "Insert an empty line after the current line.
Position the cursor at its beginning, according to the current mode."
  (interactive)
  (move-end-of-line nil)
  (newline-and-indent))

(defun smart-open-line-above ()
  "Insert an empty line above the current line.
Position the cursor at it's beginning, according to the current mode."
  (interactive)
  (move-beginning-of-line nil)
  (newline-and-indent)
  (forward-line -1)
  (indent-according-to-mode))

(defun smart-kill-whole-line (&optional arg)
  "A simple wrapper around `kill-whole-line' that respects indentation."
  (interactive "P")
  (kill-whole-line arg)
  (back-to-indentation))

(defun move-line-up ()
  "Move up the current line."
  (interactive)
  (transpose-lines 1)
  (forward-line -2)
  (indent-according-to-mode))

(defun move-line-down ()
  "Move down the current line."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  (indent-according-to-mode))

;; (defun conditionally-enable-parens-mode ()
;;   "Enable `paredit-mode' in the minibuffer, during `eval-expression'."
;;   (if (eq this-command 'eval-expression)
;;       (turn-on-smartparens-mode 1)))

(defun copy-file-name-to-clipboard ()
  "Copy the current buffer file name to the clipboard."
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (kill-new filename)
      (message "Copied buffer file name '%s' to the clipboard." filename))))

(defun rename-file-and-buffer ()
  "Rename the current buffer and file it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (message "Buffer is not visiting a file!")
      (let ((new-name (read-file-name "New name: " filename)))
        (cond
         ((vc-backend filename) (vc-rename-file filename new-name))
         (t
          (rename-file filename new-name t)
          (set-visited-file-name new-name t t)))))))

(defun quote-string-with-period-and-nextline ()
  "Wraps current line in quotes, adds period and goes one down"
  (interactive)
  (beginning-of-line)
  (insert "\'")
  (end-of-line)
  (insert "\'\,")
  (next-line))

(defun double-quote-string-with-period-and-nextline ()
  "Wraps current line in quotes, adds period and goes one down"
  (interactive)
  (beginning-of-line)
  (insert "\"")
  (end-of-line)
  (insert "\"\,")
  (next-line))

(defun skip-to-next-blank-line ()
  (interactive)
  (let ((inhibit-changing-match-data t))
    (forward-char 1)
    (unless (search-forward-regexp "^\\s *$" nil t)
      (forward-char -1))))

(defun skip-to-previous-blank-line ()
  (interactive)
  (let ((inhibit-changing-match-data t))
    (forward-char -1)
    (unless (search-backward-regexp "^\\s *$" nil t)
      (forward-char 1))))

(defvar smart-use-extended-syntax nil
  "If t the smart symbol functionality will consider extended
syntax in finding matches, if such matches exist.")

(defvar smart-last-symbol-name ""
  "Contains the current symbol name.

This is only refreshed when `last-command' does not contain
either `smart-symbol-go-forward' or `smart-symbol-go-backward'")

(make-local-variable 'smart-use-extended-syntax)

(defvar smart-symbol-old-pt nil
  "Contains the location of the old point")

(defun smart-symbol-goto (name direction)
  "Jumps to the next NAME in DIRECTION in the current buffer.

DIRECTION must be either `forward' or `backward'; no other option
is valid."

  ;; if `last-command' did not contain
  ;; `smart-symbol-go-forward/backward' then we assume it's a
  ;; brand-new command and we re-set the search term.
  (unless (memq last-command '(smart-symbol-go-forward
                               smart-symbol-go-backward))
    (setq smart-last-symbol-name name))
  (setq smart-symbol-old-pt (point))
  (message (format "%s scan for symbol \"%s\""
                   (capitalize (symbol-name direction))
                   smart-last-symbol-name))
  (unless (catch 'done
            (while (funcall (cond
                             ((eq direction 'forward) ; forward
                              'search-forward)
                             ((eq direction 'backward) ; backward
                              'search-backward)
                             (t (error "Invalid direction"))) ; all others
                            smart-last-symbol-name nil t)
              (unless (memq (syntax-ppss-context
                             (syntax-ppss (point))) '(string comment))
                (throw 'done t))))
    (goto-char smart-symbol-old-pt)))

(defun smart-symbol-go-forward ()
  "Jumps forward to the next symbol at point"
  (interactive)
  (smart-symbol-goto (smart-symbol-at-pt 'end) 'forward))

(defun smart-symbol-go-backward ()
  "Jumps backward to the previous symbol at point"
  (interactive)
  (smart-symbol-goto (smart-symbol-at-pt 'beginning) 'backward))

(defun smart-symbol-at-pt (&optional dir)
  "Returns the symbol at point and moves point to DIR (either `beginning' or `end') of the symbol.

If `smart-use-extended-syntax' is t then that symbol is returned
instead."
  (with-syntax-table (make-syntax-table)
    (if smart-use-extended-syntax
        (modify-syntax-entry ?. "w"))
    (modify-syntax-entry ?_ "w")
    (modify-syntax-entry ?- "w")
    ;; grab the word and return it
    (let ((word (thing-at-point 'word))
          (bounds (bounds-of-thing-at-point 'word)))
      (if word
          (progn
            (cond
             ((eq dir 'beginning) (goto-char (car bounds)))
             ((eq dir 'end) (goto-char (cdr bounds)))
             (t (error "Invalid direction")))
            word)
        (error "No symbol found")))))

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

(defun ido-recentf-open ()
  "Use `ido-completing-read' to \\[find-file] a recent file"
  (interactive)
  (if (find-file (ido-completing-read "Find recent file: " recentf-list))
      (message "Opening file...")
    (message "Aborting")))

(eval-after-load "list-register"
  (global-set-key (kbd "C-x r v") 'list-register)
  )


;#############################################################################
;#   Customizations
;############################################################################
(global-undo-tree-mode t)
(delete-selection-mode t)
(volatile-highlights-mode t)
(show-paren-mode t)
(whole-line-or-region-mode 1)
(toggle-cursor-type-when-idle 1)
(change-cursor-mode 1)

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

(setq browse-kill-ring-quit-action 'save-and-restore)

(defalias 'man 'woman) ;'Woman' offers completion better than 'man'.

(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

(when (eq system-type 'gnu/linux)
  (setq x-alt-keysym 'meta))

(eval-after-load "paredit"
  '(progn
    (define-key paredit-mode-map (kbd "M-s") nil)
    (define-key paredit-mode-map (kbd "M-<up>") nil)
    (define-key paredit-mode-map (kbd "M-<down>") nil)
    (define-key paredit-mode-map (kbd "C-<up>") nil)
    (define-key paredit-mode-map (kbd "C-<down>") nil)
    ))

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

(global-set-key (kbd "C-c k") 'browse-kill-ring)
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

;; key definition example
;; (define-key region-bindings-mode-map "a" 'mc/mark-all-like-this)

;; get rid of `find-file-read-only' and replace it with something
;; more useful.
(global-set-key (kbd "C-x C-r") 'ido-recentf-open)

;; remap C-a to `smarter-move-beginning-of-line'
(global-set-key [remap move-beginning-of-line]
                'smarter-move-beginning-of-line)

(provide 'rc-editing)

;;; emacs-rc-editing.el ends here
