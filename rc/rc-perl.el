;;; emacs-rc-perl.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

;#############################################################################
;#   Load extensions
;############################################################################
(autoload 'perl-mode "cperl-mode" "alternate mode for editing Perl progs" t)


;#############################################################################
;#   Customizations
;############################################################################
(setq cperl-hairy t)
(setq cperl-auto-newline-after-colon t)
(setq cperl-autoindent-on-semi t)
(setq cperl-extra-newline-before-brace nil)
(setq cperl-indent-parens-as-block t)


;#############################################################################
;#   Hooks
;############################################################################
(defun custom/perl-mode-hook ()
  (setq indent-tabs-mode nil)
  (abbrev-mode 1)
  (turn-on-eldoc-mode)
  (cperl-mode)
  (setq compile-command (concat "perl -cw " buffer-file-name))
  (cperl-mode 1)
  (setq tab-width 2
  indent-tabs-mode nil)
  )
(add-hook 'perl-mode-hook 'custom/perl-mode-hook)
(add-hook 'perl-mode-hook 'common-hooks/comment-hook)
(add-hook 'perl-mode-hook 'common-hooks/prog-helpers)
(add-hook 'perl-mode-hook 'common-hooks/newline-hook)

(provide 'rc-perl)

;;; emacs-rc-perl.el ends here
