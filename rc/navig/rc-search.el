;;; rc-search.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(require 'highlight-symbol)
(require 're-builder)
(require 'ioccur)

(when (eq system-type 'darwin) ;; mac specific settings
  (setq locate-command "mdfind")
  )


;#############################################################################
;#   Keybindings
;############################################################################
(global-set-key (kbd "<M-f3>") 'highlight-symbol-at-point)
(global-set-key (kbd "<f3>") 'highlight-symbol-next)
(global-set-key (kbd "<S-f3>") 'highlight-symbol-prev)
(global-set-key (kbd "C-c s m") 'multi-occur-in-matching-buffers)
(global-set-key (kbd "C-c s g") 'rgrep)
(global-set-key (kbd "C-c s o") 'occur)
(global-set-key (kbd "C-c s r") 're-builder)
(global-set-key (kbd "C-c s i") 'ioccur)
(global-set-key (kbd "C-c s b") 'ioccur-find-buffer-matching)
(global-set-key (kbd "C-c s l") 'locate)

(provide 'rc-search)

;;; rc-search.el ends here
