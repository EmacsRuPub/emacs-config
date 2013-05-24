;;; rc-simp.el ---

;; Copyright (C) 2012 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:

(require 'simp)

(simp-project-define
 '(:has (.git)
   :ignore (.git)))

(simp-project-define
 '(:has (.hg)
   :ignore (.hg)))

(setq simp-completing-read-command 'completing-read-ido)

;; (key-chord-define-global "1q" 'simp-project-find-file)
;; (global-set-key (kbd "C-x M-f") 'simp-project-find-file)
;; (global-set-key (kbd "C-c s g") 'simp-project-rgrep)
;; (global-set-key (kbd "C-c s a") 'simp-project-rgrep-thing-at-point)

(provide 'rc-simp)

;;; rc-simp.el ends here
