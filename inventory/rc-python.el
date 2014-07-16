;; -*- coding: utf-8 -*-
;;
;; Filename: rc-python.el
;; Created: Вс мар 31 15:21:13 2013 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ;; Python mode for Emacs
;; (setq load-path (cons "~/.emacs.d/vendor/python.el" load-path))
;; (setq
;;  python-shell-interpreter "ipython"
;;  python-shell-interpreter-args ""
;;  python-shell-prompt-regexp "In \\[[0-9]+\\]: "
;;  python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
;;  python-shell-completion-setup-code "from IPython.core.completerlib import module_completion"
;;  python-shell-completion-module-string-code "';'.join(module_completion('''%s'''))\n"
;;  python-shell-completion-string-code "';'.join(get_ipython().Completer.all_completions('''%s'''))\n")
;; (require 'python)

;; ;; Pylookup
;; (setq pylookup-dir "~/.emacs.d/vendor/pylookup")
;; (setq load-path (cons pylookup-dir load-path))
;; (require 'pylookup)
;; ;; set executable file and db file
;; (setq pylookup-program (concat pylookup-dir "/pylookup.py"))
;; (setq pylookup-db-file (concat pylookup-dir "/pylookup.db"))
;; ;; set search option if you want
;; ;; (setq pylookup-search-options '("--insensitive" "0" "--desc" "0"))
;; ;; to speedup, just load it on demand
;; (autoload 'pylookup-lookup "pylookup"
;;   "Lookup SEARCH-TERM in the Python HTML indexes." t)
;; (autoload 'pylookup-update "pylookup"
;;   "Run pylookup-update and create the database at `pylookup-db-file'." t)


;; ;; Multiple Python checkers support
;; (when (load "flymake" t)
;;   (defun flymake-pycheckers-init ()
;;     (let* ((temp-file (flymake-init-create-temp-buffer-copy
;;                        'flymake-create-temp-inplace))
;;            (local-file (file-relative-name
;;                         temp-file
;;                         (file-name-directory buffer-file-name))))
;;       (list "/path/to/this/file" (list local-file)))))

;; ;; Run Python checkers when in flymake-mode
;; (when (load "flymake" t)
;;   (defun flymake-pycheckers-init ()
;;     (let* ((temp-file (flymake-init-create-temp-buffer-copy
;;                        'flymake-create-temp-inplace))
;;            (local-file (file-relative-name
;;                         temp-file
;;                         (file-name-directory buffer-file-name))))
;;       (list "~/.emacs.d/vendor/bin/pycheckers" (list local-file))))

;;   (add-to-list 'flymake-allowed-file-name-masks
;;                '("\\.py\\'" flymake-pycheckers-init)))

;; (require 'django-html-mode)
;; (require 'django-mode)

;; (yas-load-directory (at-config-basedir "el-get/django-mode/snippets"))

(defun custom/python-mode-hook ()
  ;; (eldoc-mode 1)
  ;; (turn-on-eldoc-mode)
  )

;; (add-hook 'python-mode-hook 'flyspell-prog-mode)

;; (setq flake8-multi/search-cwd t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-python.el ends here
