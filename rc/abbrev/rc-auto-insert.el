;;; emacs-rc-auto-insert.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

;; auto-insert stuff
(add-hook 'find-file-hooks 'auto-insert)

(setq auto-insert-directory custom/auto-insert-dir)
(setq auto-insert 'other)
(setq auto-insert-query nil)

(setq auto-insert-alist '(("\\.muse$" . ["insert.muse"])))
(add-to-list 'auto-insert-alist '("\\.sh$" . ["insert.sh" auto-update-defaults]))
(add-to-list 'auto-insert-alist '("\\.lisp$" . ["insert.lisp" auto-update-defaults]))
(add-to-list 'auto-insert-alist '("\\.cl$" . ["insert.lisp" auto-update-defaults]))
(add-to-list 'auto-insert-alist '("\\.el$" . ["insert.el" auto-update-defaults]))
(add-to-list 'auto-insert-alist '("\\.erl$" . ["insert.erl" auto-update-defaults]))
(add-to-list 'auto-insert-alist '("\\.java$" . ["insert.java" auto-update-defaults]))
(add-to-list 'auto-insert-alist '(".*/projects/.*\\.cpp$" . ["insert-home.cpp" auto-update-c-source-file]))
(add-to-list 'auto-insert-alist '(".*/projects/.*\\.h$"   . ["insert-home.h" auto-update-header-file]))
(add-to-list 'auto-insert-alist '(".*/projects/.*\\.hpp$"   . ["insert-home.h" auto-update-header-file]))
(add-to-list 'auto-insert-alist '(".*/projects/.*\\.c$" . ["insert-home.cpp" auto-update-c-source-file]))
(add-to-list 'auto-insert-alist '("\\.cpp$" . ["insert-home.cpp" auto-update-c-source-file]))
(add-to-list 'auto-insert-alist '("\\.h$"   . ["insert-home.h" auto-update-header-file]))
(add-to-list 'auto-insert-alist '("\\.c$" . ["insert-home.cpp" auto-update-c-source-file]))

;;; emacs-rc-auto-insert.el ends here
