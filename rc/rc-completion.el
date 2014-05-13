;; -*- coding: utf-8 -*-
;;
;; Filename: rc-completion.el
;; Created: Вс май  4 23:17:16 2014 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun ac-yasnippet-candidate ()
  (let ((table (yas/get-snippet-tables major-mode)))
    (if table
      (let (candidates (list))
            (mapcar (lambda (mode)
              (maphash (lambda (key value)
                (push key candidates))
              (yas/snippet-table-hash mode)))
            table)
        (all-completions ac-prefix candidates)))))

(defun ac-yasnippet-candidate-1 (table)
  (let ((hashtab (yas/snippet-table-hash table))
        (parent (if (fboundp 'yas/snippet-table-parent)
                    (car (yas/snippet-table-parent table))))
        candidates)
    (maphash (lambda (key value)
               (push key candidates))
             hashtab)
    (setq candidates (all-completions ac-prefix (nreverse candidates)))
    (if parent
        (setq candidates
              (append candidates (ac-yasnippet-candidate-1 parent))))
    candidates))

(defface ac-yasnippet-candidate-face
  '((t (:background "sandybrown" :foreground "black")))
  "Face for yasnippet candidate.")

(defface ac-yasnippet-selection-face
  '((t (:background "coral3" :foreground "white")))
  "Face for the yasnippet selected candidate.")

(defvar ac-source-yasnippet
  '((candidates . ac-yasnippet-candidate)
    (action . yas/expand)
    (limit . 3)
    (candidate-face . ac-yasnippet-candidate-face)
    (selection-face . ac-yasnippet-selection-face))
  "Source for Yasnippet.")

(defun set-auto-complete-as-completion-at-point-function ()
  (setq completion-at-point-functions '(auto-complete)))

;; Inter-field navigation
(defun yas/goto-end-of-active-field ()
  (interactive)
  (let* ((snippet (car (yas/snippets-at-point)))
         (position (yas/field-end (yas/snippet-active-field snippet))))
    (if (= (point) position)
        (move-end-of-line)
      (goto-char position))))

(defun yas/goto-start-of-active-field ()
  (interactive)
  (let* ((snippet (car (yas/snippets-at-point)))
         (position (yas/field-start (yas/snippet-active-field snippet))))
    (if (= (point) position)
        (move-beginning-of-line)
      (goto-char position))))

(defun yas-popup-isearch-prompt (prompt choices &optional display-fn)
  (when (featurep 'popup)
    (popup-menu*
     (mapcar
      (lambda (choice)
        (popup-make-item
         (or (and display-fn (funcall display-fn choice))
             choice)
         :value choice))
      choices)
     :prompt prompt
     :isearch t
     )))

(defun yas-safer-expand ()
  (let ((yas/fallback-behavior 'return-nil))
    (call-interactively 'yas/expand)))

(defun yas-ido-insert-snippets (&optional no-condition)
  (interactive "P")
  (let ((yas-prompt-functions '(yas/ido-prompt)))
    (yas/insert-snippet)))

(defun yasnippet-unbind-trigger-key ()
  "Unbind `yas/trigger-key'."
  (let ((key yas/trigger-key))
    (setq yas/trigger-key nil)
    (yas/trigger-key-reload key)))

;; hook for automatic reloading of changed snippets
(defun update-yasnippets-on-save ()
  (when (string-match "/resources/yasnippet" buffer-file-name)
    (yas/load-directory custom/yasnippet-dir)))

(autoload 'auto-complete "auto-complete" "Autocompletion for Emacs." t)
(autoload 'yas-global-mode "yasnippet" "Yasnippet" t)

(eval-after-load "auto-complete"
  '(progn
     (require 'auto-complete-config)
     (require 'auto-complete-extension)
     (require 'auto-complete-emacs-lisp)
     (require 'auto-complete-latex)
     (require 'auto-complete-nxml)
     (require 'auto-complete-yasnippet)
     (require 'go-autocomplete)
     (require 'ac-slime) ;; add lisp autocomplete-support

     (ac-config-default)
     (global-auto-complete-mode t)
     (setq ac-auto-start nil)
     (add-to-list 'ac-modes 'slime-repl-mode)

     (add-hook 'slime-mode-hook 'set-up-slime-ac)
     (add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
     (add-hook 'nrepl-mode-hook 'set-auto-complete-as-completion-at-point-function)
     (add-hook 'nrepl-interaction-mode-hook 'set-auto-complete-as-completion-at-point-function)

     (global-set-key (kbd "C-<tab>") 'auto-complete)
     ))

(eval-after-load "yasnippet"
  '(progn
     (setq yas/next-field-key '("<backtab>" "<S-tab>"))
     (setq yas/prev-field-key '("<C-tab>"))
     (setq yas/snippet-dirs custom/yasnippet-dir)
     (yas--initialize)
     (yas/load-directory custom/yasnippet-dir)

     (setq yas/prompt-functions
           '(yas/ido-prompt
             yas/completing-prompt
             yas/x-prompt
             yas/no-prompt))
     ;; Wrap around region
     (setq yas/wrap-around-region t)

     (add-hook 'after-save-hook 'update-yasnippets-on-save)

     ;; Jump to end of snippet definition
     (define-key yas/keymap (kbd "<return>") 'yas/exit-all-snippets)
     (define-key yas/keymap (kbd "C-e") 'yas/goto-end-of-active-field)
     (define-key yas/keymap (kbd "C-a") 'yas/goto-start-of-active-field)
     ))

(setq-default abbrev-mode t) ;; ensure abbrev mode is always on
(setq save-abbrevs 'silently)      ;; do not bug me about saving my abbreviations

(global-set-key (kbd "C-S-<iso-lefttab>") 'dabbrev-expand)

(provide 'rc-completion)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-completion.el ends here
