;; -*- coding: utf-8 -*-
;;
;; Filename: rc-python.el
;; Created:  Thu May 1 16:30:43 2014 +0400
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package jedi
  :pre-load
  (progn
    (setq jedi:complete-on-dot t)
    (setq jedi:goto-definition-marker-ring-length 32))
  :config
  (progn
    (defun custom/python-mode-hook ()
      (auto-fill-mode 1)
      (flycheck-mode)
      (paren-face-mode)
      (setq flycheck-checker 'python-flake8)
      (setq indent-tabs-mode nil)
      (setq tab-width 4)
      ;;FIXME: find-project-flake8-config id somehow broken
      ;; (setq flycheck-flake8rc (or (custom/find-project-flake8-config) flycheck-flake8rc))
      )
    (add-hook 'python-mode-hook 'custom/python-mode-hook)
    (add-hook 'python-mode-hook 'common-hooks/prog-helpers)
    (add-hook 'python-mode-hook 'common-hooks/newline-hook)
    (add-hook 'python-mode-hook
              (lambda ()
                (setq imenu-create-index-function 'imenu-default-create-index-function)))
    (add-hook 'python-mode-hook 'yas/minor-mode-on)
    (add-hook 'python-mode-hook 'jedi:setup)
    (add-hook 'python-mode-hook 'jedi:ac-setup)
    ))

(use-package flake8-multi
  :defer t
  :bind ("C-c f" . flake8-multi)
  :config
  (setq flake8-multi/exclude-patterns '("env" "site-packages" "old")))

(use-package pylookup
  :defer t
  :config
  (progn
    ;; set executable file and db file
    (setq pylookup-program (at-pylookup-dir "/pylookup.py"))
    (setq pylookup-db-file (at-pylookup-dir "/pylookup.db"))
    ;; set search option if you want
    (setq pylookup-search-options '("--insensitive" "0" "--desc" "0"))
    (defadvice pylookup-lookup
        (around change-browse-url-browser-function activate)
      "Use w3m for slime documentation lookup."
      (let ((browse-url-browser-function 'w3m-browse-url))
        ad-do-it))))

(use-package python-mode
  :defer t
  :config
  (progn
    (bind-key "C-c l" 'pylint python-mode-map)
    (bind-key "C-c p e" 'pep8 python-mode-map)
    (bind-key "C-c h" 'pylookup-lookup-at-point python-mode-map)
    (bind-key "C-c [" 'python-nav-beginning-of-block python-mode-map)
    (bind-key "C-c 9" 'python-nav-beginning-of-statement python-mode-map)
    (bind-key "C-c <up>" 'python-nav-backward-up-list python-mode-map)
    (bind-key "C-c ," 'python-nav-backward-block python-mode-map)
    (bind-key "C-c <left>" 'python-nav-backward-statement python-mode-map)
    (bind-key "C-c <right>" 'python-nav-forward-statement python-mode-map)
    (bind-key "C-c ." 'python-nav-forward-block python-mode-map)
    (bind-key "C-c <down>" 'python-nav-end-of-defun python-mode-map)
    (bind-key "C-c 0" 'python-nav-end-of-statement python-mode-map)
    (bind-key "C-c ]" 'python-nav-end-of-block python-mode-map)
    (bind-key "C-M-f" 'python-nav-forward-sexp python-mode-map)
    (bind-key "C-c 6" 'custom/insert-debugger-statements python-mode-map)
    (bind-key "C-c r" 'helm-jedi-related-names python-mode-map) ;NOTE: just to memory the existence for the first time
    (bind-key "C-M-." 'python-indent-shift-right python-mode-map)
    (bind-key "C-M-," 'python-indent-shift-left python-mode-map)
    (bind-key "+" 'python-indent-shift-right region-bindings-mode-map)
    (bind-key "_" 'python-indent-shift-left region-bindings-mode-map)
    ))

(setq mumamo-background-colors nil)

(setenv "PYTHONPATH"
        (concat
         custom/python-libs-path
         (mapconcat 'identity private/python-path-job-projects "")
         (getenv "PYTHONPATH")))
(setenv "PYLINTRC"
        (at-config-basedir
         "contrib/.pylintrc"))

(defhydra hydra-python-nav (global-map "C-x y")
  ("["       python-nav-beginning-of-block)
  ("9"       python-nav-beginning-of-statement)
  ("<up>"    python-nav-backward-up-list)
  (","       python-nav-backward-block)
  ("<left>"  python-nav-backward-statement)
  ("<right>" python-nav-forward-statement)
  ("."       python-nav-forward-block)
  ("<down>"  python-nav-end-of-defun)
  ("0"       python-nav-end-of-statement)
  ("]"       python-nav-end-of-block)
  ("f"       python-nav-forward-sexp)
  ("q" nil "cancel"))

(provide 'rc-python)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-python.el ends here
