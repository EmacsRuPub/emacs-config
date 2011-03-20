;;; init-search.el --- 

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords: 
;; Requirements: 
;; Status: not intended to be distributed yet

(add-to-list 'load-path "~/site-lisp/editing")
(add-to-list 'load-path "/site-lisp/editing/kill-ring-search.el")
(load-file "~/site-lisp/search/re-builder.el")
(load-file "~/site-lisp/search/full-ack.el")

(require 'highlight-symbol)


;#############################################################################
;#   full-ack setup
;############################################################################
(autoload 'ack-same "full-ack" nil t)
(autoload 'ack "full-ack" nil t)
(autoload 'ack-find-same-file "full-ack" nil t)
(autoload 'ack-find-file "full-ack" nil t)
(autoload 'kill-ring-search "kill-ring-search" "Search the kill ring in the minibuffer." (interactive))


;#############################################################################
;#   Keybindings
;############################################################################
(global-set-key [C-f3] 'highlight-symbol-at-point)
(global-set-key [f3] 'highlight-symbol-next)
(global-set-key [S-f3] 'highlight-symbol-prev)
(global-set-key "\M-\C-y" 'kill-ring-search)
(global-set-key "\C-cs" 'multi-occur-in-matching-buffers)
(global-set-key "\C-cug" 'rgrep)
(global-set-key "\C-cua" 'ack)
(global-set-key "\C-co" 'occur)
(global-set-key "\C-cur" 're-builder)

;;; init-search.el ends here
