;;; rc-ac-temp.el ---

;; Copyright (C) 2012 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:

;; text completion
;; auto completion
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(add-to-list 'ac-modes 'text-mode)
(add-to-list 'ac-modes 'markdown-mode)
(add-to-list 'ac-modes 'org-mode)
(setq ac-comphist-file "~/.emacs.d/cache/ac-comphist.dat")
(setq ac-use-menu-map t)
(setq ac-auto-show-menu nil)
(setq ac-ignore-case nil)
(ac-config-default)
;; disabling Yasnippet completion
(defun epy-snips-from-table (table)
  (with-no-warnings
    (let ((hashtab (ac-yasnippet-table-hash table))
          (parent (ac-yasnippet-table-parent table))
          candidates)
      (maphash (lambda (key value)
                 (push key candidates))
               hashtab)
      (identity candidates)
      )))
(defun epy-get-all-snips ()
  (let (candidates)
    (maphash
     (lambda (kk vv) (push (epy-snips-from-table vv) candidates)) yas/tables)
    (apply 'append candidates))
  )
(setq ac-ignores (concatenate 'list ac-ignores (epy-get-all-snips)))


(custom-set-variables
 '(ac-use-fuzzy nil)
 '(ac-trigger-key "TAB")
 '(ac-auto-start nil)
 '(ac-use-menu-map t)
 '(ac-show-menu nil)
 '(ac-comphist-file (expand-file-name (concat iy-data-dir "ac-comphist.dat")))
 '(ac-use-quick-help nil))

;; auto-complete

(require 'auto-complete-config)
(ac-config-default)
(ac-flyspell-workaround)
(ac-linum-workaround)
(global-auto-complete-mode t)
(setq ac-auto-start 3)
(setq ac-dwim t)
(set-default 'ac-sources '(ac-source-yasnippet ac-source-semantic))
(defun ielm-auto-complete ()
  "Enables `auto-complete' support in \\[ielm]."
  (setq ac-sources '(ac-source-functions
ac-source-variables
ac-source-features
ac-source-symbols
ac-source-words-in-same-mode-buffers))
  (add-to-list 'ac-modes 'inferior-emacs-lisp-mode)
  (auto-complete-mode 1))
(add-hook 'ielm-mode-hook 'ielm-auto-complete)

;; Autocomplete setup
(define-key ac-complete-mode-map [tab] 'ac-expand)
(ac-flyspell-workaround)
(add-to-list 'ac-modes 'org-mode)
(ac-config-default)

;; auto-complete-mode offers superior code completion over existing tools
(setq load-path (cons "~/.emacs.d/vendor/auto-complete" load-path))
(require 'auto-complete-config)
(when (featurep 'auto-complete)
  (ac-config-default)
  (setq ac-auto-start nil)
  (setq ac-quick-help-delay 0.5)
  (add-to-list 'ac-dictionary-directories "~/.emacs.d/vendor/auto-complete/ac-dict")
  ;; Store the completion history in the cache directory
  (setq ac-comphist-file "~/.emacs.cache/ac-comphist.dat")

  (when (featurep 'cedet)
    ;; Use semantic as a source for auto complete
    (setq ac-sources '(ac-source-semantic)))

  (setq load-path (cons "~/.emacs.d/vendor/auto-complete-clang" load-path))
  (require 'auto-complete-clang)
  (when (featurep 'auto-complete-clang)
    (add-hook 'c-mode-common-hook
              (lambda ()
                (setq ac-sources (append '(ac-source-clang) ac-sources)))))

  (add-hook 'auto-complete-mode-hook 'ac-common-setup)

  ;; Enable auto-complete globally
  (global-auto-complete-mode t))

;;; rc-ac-temp.el ends here
