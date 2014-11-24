;; -*- coding: utf-8 -*-
;;
;; Filename: rc-lang-haskell.el
;; Created: Сб июн  8 22:10:12 2013 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'haskell-mode)
(require 'hs-lint)
(require 'haskell-align-imports)
(require 'haskell-navigate-imports)
(require 'haskell-sort-imports)
(require 'inf-haskell)
(require 'haskell-ghci)
(require 'haskell-indent)

(setq haskell-program-name "ghci")
(setq hs-lint-replace-with-suggestions t)
(setq inferior-haskell-wait-and-jump t)
(setq haskell-doc-show-global-types t)
(setq haskell-program-name "ghci \"+.\"")

(defun custom/haskell-mode-hook ()
  (setq tab-width 4))

(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
(add-hook 'haskell-mode-hook 'turn-on-eldoc-mode)
(add-hook 'haskell-mode-hook 'common-hooks/newline-hook)
(add-hook 'haskell-mode-hook 'common-hooks/prog-helpers)
(add-hook 'haskell-mode-hook 'custom/haskell-mode-hook)
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
;;; rc-lang-haskell.el ends here
