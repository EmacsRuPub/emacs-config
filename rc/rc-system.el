;;; rc-system.el ---

;; Copyright (C) 2012 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:

(setq password-cache-expiry 7200)

;; ;; Nic says eval-expression-print-level needs to be set to nil (turned off) so
;; ;; that you can always see what's happening.
(setq eval-expression-print-level nil)

(auto-compression-mode t)

;; ;; Emacs freaks out if this isn't set.
(setq warning-suppress-types nil)
(setq enable-local-variables nil)

(global-set-key (kbd "C-x c") 'proced)

(provide 'rc-system)

;;; rc-system.el ends here
