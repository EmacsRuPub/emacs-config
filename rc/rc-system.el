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
        ("\\.\\(?:mpe?g\\|avi\\|wmv\\|mkv\\|flv\\|mp4\\)\\'" "vlc" (file))
        ("\\.\\(?:jp?g\\|png\\)\\'" "feh" (file))
        ("\\.doc\\'" "abiword" (file))
        ("\\.swf\\'" "swfdec-player" (file))
        ))

(unless (and (string-equal "root" (getenv "USER"))
             (server-running-p))
  ;; Only start server mode if I'm not root and it is not running
  (require 'server)
  (server-start))

(add-hook 'server-visit-hook
          (lambda () (local-set-key (kbd "C-c C-c") 'server-save-edit)))

;; (add-hook 'kill-emacs-hook 'save-buffer-clients-on-exit)

(global-set-key (kbd "C-x c") 'proced)

(provide 'rc-system)

;;; rc-system.el ends here
