;; -*- coding: utf-8 -*-
;;
;; Filename: rc-programming.el
;; Created:  Fri May 30 23:45:51 2014 +0400
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'filecache)
(require 'imenu)
(require 'compile)

(autoload 'po-mode "po-mode" "Major mode for translators to edit PO files" t)
(autoload 'gtags-mode "gtags" "" t)

(use-package doxymacs
  :defer t
  :config
  (progn
    (setq-default doxymacs-doxygen-style "JavaDoc")

    (defun custom/doxymacs-font-lock-hook ()
      (if (or (eq major-mode 'c-mode)
              (eq major-mode 'c++-mode))
          (doxymacs-font-lock)))

    (add-hook 'font-lock-mode-hook 'custom/doxymacs-font-lock-hook)
    (add-hook 'c-mode-common-hook 'doxymacs-mode)))

(use-package projectile
  :commands (projectile-find-file custom/projectile-ag)
  :config
  (progn
    (projectile-global-mode) ;; to enable in all buffers
    (setq projectile-enable-caching t)
    (setq projectile-require-project-root nil)
    (setq projectile-switch-project-action 'projectile-dired)
    (setq projectile-completion-system 'helm)
    (setq projectile-tags-command
          "find %s -type f -print | egrep -v \"/[.][a-zA-Z]\" | etags -")
    (diminish 'projectile-mode "prj")
    ))

(use-package ecb
  :defer t
  :bind (("C-x t q" . ecb-toggle-ecb-windows)
         ("C-x t d" . ecb-deactivate)
         ("C-x t a" . ecb-activate)))

(use-package flycheck
  :defer t
  :bind (("C-x <up>" . flycheck-previous-error)
         ("C-x <down>" . flycheck-next-error)
         ("C-x !" . flycheck-first-error))
  :config
  (progn
    (add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode)
    (setq flycheck-check-syntax-automatically '(idle-change))))

(use-package eldoc
  :defer t
  :init
  (progn
    (setq eldoc-idle-delay 0) ;; eldoc mode for showing function calls in mode line
    (add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
    (add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode))
  :idle
  (diminish 'eldoc-mode "ED"))

(use-package magit
  :init
  (progn
    (use-package diminish)
    ;; (use-package magit-filenotify)
    (use-package magit-blame-mode))
  :config
  ;; (add-hook 'magit-status-mode-hook 'magit-filenotify-mode)
  ;; (diminish 'magit-filenotify-mode "FN")
  (global-set-key (kbd "C-c C-g") 'magit-blame-mode)
  ;FIXME:make these custom key use :bind/whatever-appropriate
  (define-key custom-vcs-keymap (kbd "s") 'magit-status)
  (define-key custom-vcs-keymap (kbd "l") 'magit-file-log)
  (define-key custom-vcs-keymap (kbd "w") 'magit-diff-working-tree)
  (define-key custom-vcs-keymap (kbd "r") 'magit-reflog)
  (define-key custom-vcs-keymap (kbd "c") 'magit-checkout)
  )

(use-package git-gutter
  :bind (("C-c <prior>" . git-gutter:next-hunk)
         ("C-c <next>" . git-gutter:previous-hunk))
  :config
  (progn
    (setq git-gutter:modified-sign "?")
    (set-face-attribute 'git-gutter:modified nil :foreground "yellow" :inverse-video nil)
    (set-face-attribute 'git-gutter:added nil :inverse-video nil)
    (set-face-attribute 'git-gutter:deleted nil :inverse-video nil)
    (set-face-attribute 'git-gutter:unchanged nil :inverse-video nil)
    (global-git-gutter-mode +1)
    (diminish 'git-gutter-mode)))

(use-package gud
  :init
  (use-package gdb-mi)
  :config
  (progn
    (setq gdb-many-windows t)
    (setq gdb-show-main t)
    (setq gdb-use-separate-io-buffer t)
    (setq gud-chdir-before-run nil)
    (setq gud-tooltip-mode t)))

(use-package ediff
  :config
  (progn
    (setq ediff-window-setup-function 'ediff-setup-windows-plain)
    (setq ediff-split-window-function 'split-window-horizontally)
    (setq ediff-diff-options "-w")))

(define-key custom-vcs-keymap (kbd "t") 'git-timemachine)

(provide 'rc-programming)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-programming.el ends here
