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

(setq haskell-program-name "ghci")
(setq hs-lint-replace-with-suggestions t)

(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

(define-key haskell-mode-map (kbd "C-,") 'haskell-move-nested-left)
(define-key haskell-mode-map (kbd "C-.") 'haskell-move-nested-right)

(provide 'rc-haskell)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-lang-haskell.el ends here
