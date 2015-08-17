;; -*- coding: utf-8 -*-
;;
;; Filename: rc-haskell.el
;; Created:  Thu May 1 16:30:43 2014 +0400
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package haskell-mode
  :init
  (use-package haskell-indent)
  (use-package haskell-align-imports)
  (use-package haskell-navigate-imports)
  (use-package haskell-sort-imports)
  (use-package inf-haskell)
  :config
  (setq haskell-program-name "ghci")
  (setq inferior-haskell-wait-and-jump t)
  (setq haskell-program-name "ghci \"+.\"")
  (bind-key "C-," 'haskell-move-nested-left haskell-mode-map)
  (bind-key "C-." 'haskell-move-nested-right haskell-mode-map)
  (bind-key "<tab>" 'haskell-indent-cycle haskell-mode-map)
  (bind-key "C-c h" 'haskell-hoogle haskell-mode-map)
  (bind-key "C-c C-h" 'haskell-hayoo haskell-mode-map)
  (add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
  (add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
  (add-hook 'haskell-mode-hook 'turn-on-eldoc-mode)
  (add-hook 'haskell-mode-hook 'common-hooks/newline-hook)
  (add-hook 'haskell-mode-hook 'common-hooks/prog-helpers)
  (add-hook 'haskell-mode-hook 'turn-on-haskell-ghci))

(use-package haskell-ghci)

;;TODO: setup flycheck
;;TODO: bind in haskell-mode-map: haskell-{goto-imports, {return-from, navigate, sort, align}-imports}
;;TODO: investigate the difference between builtin and el-get versions of haskell-mode

(provide 'rc-haskell)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-haskell.el ends here
