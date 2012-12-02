;;; rc-ido.el ---

;; Copyright (C) 2012 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:

(require 'ido)

(setq ido-enable-flex-matching t)

(setq ido-mode t)

;; Display ido results vertically, rather than horizontally
(setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))

(defun ido-disable-line-trucation () (set (make-local-variable 'truncate-lines) nil))

(defun custom/ido-navigation ()
  (local-set-key (kbd "<up>") 'ido-prev-match)
  (local-set-key (kbd "<down>") 'ido-next-match)
  )

(add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-trucation)
(add-hook 'ido-minibuffer-setup-hook 'custom/ido-navigation)

(add-hook 'ido-setup-hook
          (lambda()
            (define-key ido-completion-map (kbd "C-M-p") (lookup-key ido-completion-map (kbd "C-p")))
            (define-key ido-completion-map (kbd "C-M-n") (lookup-key ido-completion-map (kbd "C-n"))) ; currently, this makes nothing. Maybe they'll make C-n key lately.
            (define-key ido-completion-map (kbd "C-p") 'ido-preview-backward)
            (define-key ido-completion-map (kbd "C-n") 'ido-preview-forward)))

(provide 'rc-ido)

;;; rc-ido.el ends here
