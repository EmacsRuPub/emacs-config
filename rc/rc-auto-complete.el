;;; rc-auto-complete.el ---

;; Copyright (C) 2012 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:

(require 'auto-complete)
(require 'auto-complete-config)
(require 'auto-complete-extension)
(require 'auto-complete-emacs-lisp)
(require 'auto-complete-latex)
(require 'auto-complete-nxml)
(require 'auto-complete-yasnippet)
(require 'go-autocomplete)
(require 'yasnippet)

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

(ac-config-default)
(global-auto-complete-mode t)

;; add lisp autocomplete-support
(require 'ac-slime)

(setq ac-auto-start nil)

(add-hook 'slime-mode-hook 'set-up-slime-ac)
(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
(eval-after-load "auto-complete" '(add-to-list 'ac-modes 'slime-repl-mode))

(add-hook 'nrepl-mode-hook 'set-auto-complete-as-completion-at-point-function)
(add-hook 'nrepl-interaction-mode-hook 'set-auto-complete-as-completion-at-point-function)

(global-set-key (kbd "C-<tab>") 'auto-complete)

(provide 'rc-auto-complete)

;;; rc-auto-complete.el ends here
