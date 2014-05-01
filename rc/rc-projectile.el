;;; rc-projectile.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(require 'projectile)
(require 'helm-projectile)

(projectile-global-mode) ;; to enable in all buffers

(setq projectile-enable-caching t)
(setq projectile-tags-command
      "find %s -type f -print | egrep -v \"/[.][a-zA-Z]\" | etags -")

(global-set-key (kbd "C-c h p") 'helm-projectile)

(provide 'rc-projectile)

;;; rc-projectile.el ends here
