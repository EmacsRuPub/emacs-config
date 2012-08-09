;;; emacs-rc-shell.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

;#############################################################################
;#   Eshell
;############################################################################
(require 'ansi-color)
(require 'eshell)

(defun eshell-handle-ansi-color ()
      (ansi-color-apply-on-region eshell-last-output-start
                                  eshell-last-output-end))
    (add-to-list 'eshell-output-filter-functions 'eshell-handle-ansi-color)


;#############################################################################
;#   Shell
;############################################################################
;; (global-set-key (kbd "C-c z") (lambda () (interactive) (ansi-term "/bin/zsh")))

;; test

;; (require 'multi-term)
;; (setq multi-term-program "/bin/zsh")

;; Usage

;; multi-term.el provides the following interactive functions:

;;     “multi-term” – Create a new terminal buffer.
;;     “multi-term-next” – Switch to next terminal buffer.
;;     “multi-term-prev” – Switch to previous terminal buffer.
;;     “multi-term-dedicated-open” – Open dedicated terminal buffer.
;;     “multi-term-dedicated-close” – Close dedicated terminal window.
;;     “multi-term-dedicated-toggle” – Toggle dedicated terminal window.
;;     “multi-term-dedicated-select” – Select dedicated terminal window.

;;; emacs-rc-shell.el ends here
