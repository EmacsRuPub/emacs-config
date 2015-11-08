;; -*- coding: utf-8 -*-
;;
;; Filename: rc-programming.el
;; Created:  Fri May 30 23:45:51 2014 +0400
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package filecache)
(use-package imenu)
(use-package compile)
(use-package gtags)
(use-package c-eldoc :ensure t)
(use-package eldoc-eval :ensure t)
(use-package hide-comnt :ensure t)
(use-package regex-tool :ensure t)

(use-package projectile
  :ensure t
  :commands (projectile-find-file custom/projectile-ag)
  :config
  (progn
    (projectile-global-mode) ;; to enable in all buffers
    (setq projectile-enable-caching t)
    (setq projectile-cache-file (at-data-dir "/projectile.cache"))
    (setq projectile-known-projects-file (at-data-dir "/projectile-bookmarks.eld"))
    (setq projectile-require-project-root nil)
    (setq projectile-switch-project-action 'helm-projectile)
    (setq projectile-completion-system 'ivy)
    (setq projectile-tags-command
          "find %s -type f -print | egrep -v \"/[.][a-zA-Z]\" | etags -")
    (add-to-list 'projectile-other-file-alist '("html" "js"))
    (add-to-list 'projectile-other-file-alist '("js" "html"))
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
      ("fd" helm-projectile-find-dir)
      ("ft" projectile-find-test-file)
      ("ff" helm-projectile-find-file)
      ("fw" helm-projectile-find-file-dwim)
      ("ft" projectile-find-file-dwim-other-window)
      ("fo" helm-projectile-find-other-file)
      ("fO" projectile-find-other-file-other-window)
      ("pb" projectile-ibuffer)
      ("pf" projectile-project-info)
      ("pt" projectile-test-project)
      ("pc" projectile-compile-project)
      ("pi" projectile-invalidate-cache)
      ("pk" projectile-kill-buffers)
      ("ps" projectile-switch-project)
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
  :ensure t
  :init
  (use-package flycheck-color-mode-line :ensure t)
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
  :config
  (diminish 'eldoc-mode "ED"))

(use-package magit
  :ensure t
  :config
  (bind-key "E" 'magit-rebase-interactive magit-status-mode-map)
  (setq magit-blame-heading-format "%H %-20a %C %s")
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
    ("f" magit-log-buffer-file)
    ("c" magit-checkout)
    ("w" magit-diff-working-tree)
    ("r" magit-reflog)
    ("b" magit-blame)
    ("B" magit-branch-manager)
    ("l" magit-log)
    ("t" git-timemachine))
  (global-set-key (kbd "C-'") 'hydra-magit/body))

(use-package magit-gh-pulls
  :ensure t
  :config
  (add-hook 'magit-mode-hook 'turn-on-magit-gh-pulls))

(use-package magit-gerrit
  :ensure t
  :disabled t
  :config
  (setq-default magit-gerrit-ssh-creds "aermolov@review.fuel-infra.org")
  (setq-default magit-gerrit-remote "gerrit"))

(use-package magit-filenotify
  :ensure t
  :config
  (use-package diminish :ensure t) ;;TODO: relocate to toplevel and try using :command so it may be autoloaded
  (add-hook 'magit-status-mode-hook 'magit-filenotify-mode)
  (diminish 'magit-filenotify-mode "FN"))

(use-package git-gutter
  :ensure t
  :config
  (progn
    (setq git-gutter:modified-sign "?")
    (set-face-attribute 'git-gutter:modified nil :foreground "yellow" :inverse-video nil)
    (set-face-attribute 'git-gutter:added nil :inverse-video nil)
    (set-face-attribute 'git-gutter:deleted nil :inverse-video nil)
    (set-face-attribute 'git-gutter:unchanged nil :inverse-video nil)
    (global-git-gutter-mode +1)))

(use-package git-timemachine :ensure t)

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

(defun pgsql-c-mode ()
  ;; sets up formatting for PostgreSQL C code
  (interactive)
  (c-mode)
  (setq-default tab-width 4)
  (c-set-style "bsd")             ; set c-basic-offset to 4, plus other stuff
  (c-set-offset 'case-label '+)   ; tweak case indent to match PG custom
  (setq fill-column 79)           ; matches what pgindent does
  (setq indent-tabs-mode t))      ; make sure we keep tabs when indenting

(provide 'rc-programming)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-programming.el ends here
