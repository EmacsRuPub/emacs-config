;; -*- coding: utf-8 -*-
;;
;; Filename: rc-perl.el
;; Created:  Thu May 1 16:30:43 2014 +0400
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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
  (setq tab-width 2)
  (setq indent-tabs-mode nil))

(add-hook 'perl-mode-hook 'custom/perl-mode-hook)
(add-hook 'perl-mode-hook 'common-hooks/comment-hook)
(add-hook 'perl-mode-hook 'common-hooks/prog-helpers)
(add-hook 'perl-mode-hook 'common-hooks/newline-hook)

(provide 'rc-perl)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-perl.el ends here
