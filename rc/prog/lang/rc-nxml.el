;;; emacs-rc-nxml.el --- customisation of nXML-mode

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

;; TODO: integrate docbook-menu into el-get, probable relevant links below
;; http://www.emacswiki.org/emacs/UsingNxmlModeWithDocBook
;; http://www.emacswiki.org/emacs/DocbookXmlMode

;#############################################################################
;#   Load extensions
;############################################################################
;; (require 'docbk-menu)
;; (require 'nxml-menu)


;#############################################################################
;#   Customizations
;############################################################################
(setq nxml-attribute-indent 2)
(setq nxml-auto-insert-xml-declaration-flag t)
(setq nxml-bind-meta-tab-to-complete-flag t)
(setq nxml-slash-auto-complete-flag t)

(push '("<\\?xml" . nxml-mode) magic-mode-alist)

(add-to-list 'hs-special-modes-alist
             '(nxml-mode
               "\\|<[^/>]&>\\|<[^/][^>]*[^/]>"
               ""
               nil))


;#############################################################################
;#   Hooks
;############################################################################
(defun custom/nxml-mode-hook ()
  (auto-fill-mode)
  (hs-minor-mode 1)
  (local-set-key "\C-c/" 'nxml-finish-element)
  (rng-validate-mode)
  (setq ispell-skip-html t)
  (unify-8859-on-decoding-mode)
  )
(add-hook 'nxml-mode-hook 'common-hooks/comment-hook)
(add-hook 'nxml-mode-hook 'common-hooks/newline-hook)
(add-hook 'nxml-mode-hook 'custom/nxml-mode-hook)
;; (add-hook 'nxml-mode-hook 'docbook-menu-mode)

;;; emacs-nxml.el ends here
