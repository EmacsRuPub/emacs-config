;;; rc-system.el ---

;; Copyright (C) 2012 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:

(require 'epg)

(setq password-cache-expiry 7200)

;; ;; Nic says eval-expression-print-level needs to be set to nil (turned off) so
;; ;; that you can always see what's happening.
(setq eval-expression-print-level nil)

(auto-compression-mode t)

;; ;; Emacs freaks out if this isn't set.
(setq warning-suppress-types nil)
(setq enable-local-variables nil)
(setq openwith-associations
      '(("\\.pdf\\'" "zathura" (file))
        ("\\.djvu\\'" "zathura" (file))
        ("\\.\\(?:mpe?g\\|avi\\|wmv\\|mkv\\)\\'" "vlc" (file))
        ("\\.\\(?:jp?g\\|png\\)\\'" "feh" (file))
        ("\\.doc\\'" "abiword" (file))
        ))

(global-set-key (kbd "C-x c") 'proced)

(provide 'rc-system)

;;; rc-system.el ends here
