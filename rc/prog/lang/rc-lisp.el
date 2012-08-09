;;; emacs-rc-lisp.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

;#############################################################################
;#   Load extensions
;############################################################################
(require 'inf-lisp)
(require 'slime)
;; (require 'slime-autoloads)
(require 'info-look)


;#############################################################################
;#   setup extensions
;############################################################################
(setq slime-backend (concat config-basedir "/ext/slime/swank-loader.lisp"))

;; lookup information in hyperspec
(info-lookup-add-help
 :mode 'lisp-mode
 :regexp "[^][()'\" \t\n]+"
 :ignore-case t
 :doc-spec '(("(ansicl)Symbol Index" nil nil nil)))

(eval-after-load "slime"
  '(progn
     (slime-setup
      '(slime-fancy slime-asdf slime-banner slime-fuzzy slime-autodoc slime-repl helm-slime))
     (setq slime-complete-symbol*-fancy t)
     (setq slime-complete-symbol-function 'slime-fuzzy-complete-symbol)
     ))


;#############################################################################
;#   Customizations
;############################################################################
(setq inferior-lisp-program "sbcl")
(setq slime-net-coding-system 'utf-8-unix)
(setq slime-lisp-implementations '((clojure ("clj-cmd") :init swank-clojure-init)))
(setq slime-use-autodoc-mode nil)

(add-to-list 'slime-lisp-implementations '(sbcl ("sbcl")  :coding-system utf-8-unix))

(setq common-lisp-hyperspec-root "/mnt/work/help/HyperSpec/")

;#############################################################################
;#   Hooks
;############################################################################
(defun custom/lisp-mode-hook ()
  (setq tab-width 4)
  (setq indent-tabs-mode t)
  (abbrev-mode 1)
  (auto-fill-mode 1)
  (turn-on-eldoc-mode)
  ;; (paredit-mode 1)
  (set (make-local-variable 'slime-lisp-implementations)
       (list (assoc 'sbcl slime-lisp-implementations)))
  (setq tab-width 2
  indent-tabs-mode t)
  (local-set-key (kbd "C-c ;") 'slime-insert-balanced-comments)
  (local-set-key (kbd "C-c M-;") 'slime-remove-balanced-comments)
  )

(defun custom/slime-repl-hook ()
  (local-set-key (kbd "C-c C-d h") 'slime-documentation-lookup)
  )

;; Stop SLIME's REPL from grabbing DEL,
;; which is annoying when backspacing over a '('
(defun override-slime-repl-bindings-with-paredit ()
  (define-key slime-repl-mode-map
    (read-kbd-macro paredit-backward-delete-key) nil))
(add-hook 'slime-repl-mode-hook 'override-slime-repl-bindings-with-paredit)

(add-hook 'lisp-mode-hook 'custom/lisp-mode-hook)
(add-hook 'lisp-mode-hook 'common-hooks/comment-hook)
(add-hook 'lisp-mode-hook 'common-hooks/newline-hook)
(add-hook 'lisp-mode-hook 'common-hooks/show-prog-keywords)
(add-hook 'lisp-mode-hook (lambda () (slime-mode t)))
(add-hook 'inferior-lisp-mode-hook (lambda () (inferior-slime-mode t)))
(add-hook 'slime-repl-mode-hook 'custom/slime-repl-hook)
;; (add-hook 'slime-mode-hook (lambda () (slime-autodoc-mode t)))
;; (add-hook 'slime-connected-hook 'slime-ensure-typeout-frame)


;#############################################################################
;#   Keybindings
;############################################################################
(global-set-key (kbd "<f5>") 'slime)
(global-set-key (kbd "<C-f11>") 'slime-selector)

;;; emacs-rc-slime.el ends here
