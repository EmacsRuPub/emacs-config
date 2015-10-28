;; -*- coding: utf-8 -*-
;;
;; Filename: rc-python.el
;; Created:  Thu May 1 16:30:43 2014 +0400
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package pep8 :ensure t)
(use-package python-pep8 :ensure t)

(use-package jedi
  :ensure t
  :init
  (progn
    (setq jedi:complete-on-dot t)
    (setq jedi:goto-definition-marker-ring-length 32))
  :config
  (progn
    (defun custom/python-mode-hook ()
      (auto-fill-mode 1)
      (flycheck-mode)
      ;; (paren-face-mode)
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

(use-package python
  :ensure t
  :defer t
  :config
  (use-package ac-python :ensure auto-complete)
  (bind-key "M-." 'jedi:goto-definition python-mode-map)
  (bind-key "M-," 'jedi:goto-definition-pop-marker python-mode-map)
  (bind-key "+" 'python-indent-shift-right region-bindings-mode-map)
  (bind-key "_" 'python-indent-shift-left region-bindings-mode-map))

; Highlight the call to ipdb
; src http://pedrokroger.com/2010/07/configuring-emacs-as-a-python-ide-2/
(defun annotate-pdb ()
  (interactive)
  (highlight-lines-matching-regexp "import ipdb")
  (highlight-lines-matching-regexp "ipdb.set_trace()"))
(add-hook 'python-mode-hook 'annotate-pdb)

(defhydra hydra-python ()
  "
^Checks:^       ^Nav^
------------------------------------
py_l_int        _p_ylookup at point
pep_8_          find _r_elated names (helm+jedi)
_m_ulti flake8
"
  ("l" pylint)
  ("8" pep8)
  ("m" flake8-multi)
  ("p" pylookup-lookup-at-point)
  ("r" helm-jedi-related-names)
  ("q" nil))
(global-set-key (kbd "C-c C-p") 'hydra-python/body)

(setq mumamo-background-colors nil)

(setenv "PYTHONPATH"
        (concat
         custom/python-libs-path
         (mapconcat 'identity private/python-path-job-projects "")
         (getenv "PYTHONPATH")))
(setenv "PYLINTRC"
        (at-config-basedir
         "contrib/.pylintrc"))

(provide 'rc-python)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-python.el ends here
