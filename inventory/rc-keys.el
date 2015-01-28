;;; rc-keys-temp.el ---

;; Copyright (C) 2012 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:

(define-key global-map (kbd "C-x C-n") 'make-frame-command) ;; Create new frame
(define-key isearch-mode-map (kbd "C-o") 'isearch-yank-selection) ;; Yank selection in isearch
(global-set-key (kbd "<f1> a") 'apropos) ;; Help should search more than just commands
(global-set-key (kbd "C-'") 'match-paren) ;; Find matching parens
(global-set-key (kbd "C-+") 'change-number-at-point) ;; Increase number at point (or other change based on prefix arg)
(global-set-key (kbd "C-.") 'insert-arrow) ;; Easy inserts
(global-set-key (kbd "C-<f10>") 'menu-bar-mode);; Turn on the menu bar for exploring new modes
(global-set-key (kbd "C-<tab>") 'completion-at-point) ;; Completion at point
(global-set-key (kbd "C-S-y") 'yank-unindented) ;; Yank and indent
(global-set-key (kbd "C-\"") 'toggle-quotes) ;; Toggle quotes
(global-set-key (kbd "C-c C-e") 'eval-and-replace) ;; Should be able to eval-and-replace anywhere.
(global-set-key (kbd "C-c b") 'create-scratch-buffer) ;; Create scratch buffer
(global-set-key (kbd "C-c d") 'duplicate-current-line-or-region) ;; Duplicate region
(global-set-key (kbd "C-c v") 'eval-buffer) ;; Eval buffer
(global-set-key (kbd "C-x C-i") 'ido-imenu) ;; Jump to a definition in the current file. (This is awesome)
(global-set-key (kbd "C-x C-y") 'browse-kill-ring) ;; Browse the kill ring
(global-set-key (kbd "C-x m") 'magit-status) (autoload 'magit-status "magit") ;; Magit
(global-set-key (kbd "C-x r t") 'inline-string-rectangle) ;; Replace rectangle-text with inline-string-rectangle
(global-set-key (kbd "H-SPC") 'set-rectangular-region-anchor) ;; Set anchor to start rectangular-region-mode
(global-set-key (kbd "M-&") 'query-replace-regexp) ;; Query replace regex key binding
(global-set-key (kbd "M-a") 'mark-whole-buffer) ; was backward-sentence. ;; Mac OS X conventions
(global-set-key (kbd "M-i") 'back-to-indentation) ;; M-i for back-to-indentation
(global-set-key (kbd "M-j") (lambda () (interactive) (join-line -1))) ;; Indentation help
(global-set-key (kbd "M-s l") 'sort-lines) ;; Sorting
(global-set-key (vector 'remap 'goto-line) 'goto-line-with-feedback) ;; Navigation bindings
(global-set-key [(control z)] 'repeat) ; was suspend-frame ;; Repeat
(windmove-default-keybindings 'meta) ;; Window navigation

;; Use shell-like backspace C-h, rebind help to F1
(define-key key-translation-map [?\C-h] [?\C-?])
(global-set-key (kbd "<f1>") 'help-command)


;; Change next underscore with a camel case
(global-set-key (kbd "C-c C--") 'replace-next-underscore-with-camel)
(global-set-key (kbd "M-s M--") 'snakeify-current-word)

;; Killing text
(global-set-key (kbd "C-S-k") 'kill-and-retry-line)
(global-set-key (kbd "C-w") 'kill-region-or-backward-word)
(global-set-key (kbd "C-c C-w") 'kill-to-beginning-of-line)

;; Use M-w for copy-line if no active region
(global-set-key (kbd "M-w") 'save-region-or-current-line)
(global-set-key (kbd "M-W") '(lambda () (interactive) (save-region-or-current-line 1)))

;; Make shell more convenient, and suspend-frame less
(global-set-key (kbd "C-z") 'shell)
(global-set-key (kbd "C-x M-z") 'suspend-frame)

;; Zap to char
(global-set-key (kbd "M-z") 'zap-to-char)
(global-set-key (kbd "M-Z") 'zap-to-char-exclusive)

;; iy-go-to-char - like f in Vim
(global-set-key (kbd "M-m") 'jump-char-forward)
(global-set-key (kbd "M-M") 'jump-char-backward)

(global-set-key (kbd "M-s e") 'sudo-edit) ;; Edit file with sudo
(global-set-key (kbd "C-x M-w") 'copy-current-file-path) ;; Copy file path to kill ring


;; File finding
(global-set-key (kbd "C-x M-f") 'ido-find-file-other-window)
(global-set-key (kbd "C-x f") 'recentf-ido-find-file)
(global-set-key (kbd "C-x C-p") 'find-or-create-file-at-point)
(global-set-key (kbd "C-x M-p") 'find-or-create-file-at-point-other-window)
(global-set-key (kbd "C-c y") 'bury-buffer)
(global-set-key (kbd "C-c r") 'revert-buffer)
(global-set-key (kbd "M-`") 'file-cache-minibuffer-complete)



;; Window switching
(windmove-default-keybindings) ;; Shift+direction
(global-set-key (kbd "C-x -") 'rotate-windows)
(global-set-key (kbd "C-x C--") 'toggle-window-split)
(global-unset-key (kbd "C-x C-+")) ;; don't zoom like this



(global-set-key (kbd "<prior>") 'beginning-of-buffer)
(global-set-key (kbd "<home>") 'beginning-of-buffer)
(global-set-key (kbd "<next>") 'end-of-buffer)
(global-set-key (kbd "<end>") 'end-of-buffer)
(global-set-key (kbd "M-p") 'backward-paragraph)
(global-set-key (kbd "M-n") 'forward-paragraph)

(global-set-key (kbd "C-x M-g") 'browse-url-at-point)



;; Like isearch, but adds region (if any) to history and deactivates mark
(global-set-key (kbd "C-s") 'isearch-forward-use-region)
(global-set-key (kbd "C-r") 'isearch-backward-use-region)

;; Like isearch-*-use-region, but doesn't fuck with the active region
(global-set-key (kbd "C-S-s") 'isearch-forward)
(global-set-key (kbd "C-S-r") 'isearch-backward)

(global-set-key (kbd "<XF86Back>") 'scroll-down)
(global-set-key (kbd "<XF86Forward>") 'scroll-up)
(global-set-key (kbd "<XF86WakeUp>") 'beginning-of-buffer)



;; Comment/uncomment block
(global-set-key (kbd "C-c c") 'comment-or-uncomment-region)
(global-set-key (kbd "C-c u") 'uncomment-region)



;; Move windows, even in org-mode
(global-set-key (kbd "<s-right>") 'windmove-right)
(global-set-key (kbd "<s-left>") 'windmove-left)
(global-set-key (kbd "<s-up>") 'windmove-up)
(global-set-key (kbd "<s-down>") 'windmove-down)



;; Clever newlines
(global-set-key (kbd "<C-return>") 'new-line-below)
(global-set-key (kbd "<C-S-return>") 'new-line-above)
(global-set-key (kbd "<M-return>") 'new-line-in-between)



;; Line movement
(global-set-key (kbd "<C-S-down>") 'move-line-down)
(global-set-key (kbd "<C-S-up>") 'move-line-up)

;; Buffer file functions
(global-set-key (kbd "C-x t") 'touch-buffer-file)
(global-set-key (kbd "C-x C-r") 'rename-current-buffer-file)
(global-set-key (kbd "C-x C-k") 'delete-current-buffer-file)

;; Jump from file to containing directory
(global-set-key (kbd "C-x C-j") 'dired-jump) (autoload 'dired-jump "dired")
(global-set-key (kbd "C-x M-j") '(lambda () (interactive) (dired-jump 1)))

;; Easy-mode fullscreen rgrep
(global-set-key (kbd "M-s s") 'git-grep-fullscreen)
(global-set-key (kbd "M-s S") 'rgrep-fullscreen)

(global-set-key (kbd "C-c o") 'occur) ;; Display and edit occurances of regexp in buffer
(global-set-key (kbd "M-s f") 'find-name-dired) ;; Find files by name and display results in dired
(global-set-key (kbd "C-x o") 'find-file-in-project) ;; Find file in project


;; View occurrence in occur mode
(define-key occur-mode-map (kbd "v") 'occur-mode-display-occurrence)
(define-key occur-mode-map (kbd "n") 'next-line)
(define-key occur-mode-map (kbd "p") 'previous-line)

(provide 'rc-keys)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Key triggers
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "C-w") 'backward-kill-word)
(global-set-key (kbd "C-c p") 'swap-buffers-in-windows)
(global-set-key (kbd "C-c r") 'revert-buffer)
(global-set-key (kbd "C-c v") 'visual-line-mode)
(global-set-key (kbd "C-c e") 'eval-and-replace)
(global-set-key (kbd "C-c s") 'shell-current-directory)
(global-set-key (kbd "C-x C-k") 'kill-region)
(global-set-key (kbd "C-c C-m") 'execute-extended-command)
(global-set-key (kbd "C-c C-k") 'kill-region)
(global-set-key (kbd "C-c C-s") 'sudo-edit-current-file)
(global-set-key (kbd "C-c C-r") 'reload-file)

;; Bind smex over M-x, deals with sorting most used commands to front of IDO
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)


;; Use regex searches by default
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "\C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)

;;{{{ Organization

(define-key iy-map (kbd "<tab>") 'fold-dwim-toggle)
(define-key iy-map (kbd "S-<tab>") 'fold-dwim-hide-all)
(define-key iy-map (kbd "<backtab>") 'fold-dwim-hide-all)
(define-key iy-map (kbd "C-<tab>") 'fold-dwim-show-all)

;;}}}

;;{{{ Buffer/File
(global-set-key (kbd "C-M-l") 'iy-switch-to-previous-buffer)

(global-set-key (kbd "M-o") 'other-window)
(global-set-key (kbd "M-O") 'other-frame)
(global-set-key (kbd "C-<next>") 'next-buffer)
(global-set-key (kbd "C-<prior>") 'previous-buffer)

(global-set-key (kbd "M-O") 'other-frame)
(defun iy-kill-buffer-and-window ()
  (interactive)
  (if (< (length (window-list)) 2)
      (kill-buffer)
    (kill-buffer-and-window)))
(global-set-key (kbd "C-x K") 'iy-kill-buffer-and-window)
(global-set-key (kbd "C-x C-r") 'rename-current-buffer-file)

;;}}}

;;{{{ Bookmark
(global-set-key (kbd "C-x j SPC") 'jump-to-register)

(define-key iy-map (kbd "m") 'bookmark-set)
(define-key iy-map (kbd "M-m") 'bookmark-set)
(define-key iy-map (kbd ".") 'iy-bmkp-navigation)
(define-key iy-map (kbd "M-.") 'iy-bmkp-navigation)
(define-key iy-map (kbd ">") 'iy-bmkp-navigation)
(define-key iy-map (kbd ",") 'iy-bmkp-navigation)
(define-key iy-map (kbd "M-,") 'iy-bmkp-navigation)
(define-key iy-map (kbd "<") 'iy-bmkp-navigation)
(define-key iy-map (kbd "/") 'bookmark-bmenu-list)

;;}}}

;;{{{ Search/find
(define-key iy-map (kbd "o") 'occur)
(define-key iy-map (kbd "O") 'multi-occur)
;;}}}

;;{{{ Fx
(global-set-key (kbd "<f1>") help-map)
(global-set-key (kbd "<f2>") 'recentf-open-files)

(if (fboundp 'iy-compile)
    (global-set-key (kbd "<f5>") 'iy-compile)
  (global-set-key (kbd "<f5>") 'compile))

(global-set-key (kbd "C-<f7>") 'speedbar-get-focus)
(global-set-key (kbd "<ESC> <f7>") 'speedbar-get-focus)

(global-set-key (kbd "<f10>") 'rgrep)
(global-set-key (kbd "<f11>") 'occur)
(global-set-key (kbd "<f12>") 'iy-magit-status)
(global-set-key (kbd "C-<f12>") 'git-status)
(global-set-key (kbd "<ESC> <f12>") 'git-status)
;;}}}

;;{{{ Misc
(global-set-key (kbd "C-x C-j") 'dired-jump)
(global-set-key (kbd "C--") 'undo)
(global-set-key (kbd "C-x SPC") 'point-to-register)
(global-set-key (kbd "C-.") 'repeat)
(global-set-key (kbd "C-'") 'negative-argument)
(global-set-key (kbd "M-'") 'negative-argument)
(setq repeat-on-final-keystroke "z")

(define-key iy-map (kbd "e") 'iy-eshell-toggle)
(define-key iy-map (kbd "E") 'iy-eshell-here)

(global-set-key (kbd "C-4") 'ispell-word)

(define-key iy-map (kbd "n") 'deft)

;;}}}

;;{{{ Move

(global-set-key (kbd "M-F") 'forward-symbol)
(global-set-key (kbd "M-B") (lambda (arg)
                              (interactive "p")
                              (forward-symbol (- arg))))
(global-set-key (kbd "C-a") 'back-to-indentation-or-beginning)

(define-key iy-map (kbd ";") 'iy-go-to-char-continue)
(define-key iy-map (kbd ":") 'iy-go-to-char-continue-backward)
(global-set-key (kbd "C-z") 'iy-go-to-char)
(global-set-key (kbd "M-m") 'iy-go-to-char)
(global-set-key (kbd "C-S-z") 'iy-go-to-char-backward)
(global-set-key (kbd "M-M") 'iy-go-to-char-backward)

(global-set-key (kbd "C-r") ctl-x-r-map)
(with-eval-after-load 'bookmark+
  (global-set-key (kbd "C-x r") 'set-rectangular-region-anchor))

(global-set-key (kbd "C-8") 'pop-tag-mark)

(global-set-key [end] 'end-of-line)
(global-set-key [home] 'beginning-of-line)

(global-set-key (kbd "C-`") 'next-error)
(global-set-key (kbd "C-~") 'previous-error)

(global-set-key (kbd "C->") 'scroll-left)
(global-set-key (kbd "C-<") 'scroll-right)
(global-set-key (kbd "C-x >") 'scroll-left)
(global-set-key (kbd "C-x <") 'scroll-right)

(global-set-key (kbd "C-<left>") 'scroll-right)
(global-set-key (kbd "C-<right>") 'scroll-left)
(global-set-key (kbd "C-<up>") 'scroll-down)
(global-set-key (kbd "C-<down>") 'scroll-up)

(global-set-key (kbd "<home>") 'back-to-indentation-or-beginning)

;;}}}

;;{{{ Delete
(define-key iy-map (kbd "d") 'zap-to-char)
(define-key iy-map (kbd "D") 'iy-zap-back-to-char)
(global-set-key (kbd "M-z") 'zap-up-to-char)

(define-key key-translation-map [?\C-h] [?\C-?])
(define-key key-translation-map [?\M-r] [?\C-\M-?])

;;}}}

;;{{{ Insert

(define-key iy-map (kbd "q b") 'jared/insert-file-or-buffer-name)

(global-set-key (kbd "M-<return>") 'iy-next-line-and-open-it-if-not-empty)

(global-set-key (kbd "M-u") 'iy-dwim-underscore)
(global-set-key (kbd "M-l") 'iy-dwim-dash)

;;}}}

;;{{{ fix isearch/minibuffer

(define-key isearch-mode-map (kbd "M-l") 'iy-isearch-dash)
(define-key isearch-mode-map (kbd "M-u") 'iy-isearch-underscore)

;;}}}

;;{{{ Mark

(global-set-key (kbd "C-2") 'er/expand-region)

(global-set-key [(meta ?@)] 'mark-word)
(global-set-key [(control meta ? )] 'mark-sexp)
(global-set-key [(control meta shift ?u)] 'mark-enclosing-sexp)


(setq iy-mark-keymap (make-sparse-keymap))
(setq iy-mark-surround-keymap (make-sparse-keymap))
(setq iy-forward-thing-keymap (make-sparse-keymap))
(setq iy-backward-thing-keymap (make-sparse-keymap))
(setq iy-begining-of-thing-keymap (make-sparse-keymap))
(setq iy-end-of-thing-keymap (make-sparse-keymap))

(global-set-key (kbd "M-SPC") iy-mark-keymap)
(define-key iy-mark-keymap (kbd "M-SPC") 'iy-ido-mark-thing)
(define-key iy-mark-keymap (kbd "C-g") 'keyboard-quit)
(define-key iy-mark-keymap (kbd "M-s") iy-mark-surround-keymap)
(define-key iy-mark-keymap (kbd "M-n") iy-forward-thing-keymap)
(define-key iy-mark-keymap (kbd "M-p") iy-backward-thing-keymap)
(define-key iy-mark-keymap (kbd "M-a") iy-begining-of-thing-keymap)
(define-key iy-mark-keymap (kbd "M-e") iy-end-of-thing-keymap)

(dolist (k (mapcar 'car things-map))
  (define-key iy-mark-keymap (vector k) 'iy-mark-thing)
  (define-key iy-mark-surround-keymap (vector k) 'iy-mark-surround-thing)
  (define-key iy-forward-thing-keymap (vector k) 'iy-forward-thing)
  (define-key iy-backward-thing-keymap (vector k) 'iy-backward-thing)
  (define-key iy-begining-of-thing-keymap (vector k) 'iy-begining-of-thing)
  (define-key iy-end-of-thing-keymap (vector k) 'iy-end-of-thing)
)

;;}}}


;;{{{ Highlight

(define-key iy-map (kbd "9") 'iy-highlight-symbol-navigation)
(define-key iy-map (kbd "0") 'iy-highlight-symbol-navigation)
(define-key iy-map (kbd "+") 'highlight-symbol-query-replace)
(define-key iy-map (kbd "=") 'highlight-symbol-at-point)
(define-key iy-map (kbd "-") 'highlight-symbol-remove-all)
(define-key iy-map (kbd "_") 'highlight-symbol-mode)


;;}}}

;;; Global key bindigns

;; How to Define Keyboard Shortcuts in Emacs
;; http://xahlee.org/emacs/keyboard_shortcuts.html

;; Window manipulation
(global-set-key [(control kp-6)] 'enlarge-window-horizontally)
(global-set-key [(control kp-4)] 'shrink-window-horizontally)
(global-set-key [(control kp-8)] 'enlarge-window)
(global-set-key [(control kp-2)] 'shrink-window)

;; Keyboard macros
(global-set-key [(shift f4)] 'kmacro-start-macro-or-insert-counter)
;; (global-set-key [(f4)] 'kmacro-end-or-call-macro) ;; already defined

;; Refresh-like
(global-set-key [(f5)] 'revert-buffer)
(global-set-key [(control f5)] 'revbufs)

;; Indenting and alignment
(global-set-key [(f8)] 'indent-region)
(global-set-key [(control f8)] 'align)
(global-set-key [(shift f8)] 'align-current)
(global-set-key [(meta f8)] 'align-regexp)

;; Version control and change related
;(global-set-key [(control f9)] 'rails-svn-status-into-root) ;; Move to rails mode?
;(global-set-key [(control meta f9)] (lambda () (interactive) (svn-status default-directory)))
(global-set-key [(control f9)] (lambda () (interactive) (magit-status default-directory)))
(global-set-key [(f9)] (lambda () (interactive) (magit-status default-directory)))
(global-set-key [(meta f9)] 'autotest-switch) ;; Move to ruby/rails mode?

(global-set-key (kbd "M-O") 'rotate-windows)


;; Personal textmate.el bindings
(global-set-key (kbd "C-c f") 'textmate-goto-file)
(global-set-key [(control return)] 'textmate-next-line)

(global-set-key "\C-x\ W" 'rename-file-and-buffer)

;;; rc-keys-temp.el ends here
