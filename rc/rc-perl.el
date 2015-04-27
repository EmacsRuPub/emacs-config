;; -*- coding: utf-8 -*-
;;
;; Filename: rc-perl.el
;; Created:  Thu May 1 16:30:43 2014 +0400
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package cperl
  :defer t
  :command perl-mode
  :config
  (progn
    (setq cperl-hairy t)
    (setq cperl-auto-newline-after-colon t)
    (setq cperl-autoindent-on-semi t)
    (setq cperl-extra-newline-before-brace nil)
    (setq cperl-indent-parens-as-block t)))

(defun custom/perl-mode-hook ()
  (cperl-mode 1)
  (setq compile-command (concat "perl -cw " buffer-file-name))
  (setq indent-tabs-mode nil)
  (setq tab-width 2)
  (turn-on-eldoc-mode))

(add-hook 'perl-mode-hook 'custom/perl-mode-hook)
(add-hook 'perl-mode-hook 'common-hooks/prog-helpers)
(add-hook 'perl-mode-hook 'common-hooks/newline-hook)

(provide 'rc-perl)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-perl.el ends here
