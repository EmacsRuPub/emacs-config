;;; rc-markup.el ---

;; Copyright (C) 2012 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:

;; TODO: integrate docbook-menu into el-get, probable relevant links below
;; http://www.emacswiki.org/emacs/UsingNxmlModeWithDocBook
;; http://www.emacswiki.org/emacs/DocbookXmlMode

;#############################################################################
;#   Load extensions
;############################################################################
(autoload 'zencoding-mode "zencoding-mode")
(autoload 'zencoding-expand-line "zencoding-mode")

(eval-after-load "sgml-mode"
  '(progn
     (define-key html-mode-map (kbd "C-<down>") 'skip-to-next-blank-line)
     (define-key html-mode-map (kbd "C-<up>") 'skip-to-previous-blank-line)
     (define-key html-mode-map (kbd "C-c C-w") 'html-wrap-in-tag)))

(eval-after-load 'zencoding-mode
  '(progn
     (define-key zencoding-mode-keymap (kbd "C-j") nil)
     (define-key zencoding-mode-keymap (kbd "<C-return>") nil)
     (define-key zencoding-mode-keymap (kbd "C-c C-j") 'zencoding-expand-line)
     (defun zencoding-indent (text)
       "Indent the text"
       (if text
           (replace-regexp-in-string "\n" "\n " (concat "\n" text))
         nil))
     (diminish 'zencoding-mode)
     ))

;#############################################################################
;#   Customizations
;############################################################################
(setq nxml-auto-insert-xml-declaration-flag t)
(setq nxml-bind-meta-tab-to-complete-flag t)
(setq nxml-slash-auto-complete-flag t)

(push '("<\\?xml" . nxml-mode) magic-mode-alist)

(add-to-list 'hs-special-modes-alist
             '(nxml-mode
               "\\|<[^/>]&>\\|<[^/][^>]*[^/]>"
               ""
               nil))

(setq mumamo-submode-indent-offset 4)

;#############################################################################
;#   Hooks
;############################################################################
(add-hook 'django-html-mumamo-mode-hook
          (lambda ()
            (setq django-indent-width 4)
            (setq sgml-basic-offset 4)))

;; (add-hook 'django-html-mode-hook
;;           (lambda ()
;;             (setq django-indent-width 4)
;;             (setq sgml-basic-offset 4)))

(add-hook 'sgml-mode-hook 'zencoding-mode)

(setq mumamo-background-colors nil)

(defun custom/nxml-mode-hook ()
  (auto-fill-mode)
  (hs-minor-mode 1)
  (local-set-key (kbd "C-c /") 'nxml-finish-element)
  (rng-validate-mode)
  (setq ispell-skip-html t)
  (unify-8859-on-decoding-mode)
  )
(add-hook 'nxml-mode-hook 'common-hooks/comment-hook)
(add-hook 'nxml-mode-hook 'common-hooks/newline-hook)
(add-hook 'nxml-mode-hook 'custom/nxml-mode-hook)

(add-hook 'css-mode-hook (lambda () (rainbow-mode)))

;; ;; mumamo, like mumin
;; (add-hook 'nxhtml-mumamo-mode-hook
;;           (lambda ()
;;             (setq nxhtml-validation-header-if-mumamo 1)
;; ;;            (nxhtml-validation-header-mode 1)
;;             (rng-validate-mode nil)
;;             (mumamo-post-command)))

(provide 'rc-lang-markup)

;;; rc-markup.el ends here
