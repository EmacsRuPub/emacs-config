;; -*- coding: utf-8 -*-
;;
;; Filename: rc-javascript.el
;; Created:  Thu May 1 16:30:43 2014 +0400
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package js2-mode
  :init
  (use-package js-console)
  (use-package js2-imenu-extras)
  :config
  (progn
    (js2-imenu-extras-setup)
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
    (setq-default js2-concat-multiline-strings 'eol)
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
    (add-hook 'js2-mode-hook '(lambda ()
                                (setq flycheck-checker 'javascript-jshint)
                                (tern-mode t)))
    (define-key js2-mode-map (kbd "C-x C-e") 'js-send-last-sexp)
    (define-key js2-mode-map (kbd "C-M-x") 'js-send-last-sexp-and-go)
    (define-key js2-mode-map (kbd "C-c b") 'js-send-buffer)
    (define-key js2-mode-map (kbd "C-c C-b") 'js-send-buffer-and-go)
    (define-key js2-mode-map (kbd "C-c l") 'js-load-file-and-go)
    ))

;TODO: play with js2-refactor
(use-package js2-refactor
  :config
  (progn
    (js2r-add-keybindings-with-prefix "C-c C-j")
    (make-variable-buffer-local 'js2r-path-to-tests)
    (make-variable-buffer-local 'js2r-path-to-sources)
    (make-variable-buffer-local 'js2r-test-suffix)))

(use-package tern
  :commands tern-mode
  :init
  (use-package tern-auto-complete)
  :config
  (tern-ac-setup))

(setenv "CLASSPATH"
        (concat
         "/usr/share/rhino-1.6/lib/js.jar:"
         (getenv "CLASSPATH")))

(provide 'rc-javascript)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-javascript.el ends here
