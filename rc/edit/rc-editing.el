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
(require 'pretty-mode)

(autoload 'footnote-mode "footnote" nil t) ;; footnote mode
(autoload 'paredit-mode "paredit" "Minor mode for pseudo-structurally editing Lisp code." t)
;; (add-hook 'emacs-lisp-mode-hook       (lambda () (paredit-mode +1)))
;; (add-hook 'lisp-mode-hook             (lambda () (paredit-mode +1)))
;; (add-hook 'lisp-interaction-mode-hook (lambda () (paredit-mode +1)))


;#############################################################################
;#   Custom definitions
;############################################################################
;; current date and time.
(defun insert-current-date-time()
  "Insert the current date and time at point."
  (interactive "*")
  (insert (format-time-string "[%d.%m.%Y - %H:%M]" (current-time))))

;; untabify
(defun untabify-file ()
      (save-excursion
       (delete-trailing-whitespace)
       (untabify (point-min) (point-max))))

;:*========================
;:* VI-style matching parenthesis
;: From Eric Hendrickson edh @ med.umn.edu
;; BUG: switches to apostrophe sign instead of left paren when going to it
;; in strings like " '(delete-selection-mode t)"
(defun match-paren (arg)
  "Go to the matching parenthesis if on parenthesis otherwise insert %."
  (interactive "p")
  (cond ((looking-at "[([{]") (forward-sexp 1) (backward-char))
        ((looking-at "[])}]") (forward-char)
         (backward-sexp 1))
        (t (insert "%"))))

(defun match-paren-2 (arg)
  (interactive "p")
  (cond ((looking-at "\\s\(")
  (forward-list 1) (backward-char 1))
  ((looking-at "\\s\)")
  (forward-char 1) (backward-list 1))
  (t (self-insert-command (or arg1)))))

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

;; (defun get-file-line ()
;;   "show (and set kill-ring) current file and line"
;;   (interactive)
;;   (unless (buffer-file-name)
;;     (error "No file for buffer %s" (buffer-name)))
;;   (let ((msg (format "%s:%d"
;;                      (file-truename (buffer-file-name))
;;                      (line-number-at-pos))))
;;     (kill-new msg)
;;     (message msg)))


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
;; (cua-selection-mode t)
;;(drag-stuff-global-mode t)
(global-pretty-mode 1)

(setq whitespace-modes (quote (awk-mode)))
(setq interprogram-paste-function (quote x-cut-buffer-or-selection-value))
(setq uniquify-buffer-name-style (quote forward))
(setq fill-column 120)
(setq indent-tabs-mode nil)
(setq text-mode-hook (quote (turn-on-auto-fill text-mode-hook-identify)))
(setq comment-style 'indent)
(setq user-full-name "Ronin")
(setq kill-whole-line t)
(setq next-line-add-newlines nil)
(setq tab-always-indent t)
(setq tab-width 4)
(setq transient-mark-mode t)
(setq x-select-enable-clipboard t)
(setq use-dialog-box nil)
(setq whitespace-global-mode nil)
(setq whitespace-silent t)
;; (setq x-select-request-type (quote (UTF8_STRING COMPOUND_TEXT TEXT STRING)))
;; (setq scroll-conservatively 50)
;; (setq save-place-file "~/.emacs.d/saveplace")
;; (setq-default save-place t)
(setq default-input-method 'russian-computer)

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
(global-set-key "\C-c\C-u\C-r" 'rename-uniquely)
(global-set-key "\C-cd" 'insert-current-date-time)
(global-set-key "\C-cf" 'diff-buffer-with-file)
(global-set-key "\C-chm" 'woman)
(global-set-key "\C-cnr" 'narrow-to-region)
(global-set-key "\C-cqr" 'query-replace)
(global-set-key "\C-cuq" 'uniq)
(global-set-key "\C-cus" 'sort-lines)
(global-set-key "\C-cut" 'tabify)
(global-set-key "\C-cuu" 'untabify)
(global-set-key "\C-cv" 'view-mode)
(global-set-key "\C-cwd" 'delete-trailing-whitespace)
(global-set-key "\C-cwr" 'widen)
(global-set-key "\C-x\M-a" 'indent-region)
(global-set-key "\C-xg" 'insert-register)
(global-set-key "\C-xx" 'copy-to-register)
(global-set-key [(?%)] 'match-paren)
(global-set-key [(meta g)] 'goto-line)
(global-set-key [?\M-]] 'custom/comment-or-uncomment-region)
(global-set-key "\C-cws" 'whitespace-mode)

;; TODO: find more appropriate place for below keybindings
(global-set-key "\C-cpm" (lambda () (interactive) (find-file "/sudo::/etc/portage/package.mask/package.common.mask")))
(global-set-key "\C-cpu" (lambda () (interactive) (find-file "/sudo::/etc/portage/package.use")))
(global-set-key "\C-cpk" (lambda () (interactive) (find-file "/sudo::/etc/make.conf")))

(define-key global-map (kbd "C-;") 'iedit-mode)
(define-key isearch-mode-map (kbd "C-;") 'iedit-mode)

(global-set-key "\C-cmn" 'minimap-create)
(global-set-key "\C-cmk" 'minimap-kill)

;;; emacs-rc-editing.el ends here
