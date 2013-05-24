;;; rc-prog-common.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

;#############################################################################
;#   Load Extensions
;############################################################################
(autoload 'smerge-mode "smerge-mode" nil t)
(autoload 'po-mode "po-mode" "Major mode for translators to edit PO files" t)
(autoload 'gtags-mode "gtags" "" t)
(autoload 'footnote-mode "footnote" nil t) ;; footnote mode
(autoload 'whitespace-mode "whitespace" "Toggle whitespace visualization."        t)
(autoload 'whitespace-toggle-options "whitespace" "Toggle local `whitespace-mode' options." t)
(autoload 'turn-on-eldoc-mode "eldoc" nil t)

(require 'filecache)
(require 'imenu)
(require 'compile)
(require 'eldoc)

;#############################################################################
;#   Customizations
;############################################################################
(setq text-mode-hook (quote (turn-on-auto-fill text-mode-hook-identify)))
(setq ediff-window-setup-function 'ediff-setup-windows-plain-merge)

;; ;; eldoc mode for showing function calls in mode line
(setq eldoc-idle-delay 0)

(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)

(provide 'rc-prog-common)

;;; rc-prog-common.el ends here
