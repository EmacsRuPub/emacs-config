;;; emacs-rc-haskell.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

;#############################################################################
;#   Load extensions
;############################################################################
;; (autoload 'turn-on-haskell-ghci "haskell-ghci" "Turn on interaction with a GHCi interpreter." t)
(autoload 'haskell-indent-cycle "haskell-indent" "Indentation cycle for Haskell" t)
;; (autoload 'ghc-init "ghc" nil t)

(load (concat config-basedir "ext/haskell-mode/haskell-site-file.el"))

(require 'hs-lint)
(require 'inf-haskell)
(require 'haskell-mode)

;#############################################################################
;#   Customizations
;############################################################################
(setq haskell-program-name "ghci")
(setq inferior-haskell-wait-and-jump t)
(setq hs-lint-replace-with-suggestions t)


;#############################################################################
;#   Custom definitions
;############################################################################
(defun flymake-get-Haskell-cmdline (source base-dir)
  (list "ghc"
        (append
         (list "--make" (concat "-i" base-dir) source)
         flymake-ghc-options
         flymake-ghc-packages)))

(defun flymake-Haskell-init ()
  (flymake-simple-make-init-impl
   'flymake-create-temp-inplace
   nil nil
   (file-name-nondirectory buffer-file-name)
   'flymake-get-Haskell-cmdline))

(defun flymake-Haskell-cleanup ()
  (delete-file flymake-temp-source-file-name))

;; flymake settings for ghc
(defvar flymake-ghc-options (list "-Wall"))
(defvar flymake-ghc-packages (mapcar (lambda (p) (concat "-package " p)) '("QuickCheck")))


;#############################################################################
;#   Hooks
;############################################################################
(defun my-haskell-mode-hook ()
  ;; (turn-on-haskell-doc-mode)
  (turn-on-haskell-ghci)
  (turn-on-eldoc-mode)
  (turn-on-haskell-indent)
  (local-set-key (kbd "<tab>") 'haskell-indent-cycle)
  (local-set-key (kbd "C-c l") 'hs-lint)
  (local-set-key (kbd "C-c h") 'haskell-hoogle)
  (local-set-key (kbd "C-c C-h") 'haskell-hayoo)
  (setq tab-width 4)
  (setq haskell-font-lock-symbols t)
  )
(add-hook 'haskell-mode-hook 'my-haskell-mode-hook)
;; (add-hook 'haskell-mode-hook 'turn-on-haskell-ghci)
(add-hook 'haskell-mode-hook 'common-hooks/comment-hook)
(add-hook 'haskell-mode-hook 'common-hooks/show-prog-keywords)
(add-hook 'haskell-mode-hook 'common-hooks/newline-hook)
;; (add-hook 'haskell-mode-hook (lambda () (ghc-init)))


;#############################################################################
;#   Trial
;############################################################################

;; haskell-mode-exts

(require 'haskell-align-imports)
(require 'haskell-navigate-imports)
(require 'haskell-sort-imports)

(define-key haskell-mode-map (kbd "C-c .") 'haskell-align-imports)
(define-key haskell-mode-map (kbd "<f8>") 'haskell-navigate-imports)
(define-key haskell-mode-map (kbd "<f6>") 'haskell-goto-imports)
(define-key haskell-mode-map (kbd "<f7>") 'haskell-return-from-imports)
(define-key haskell-mode-map (kbd "C-c ,") 'haskell-sort-imports)

(provide 'rc-lang-haskell)

;;; emacs-rc-haskell.el ends here

;; (defun flymake-get-Haskell-cmdline (source base-dir)
;;   (list "ghc"
;;         (append
;;          (list "--make" (concat "-i" base-dir) source)
;;          flymake-ghc-options
;;          flymake-ghc-packages)))

;; (defun flymake-Haskell-init ()
;;   (flymake-simple-make-init-impl
;;    'flymake-create-temp-inplace
;;    nil nil
;;    (file-name-nondirectory buffer-file-name)
;;    'flymake-get-Haskell-cmdline))

;; (defun flymake-Haskell-cleanup ()
;;   (delete-file flymake-temp-source-file-name))

;; ;; flymake settings for ghc
;; (defvar flymake-ghc-options (list "-Wall"))
;; (defvar flymake-ghc-packages (mapcar (lambda (p) (concat "-package " p)) '("QuickCheck")))


;; (defun my-haskell-mode-hook ()
;;   ;; (turn-on-haskell-doc-mode)
;;   (turn-on-haskell-ghci)
;;   (turn-on-eldoc-mode)
;;   (turn-on-haskell-indent)
;;   (local-set-key (kbd "<tab>") 'haskell-indent-cycle)
;;   (local-set-key (kbd "C-c l") 'hs-lint)
;;   (local-set-key (kbd "C-c h") 'haskell-hoogle)
;;   (local-set-key (kbd "C-c C-h") 'haskell-hayoo)
;;   (setq tab-width 4)
;;   (setq haskell-font-lock-symbols t)
;;   )
;; (add-hook 'haskell-mode-hook 'my-haskell-mode-hook)
;; ;; (add-hook 'haskell-mode-hook 'turn-on-haskell-ghci)
;; (add-hook 'haskell-mode-hook 'common-hooks/comment-hook)
;; (add-hook 'haskell-mode-hook 'common-hooks/show-prog-keywords)
;; (add-hook 'haskell-mode-hook 'common-hooks/newline-hook)
;; ;; (add-hook 'haskell-mode-hook (lambda () (ghc-init)))


;; (define-key haskell-mode-map (kbd "C-c .") 'haskell-align-imports)
;; (define-key haskell-mode-map (kbd "<f8>") 'haskell-navigate-imports)
;; (define-key haskell-mode-map (kbd "<f6>") 'haskell-goto-imports)
;; (define-key haskell-mode-map (kbd "<f7>") 'haskell-return-from-imports)
;; (define-key haskell-mode-map (kbd "C-c ,") 'haskell-sort-imports)
