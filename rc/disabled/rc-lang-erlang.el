;;; emacs-rc-erlang.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

;; TODO: See esense + erlware
;; http://www.erlware.org/
;; http://esense.sourceforge.net/

;#############################################################################
;#   Load extensions
;############################################################################
;; (require 'erlang-start)
;; (require 'distel)
;; (require 'esense-start)


;#############################################################################
;#   Setup
;############################################################################
;(distel-setup)


;#############################################################################
;#   Custom definitions
;############################################################################
;; flymake for erlang
(defun flymake-erlang-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    (list "~/emacs/bin/eflymake" (list local-file))))


;#############################################################################
;#   Customizations
;############################################################################
;; (add-to-list 'flymake-allowed-file-name-masks
;;              '("\\.erl\\'" flymake-erlang-init))

;; A number of the erlang-extended-mode key bindings are useful in the shell too
(defconst distel-shell-keys
  '(((kbd "<C-M-i>")  erl-complete)
    ((kbd "M-?")      erl-complete)
    ((kbd "M-.")      erl-find-source-under-point)
    ((kbd "M-,")      erl-find-source-unwind)
    ((kbd "M-*")      erl-find-source-unwind)
    )
  "Additional keys to bind when in Erlang shell.")

;; (setq esense-indexer-program "~/emacs/esense/esense.sh")
(setq erlang-root-dir "/usr/lib/erlang")
(setq erlang-man-root-dir "/usr/lib/erlang/man")
(add-to-list 'exec-path "/usr/lib/erlang/bin")


;#############################################################################
;#   Hooks
;############################################################################
(defun custom/erlang-mode-hook ()
  ;; when starting an Erlang shell in Emacs, default in the node name
  (setq inferior-erlang-machine-options '("-sname" "emacs"))
  ;; add Erlang functions to an imenu menu
  (imenu-add-to-menubar "imenu")
  (when (and buffer-file-name
             (string-match "flymake" buffer-file-name))
    (flymake-mode -1))
  ;; keys
  )
(add-hook 'erlang-mode-hook 'custom/erlang-mode-hook)
(add-hook 'erlang-mode-hook 'common-hooks/comment-hook)
(add-hook 'erlang-mode-hook 'common-hooks/show-prog-keywords)
(add-hook 'erlang-mode-hook 'common-hooks/newline-hook)
(add-hook 'erlang-shell-mode-hook
          (lambda ()
            ;; add some Distel bindings to the Erlang shell
            (dolist (spec distel-shell-keys)
              (define-key erlang-shell-mode-map (car spec) (cadr spec)))))

(provide 'rc-lang-erlang)

;;; emacs-rc-erlang.el ends here
