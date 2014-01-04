;;; emacs-rc-javascript.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

;#############################################################################
;#   Load extensions
;############################################################################
;; (add-to-list 'load-path custom-ext-path/ejacs)
(load-library "js2-mode")
;; (load-library "js2")
(require 'js2-refactor)

(require 'defun-javascript)

(autoload 'js2-mode "js2" nil t)
(autoload 'js2-mode "js2-mode" nil t)
(autoload 'js-console "js-console" nil t)

(require 'js2-imenu-extras)

(js2-imenu-extras-setup)

;#############################################################################
;#   Customizations
;############################################################################
(setq js2-use-font-lock-faces t)
(setq js2-allow-keywords-as-property-names nil)
(setq js2-bounce-indent-flag nil)
(setq js2-cleanup-whitespace t)
(setq js2-enter-indents-newline nil)
(setq js2-highlight-level 3)
(setq js2-indent-on-enter-key nil)
(setq js2-skip-preprocessor-directives t)
(setq js2-basic-offset 4)
(setq js2-bounce-indent-p t)
;; Special improvements using the mooz fork
;; https://github.com/mooz/js2-mode
(setq js2-consistent-level-indent-inner-bracket-p t)
(setq js2-use-ast-for-indentation-p t)

(setq-default js2-global-externs
              '("module" "require" "jQuery" "$" "_" "buster"
                "sinon" "assert" "refute" "setTimeout" "clearTimeout"
                "setInterval" "clearInterval" "location" "__dirname" "console" "JSON"))
(setq-default js2-idle-timer-delay 0.1)
(setq-default js2-mirror-mode t)
(setq-default js2-auto-indent-p t)
;; (setq-default js2-rebind-eol-bol-keys nil)
(setq-default js2-concat-multiline-strings 'eol)

;; Use lambda for anonymous functions
;; (font-lock-add-keywords
;;  'js2-mode `(("\\(function\\) *("
;;               (0 (progn (compose-region (match-beginning 1)
;;                                         (match-end 1) "\u0192")
;;                         nil)))))

;; ;; Use right arrow for return in one-line functions
;; (font-lock-add-keywords
;;  'js2-mode `(("function *([^)]*) *{ *\\(return\\) "
;;               (0 (progn (compose-region (match-beginning 1)
;;                                         (match-end 1) "\u2190")
;;                         nil)))))

;; After js2 has parsed a js file, we look for jslint globals decl comment ("/* global Fred, _, Harry */") and
;; add any symbols to a buffer-local var of acceptable global vars
;; Note that we also support the "symbol: true" way of specifying names via a hack (remove any ":true"
;; to make it look like a plain decl, and any ':false' are left behind so they'll effectively be ignored as
;; you can;t have a symbol called "someName:false"
(add-hook 'js2-post-parse-callbacks
          (lambda ()
            (when (> (buffer-size) 0)
              (let ((btext (replace-regexp-in-string
                            ": *true" " "
                            (replace-regexp-in-string "[\n\t ]+" " " (buffer-substring-no-properties 1 (buffer-size)) t t))))
                (mapc (apply-partially 'add-to-list 'js2-additional-externs)
                      (split-string
                       (if (string-match "/\\* *global *\\(.*?\\) *\\*/" btext) (match-string-no-properties 1 btext) "")
                       " *, *" t))
                ))))


(setenv "CLASSPATH"
        (concat
         "/usr/share/rhino-1.6/lib/js.jar:"
         (getenv "CLASSPATH")))

(add-hook 'js2-mode-hook '(lambda ()
                            (local-set-key "\C-x\C-e" 'js-send-last-sexp)
                            (local-set-key "\C-\M-x" 'js-send-last-sexp-and-go)
                            (local-set-key "\C-cb" 'js-send-buffer)
                            (local-set-key "\C-c\C-b" 'js-send-buffer-and-go)
                            (local-set-key "\C-cl" 'js-load-file-and-go)
                            (setq flycheck-checker 'javascript-jshint))
                            )

(js2r-add-keybindings-with-prefix "C-c C-j")

(add-to-list 'load-path (concat config-basedir "ext/tern"))
(autoload 'tern-mode "emacs/tern.el" nil t)

(add-hook 'js2-mode-hook (lambda () (tern-mode t)))

(provide 'rc-lang-javascript)

;;; emacs-rc-javascript.el ends here
