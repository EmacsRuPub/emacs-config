;;; rc-ido.el ---

;; Copyright (C) 2012 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:

(require 'ido)
(require 'ido-ubiquitous)

(ido-mode t)
(ido-ubiquitous-mode 1)

;; Fix ido-ubiquitous for newer packages
(defmacro ido-ubiquitous-use-new-completing-read (cmd package)
  `(eval-after-load ,package
     '(defadvice ,cmd (around ido-ubiquitous-new activate)
        (let ((ido-ubiquitous-enable-compatibility nil))
          ad-do-it))))

(ido-ubiquitous-use-new-completing-read yas/expand 'yasnippet)
(ido-ubiquitous-use-new-completing-read yas/visit-snippet-file 'yasnippet)

(setq ido-enable-flex-matching t)
(setq ido-enable-prefix nil)
(setq ido-case-fold nil)
(setq ido-auto-merge-work-directories-length -1)
(setq ido-create-new-buffer 'always)
(setq ido-use-filename-at-point nil)

;; Display ido results vertically, rather than horizontally
(setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))

;; Always rescan buffer for imenu
(set-default 'imenu-auto-rescan t)

(defun ido-disable-line-truncation () (set (make-local-variable 'truncate-lines) nil))

(defun custom/ido-navigation ()
  (local-set-key (kbd "<up>") 'ido-prev-match)
  (local-set-key (kbd "<down>") 'ido-next-match)
  )

(add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-truncation)
(add-hook 'ido-minibuffer-setup-hook 'custom/ido-navigation)

(add-hook 'ido-setup-hook
          (lambda()
            (define-key ido-completion-map (kbd "C-M-p") (lookup-key ido-completion-map (kbd "C-p")))
            (define-key ido-completion-map (kbd "C-M-n") (lookup-key ido-completion-map (kbd "C-n"))) ; currently, this makes nothing. Maybe they'll make C-n key lately.
            (define-key ido-completion-map (kbd "C-p") 'ido-preview-backward)
            (define-key ido-completion-map (kbd "C-n") 'ido-preview-forward)))
(add-hook 'ido-setup-hook
          (lambda ()
              ;; Use C-w to go back up a dir to better match normal usage of C-w
              ;; - insert current file name with C-x C-w instead.
              (define-key ido-file-completion-map (kbd "C-w") 'ido-delete-backward-updir)
              (define-key ido-file-completion-map (kbd "C-x C-w") 'ido-copy-current-file-name)))

(provide 'rc-ido)

;;; rc-ido.el ends here
