;; -*- coding: utf-8 -*-
;;
;; Filename: rc-programming.el
;; Created: Пт май 30 22:43:47 2014 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; TODO check if we can use some autoloads below
(require 'tempo)
(require 'doxymacs)
(require 'projectile)

(require 'filecache)
(require 'imenu)
(require 'compile)
(require 'eldoc)

(autoload 'smerge-mode "smerge-mode" nil t)
(autoload 'po-mode "po-mode" "Major mode for translators to edit PO files" t)
(autoload 'gtags-mode "gtags" "" t)
(autoload 'footnote-mode "footnote" nil t) ;; footnote mode
(autoload 'whitespace-mode "whitespace" "Toggle whitespace visualization."        t)
(autoload 'whitespace-toggle-options "whitespace" "Toggle local `whitespace-mode' options." t)
(autoload 'turn-on-eldoc-mode "eldoc" nil t)
(autoload 'magit-status "magit" nil t)
(autoload 'global-git-gutter-mode "git-gutter" nil t)
(autoload 'ecb-activate "ecb" nil t)

(use-package doxymacs
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
  :bind ("C-c h p" . helm-projectile)
  :init
  (use-package helm-projectile)
  :config
  (progn
    (projectile-global-mode) ;; to enable in all buffers
    (setq projectile-enable-caching t)
    (setq projectile-tags-command
          "find %s -type f -print | egrep -v \"/[.][a-zA-Z]\" | etags -")
    (diminish 'projectile-mode "prj")
    (define-key custom-search-keymap (kbd "g") 'custom/projectile-ag)
    (define-key custom-search-keymap (kbd "q") 'projectile-find-file)))

(use-package ecb
  :bind (("C-x t q" . ecb-toggle-ecb-windows)
         ("C-x t d" . ecb-deactivate)))

(use-package flycheck
  :bind (("C-x <up>" . flycheck-previous-error)
         ("C-x <down>" . flycheck-next-error)
         ("C-x !" . flycheck-first-error))
  :config
  (progn
    (add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode)
    (setq flycheck-check-syntax-automatically '(idle-change))))

(use-package eldoc
  :init
  (progn
    (setq eldoc-idle-delay 0) ;; eldoc mode for showing function calls in mode line
    (add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
    (add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
    (diminish 'eldoc-mode "ED")))

(use-package magit
  :bind (("C-c C-g" . magit-blame-mode)
         ("C-c g l" . magit-file-log)
         ("C-c g w" . magit-diff-working-tree)
         ("C-c g r" . magit-reflog)
         ("C-c g c" . magit-checkout)
         ("C-c g r" . magit-add-remote))
  :config
  (add-hook 'magit-status-mode-hook 'magit-filenotify-mode))

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
    (diminish 'git-gutter-mode)))

;; TODO try to autoload someway
(setq gdb-many-windows t)
(setq gdb-show-main t)
(setq gud-chdir-before-run nil)
(setq gud-tooltip-mode t)
(setq gdb-use-separate-io-buffer t)

(setq ediff-window-setup-function 'ediff-setup-windows-plain-merge)

(global-git-gutter-mode +1)

(global-set-key (kbd "C-c g s") 'magit-status)
(global-set-key [(control f9)] (lambda () (interactive) (magit-status default-directory)))
(global-set-key (kbd "C-x t a") 'ecb-activate)

(provide 'rc-programming)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-programming.el ends here
