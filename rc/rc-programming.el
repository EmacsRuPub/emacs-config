;; -*- coding: utf-8 -*-
;;
;; Filename: rc-programming.el
;; Created:  Fri May 30 23:45:51 2014 +0400
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package filecache)
(use-package imenu)
(use-package compile)
(use-package po-mode)
(use-package gtags)

(use-package doxymacs
  :defer t
  :config
  (progn
    (setq-default doxymacs-doxygen-style "JavaDoc")

    ;TODO: generalize
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
    (setq projectile-switch-project-action 'projectile-find-file)
    (setq projectile-completion-system 'helm)
    (setq projectile-tags-command
          "find %s -type f -print | egrep -v \"/[.][a-zA-Z]\" | etags -")
    (diminish 'projectile-mode "prj")
    (defhydra hydra-projectile (:color teal)
      "
PROJECT: %(projectile-project-root)
find                         Project               More
---------------------------------------------------------------------------------------
_fd_irectory                 i_pb_uffer            _c_ommander
_ft_est file                 in_pf_o               _s_witch to buffer
_ff_ile                      run _pt_ests          switch to buffer (other _w_indow)
file d_fw_im                 _pc_ompile            _d_ired
file o_ft_her window         _pi_nvalidate cache   display _b_uffer
_fo_ther file                _pk_ill buffers       _r_ecentf
other file _fO_ther window
"
      ("fd" projectile-find-dir)
      ("ft" projectile-find-test-file)
      ("ff" projectile-find-file)
      ("fw" projectile-find-file-dwim)
      ("ft" projectile-find-file-dwim-other-window)
      ("fo" projectile-find-other-file)
      ("fO" projectile-find-other-file-other-window)
      ("pb" projectile-ibuffer)
      ("pf" projectile-project-info)
      ("pt" projectile-test-project)
      ("pc" projectile-compile-project)
      ("pi" projectile-invalidate-cache)
      ("pk" projectile-kill-buffers)
      ("c" projectile-commander)
      ("s" projectile-switch-to-buffer)
      ("w" projectile-switch-to-buffer-other-window)
      ("d" projectile-dired)
      ("b" projectile-display-buffer)
      ("r" projectile-recentf)
      ;;TODO: write legend
      ("s" projectile-run-command-in-root)
      ("S" projectile-run-async-shell-command-in-root))
    (global-set-key (kbd "<f8>") 'hydra-projectile/body)
    ))

(use-package flycheck
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
    (add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
    (add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)
    (add-hook 'c-mode-hook 'c-turn-on-eldoc-mode)
    (add-hook 'c++-mode-hook 'c-turn-on-eldoc-mode)
    (add-hook 'css-mode-hook 'turn-on-css-eldoc))
  :idle
  (diminish 'eldoc-mode "ED"))

(use-package magit
  :init
  (progn
    (use-package diminish)
    (use-package magit-filenotify))
  :config
  (add-hook 'magit-status-mode-hook 'magit-filenotify-mode)
  (diminish 'magit-filenotify-mode "FN")
  (setq watches-count-threshold 50)
  (setq magit-last-seen-setup-instructions "1.4.0")
  (defhydra hydra-magit (:color teal :hint nil)
    "
PROJECT: %(projectile-project-root)

     Immuting            Mutating
-----------------------------------------
  _s_: status          _c_: checkout
  _l_: log             _B_: branch mgr
  _f_: file log
  _r_: reflog
  _w_: diff worktree
  _t_: time machine
  _b_: blame
"
    ("s" magit-status)
    ("f" magit-file-log)
    ("c" magit-checkout)
    ("w" magit-diff-working-tree)
    ("r" magit-reflog)
    ("b" magit-blame-mode)
    ("B" magit-branch-manager)
    ("l" magit-log)
    ("t" git-timemachine))
  (global-set-key (kbd "C-'") 'hydra-magit/body))

(use-package git-gutter
  :config
  (progn
    (setq git-gutter:modified-sign "?")
    (set-face-attribute 'git-gutter:modified nil :foreground "yellow" :inverse-video nil)
    (set-face-attribute 'git-gutter:added nil :inverse-video nil)
    (set-face-attribute 'git-gutter:deleted nil :inverse-video nil)
    (set-face-attribute 'git-gutter:unchanged nil :inverse-video nil)
    (global-git-gutter-mode +1)))

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

(use-package coverlay
  :config
  ;; TODO: make hydra
  (bind-key "C-c l" 'coverlay-load-file)
  (bind-key "C-c s" 'coverlay-parse-buffer))

(add-hook 'prog-mode-hook 'paredit-everywhere-mode)

(provide 'rc-programming)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-programming.el ends here
