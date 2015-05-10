;; -*- coding: utf-8 -*-
;;
;; Filename: rc-haskell.el
;; Created:  Thu May 1 16:30:43 2014 +0400
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package haskell-mode)
(use-package hs-lint)
(use-package haskell-align-imports)
(use-package haskell-navigate-imports)
(use-package haskell-sort-imports)
(use-package inf-haskell)
(use-package haskell-ghci)
(use-package haskell-indent)

(setq haskell-program-name "ghci")
(setq hs-lint-replace-with-suggestions t)
(setq inferior-haskell-wait-and-jump t)
(setq haskell-doc-show-global-types t)
(setq haskell-program-name "ghci \"+.\"")

(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
(add-hook 'haskell-mode-hook 'turn-on-eldoc-mode)
(add-hook 'haskell-mode-hook 'common-hooks/newline-hook)
(add-hook 'haskell-mode-hook 'common-hooks/prog-helpers)
(add-hook 'haskell-mode-hook 'turn-on-haskell-ghci)

(define-key haskell-mode-map (kbd "C-,") 'haskell-move-nested-left)
(define-key haskell-mode-map (kbd "C-.") 'haskell-move-nested-right)
(define-key haskell-mode-map (kbd "<tab>") 'haskell-indent-cycle)
(define-key haskell-mode-map (kbd "C-c l") 'hs-lint)
(define-key haskell-mode-map (kbd "C-c h") 'haskell-hoogle)
(define-key haskell-mode-map (kbd "C-c C-h") 'haskell-hayoo)

;TODO: setup flycheck
;TODO: bind in haskell-mode-map: haskell-{goto-imports, {return-from, navigate, sort, align}-imports}

(provide 'rc-haskell)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-haskell.el ends here
