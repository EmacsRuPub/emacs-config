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
(autoload 'emmet-mode "emmet-mode")
(autoload 'emmet-expand-line "emmet-mode")
(autoload 'markdown-mode "markdown-mode")

(require 'css-eldoc)

(eval-after-load "sgml-mode"
  '(progn
     (define-key html-mode-map (kbd "C-<down>") 'skip-to-next-blank-line)
     (define-key html-mode-map (kbd "C-<up>") 'skip-to-previous-blank-line)
     (define-key html-mode-map (kbd "C-c C-w") 'html-wrap-in-tag)))

(eval-after-load 'emmet-mode
  '(progn
     (define-key emmet-mode-keymap (kbd "C-j") nil)
     (define-key emmet-mode-keymap (kbd "<C-return>") nil)
     (define-key emmet-mode-keymap (kbd "C-c C-j") 'emmet-expand-line)
     (diminish 'emmet-mode)
     ))

(eval-after-load 'markdown-mode
  '(progn
     (define-key markdown-mode-map (kbd "C-c C-v") 'markdown-preview)
     (define-key markdown-mode-map (kbd "<tab>") 'yas/expand)
     ))

(turn-on-css-eldoc)

(defun custom/nxml-mode-hook ()
  (auto-fill-mode)
  (hs-minor-mode 1)
  (local-set-key (kbd "C-c /") 'nxml-finish-element)
  (rng-validate-mode)
  (setq ispell-skip-html t)
  (unify-8859-on-decoding-mode)
  )

(defun isearch-forward-noeldoc ()
  "close eldoc temperaily"
  (interactive)
  (eldoc-mode -1)
  (isearch-forward)
  (eldoc-mode 1))

(defun isearch-backward-noeldoc ()
  "close eldoc temperaily"
  (interactive)
  (eldoc-mode -1)
  (isearch-backward)
  (eldoc-mode 1))


;#############################################################################
;#   Customizations
;############################################################################
(setq nxml-auto-insert-xml-declaration-flag t)
(setq nxml-bind-meta-tab-to-complete-flag t)
(setq nxml-slash-auto-complete-flag t)
(setq mumamo-background-colors nil)

(push '("<\\?xml" . nxml-mode) magic-mode-alist)

(add-to-list 'hs-special-modes-alist
             '(nxml-mode
               "\\|<[^/>]&>\\|<[^/][^>]*[^/]>"
               ""
               nil))

(setq mumamo-submode-indent-offset 4)
(setq emmet-move-cursor-between-quotes t)

;#############################################################################
;#   Hooks
;############################################################################
(add-hook 'nxml-mode-hook 'common-hooks/comment-hook)
(add-hook 'nxml-mode-hook 'common-hooks/newline-hook)
(add-hook 'nxml-mode-hook 'custom/nxml-mode-hook)
(add-hook 'css-mode-hook (lambda () (rainbow-mode)))
(add-hook 'sgml-mode-hook 'emmet-mode)
(add-hook 'nxml-mode-hook 'emmet-mode)
(add-hook 'django-mode 'emmet-mode)
(add-hook 'sgml-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook 'emmet-mode)
(add-hook 'django-html-mumamo-mode-hook
          (lambda ()
            (setq django-indent-width 4)
            (setq sgml-basic-offset 4)))
(add-hook 'less-css-mode-hook (lambda ()
                (local-set-key [remap isearch-forward] 'isearch-forward-noeldoc)))
(add-hook 'less-css-mode-hook (lambda ()
                (local-set-key [remap isearch-backward] 'isearch-backward-noeldoc)))
(add-hook 'emmet-mode-hook (lambda () (setq emmet-indentation 2)))

(provide 'rc-markup)

;;; rc-markup.el ends here
