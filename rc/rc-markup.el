;; -*- coding: utf-8 -*-
;;
;; Filename: rc-markup.el
;; Created:  Thu May 1 16:30:43 2014 +0400
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; TODO: integrate docbook-menu into el-get, probable relevant links below
;; http://www.emacswiki.org/emacs/UsingNxmlModeWithDocBook
;; http://www.emacswiki.org/emacs/DocbookXmlMode

(use-package css-eldoc
  :config
  (turn-on-css-eldoc))

(use-package sgml-mode
  :config
  (progn
    (bind-key "C-c C-w" 'html-wrap-in-tag html-mode-map)))

(use-package emmet-mode
  :config
  (progn
    (bind-key "C-j" nil emmet-mode-keymap)
    (bind-key "<C-return>" nil emmet-mode-keymap)
    (bind-key "C-c C-j" 'emmet-expand-line emmet-mode-keymap)
    (setq emmet-move-cursor-between-quotes t)
    (diminish 'emmet-mode)
    (add-hook 'sgml-mode-hook 'emmet-mode)
    (add-hook 'nxml-mode-hook 'emmet-mode)
    (add-hook 'django-mode 'emmet-mode)
    (add-hook 'sgml-mode-hook 'emmet-mode)
    (add-hook 'css-mode-hook 'emmet-mode)
    (add-hook 'emmet-mode-hook
              (lambda () (setq emmet-indentation 2)))
    ))

(use-package markdown-mode
  :config
  (progn
    (bind-key "C-c C-v" 'markdown-preview markdown-mode-map)
    (bind-key "C-<tab>" 'yas/expand markdown-mode-map)))

(use-package yaml-mode)

(defun custom/nxml-mode-hook ()
  (auto-fill-mode)
  (hs-minor-mode 1)
  (local-set-key (kbd "C-c /") 'nxml-finish-element)
  (rng-validate-mode)
  (setq ispell-skip-html t)
  (unify-8859-on-decoding-mode)
  )

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

(add-hook 'nxml-mode-hook 'common-hooks/newline-hook)
(add-hook 'nxml-mode-hook 'custom/nxml-mode-hook)
(add-hook 'css-mode-hook (lambda () (rainbow-mode)))
(add-hook 'django-html-mumamo-mode-hook
          (lambda ()
            (setq django-indent-width 4)
            (setq sgml-basic-offset 4)))
(add-hook 'less-css-mode-hook (lambda ()
                (local-set-key [remap isearch-forward] 'custom/isearch-forward-noeldoc)))
(add-hook 'less-css-mode-hook (lambda ()
                (local-set-key [remap isearch-backward] 'custom/isearch-backward-noeldoc)))

(provide 'rc-markup)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-markup.el ends here
