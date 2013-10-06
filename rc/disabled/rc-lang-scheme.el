;;; emacs-rc-scheme.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

;; TODO: test out Geiser
;; http://www.google.com/url?sa=D&q=http://gitorious.org/geiser
;; https://github.com/jaor/geiser
;; git://git.sv.gnu.org/geiser.git
;; http://comments.gmane.org/gmane.lisp.scheme.geiser/20
;; http://www.nongnu.org/geiser/geiser_3.html
;; http://programming-musings.org/2009/05/14/geiser/
;; http://www.nongnu.org/geiser/geiser_4.html

;#############################################################################
;#   Load extensions
;############################################################################
(autoload 'run-scheme "cmuscheme" "Run an inferior Scheme" t)

(require 'quack)

(require 'defun-scheme)

;#############################################################################
;#   Customizations
;############################################################################
(setq scheme-program-name "mzscheme")
(setq quack-remap-find-file-bindings-p nil)
;; for Geiser; keep them
;; (setq geiser-impl-installed-implementations '(plt guile))
;; (setq geiser-impl-default-implementation 'plt)

;#############################################################################
;#   Hooks
;############################################################################
(defun custom/scheme-mode-hook ()
  "My customization of Scheme Mode"
  (turn-on-eldoc-mode)
  ;; (paredit-mode +1)
  (local-set-key (kbd "C-c \;") 'insert-balanced-comments)
  (local-set-key (kbd "C-c :") 'remove-balanced-comments)
  (local-set-key (kbd "<f1>") 'r5rs-call)
)

(add-hook 'scheme-mode-hook 'common-hooks/newline-hook)
(add-hook 'scheme-mode-hook 'custom/scheme-mode-hook)
(add-hook 'scheme-mode-hook 'common-hooks/comment-hook)
(add-hook 'scheme-mode-hook 'common-hooks/prog-helpers)
(add-hook 'inferior-scheme-mode-hook '(lambda () (split-window)))

(provide 'rc-lang-scheme)

;;; emacs-rc-scheme.el ends here
