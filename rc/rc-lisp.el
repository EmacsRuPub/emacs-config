;; -*- coding: utf-8 -*-
;;
;; Filename: rc-lisp.el
;; Created:  Thu May 1 16:30:43 2014 +0400
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'inf-lisp)
(require 'info-look)

(load (expand-file-name "~/quicklisp/slime-helper.el"))

(setq inferior-lisp-program "sbcl")
(setq common-lisp-hyperspec-root (file-truename custom/hyperspec-root))

(defun custom/lisp-mode-hook ()
  (setq tab-width 4)
  (setq indent-tabs-mode t)
  (abbrev-mode 1)
  (auto-fill-mode 1)
  (turn-on-eldoc-mode)
  (paredit-mode 1)
  (paren-face-mode)
  (setq tab-width 2)
  (setq indent-tabs-mode t)
  )

(defun custom/slime-hook ()
  (slime-mode t)
  (set (make-local-variable 'slime-lisp-implementations)
       (list (assoc 'sbcl slime-lisp-implementations)))
  )

(use-package slime
  :defer t
  :init
  (progn
    (use-package slime-autoloads)
    (add-hook 'lisp-mode-hook 'custom/slime-hook)
    (add-hook 'inferior-lisp-mode-hook (lambda () (inferior-slime-mode t)))
    (add-hook 'slime-mode-hook (lambda () (slime-autodoc-mode t)))
    (add-hook 'lisp-mode-hook 'custom/lisp-mode-hook)
    (add-hook 'lisp-mode-hook 'common-hooks/newline-hook)
    (add-hook 'lisp-mode-hook 'common-hooks/prog-helpers))
  :config
  (progn
    (slime-setup
     '(slime-fancy-inspector slime-fancy-trace slime-fontifying-fu
                             slime-hyperdoc slime-motd slime-package-fu slime-references
                             slime-snapshot slime-sprof slime-trace-dialog slime-xref-browser
                             slime-asdf slime-autodoc slime-banner slime-fancy slime-fuzzy
                             slime-repl slime-sbcl-exts))
    (defadvice slime-documentation-lookup
        (around change-browse-url-browser-function activate)
      "Use w3m for slime documentation lookup."
      (let ((browse-url-browser-function 'w3m-browse-url))
        ad-do-it))
    (setq slime-complete-symbol*-fancy t)
    (setq slime-complete-symbol-function 'slime-fuzzy-complete-symbol)
    (setq slime-net-coding-system 'utf-8-unix)
    (setq slime-lisp-implementations '((clojure ("clj-cmd") :init swank-clojure-init)))
    (setq slime-use-autodoc-mode nil)
    (setq slime-backend (at-config-basedir "el-get/slime/swank-loader.lisp"))
    (add-to-list 'slime-lisp-implementations '(sbcl ("sbcl")  :coding-system utf-8-unix))
    (bind-key "C-c h" 'slime-documentation-lookup slime-repl-mode-map)
    (bind-key "C-c ;" 'slime-insert-balanced-comments lisp-mode-map)
    (bind-key "C-c M-;" 'slime-remove-balanced-comments lisp-mode-map)
    ))

;; lookup information in hyperspec
(info-lookup-add-help
 :mode 'lisp-mode
 :regexp "[^][()'\" \t\n]+"
 :ignore-case t
 :doc-spec '(("(ansicl)Symbol Index" nil nil nil)))

(provide 'rc-lisp)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-lisp.el ends here
