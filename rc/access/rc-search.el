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
(global-set-key (kbd "<M-f3>") 'highlight-symbol-at-point)
(global-set-key (kbd "<f3>") 'highlight-symbol-next)
(global-set-key (kbd "<S-f3>") 'highlight-symbol-prev)
(global-set-key (kbd "M-C-y") 'kill-ring-search)
(global-set-key (kbd "C-c s") 'multi-occur-in-matching-buffers)
(global-set-key (kbd "C-c u g") 'rgrep)
(global-set-key (kbd "C-c o o") 'occur)
(global-set-key (kbd "C-c u r") 're-builder)
(global-set-key (kbd "C-c o i") 'ioccur)
(global-set-key (kbd "C-c o b") 'ioccur-find-buffer-matching)
(global-set-key (kbd "C-c o l") 'locate)

;;; init-search.el ends here
