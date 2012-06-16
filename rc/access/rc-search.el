;;; init-search.el ---

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

(autoload 'kill-ring-search "kill-ring-search" "Search the kill ring in the minibuffer." (interactive))


;#############################################################################
;#   Keybindings
;############################################################################
(global-set-key [M-f3] 'highlight-symbol-at-point)
(global-set-key [f3] 'highlight-symbol-next)
(global-set-key [S-f3] 'highlight-symbol-prev)
(global-set-key "\M-\C-y" 'kill-ring-search)
(global-set-key "\C-cs" 'multi-occur-in-matching-buffers)
(global-set-key "\C-cug" 'rgrep)
(global-set-key "\C-coo" 'occur)
(global-set-key "\C-cur" 're-builder)
(global-set-key "\C-coi" 'ioccur)
(global-set-key "\C-cob" 'ioccur-find-buffer-matching)
(global-set-key "\C-col" 'locate)

;;; init-search.el ends here
