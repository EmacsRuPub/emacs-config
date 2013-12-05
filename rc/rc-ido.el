;;; rc-ido.el ---

;; Copyright (C) 2012 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:

(require 'ido)
(require 'ido-ubiquitous)
(require 'ido-vertical-mode)
(require 'flx-ido)

(require 'defun-ido)

(ido-mode 'both)
(ido-ubiquitous-mode 1)
(ido-load-history)
(ido-vertical-mode)
(flx-ido-mode 1)

(ido-ubiquitous-use-new-completing-read yas/expand 'yasnippet)
(ido-ubiquitous-use-new-completing-read yas/visit-snippet-file 'yasnippet)

(setq ido-enable-flex-matching t)
(setq ido-enable-regexp t)
(setq ido-everywhere t)
(setq ido-enable-prefix nil)
(setq ido-auto-merge-work-directories-length -1)
(setq ido-create-new-buffer 'always)
(setq ido-use-filename-at-point 'guess)
(setq ido-show-dot-for-dired t)
(setq confirm-nonexistent-file-or-buffer nil)
(setq ido-enable-tramp-completion nil)
(setq ido-enable-last-directory-history t)
(setq ido-confirm-unique-completion nil)
(setq ido-max-work-directory-list 30)
(setq ido-max-work-file-list 100)
(setq ido-max-directory-size 1000000)
(setq ido-use-url-at-point t)
(setq ido-use-virtual-buffers t)
(setq ido-case-fold t) ; case insensitive
(setq ido-max-prospects 16)
(setq ido-use-faces nil)
;; (setq flx-ido-use-faces nil)

(setq ido-completing-read-use-initial-input-as-default-commands
      '(ibuffer-filter-by-mode
        ibuffer-filter-by-used-mode))


(set-default 'imenu-auto-rescan t) ;; Always rescan buffer for imenu

(put 'diredp-do-bookmark-in-bookmark-file 'ido 'ignore)
(put 'diredp-set-bookmark-file-bookmark-for-marked 'ido 'ignore)

(ad-enable-advice
 'ido-read-internal
 'around
 'ido-completing-read-use-initial-input-as-default)

(ad-activate 'ido-read-internal)

(when (eq system-type 'darwin)
  ;; Ignore .DS_Store files with ido mode
  (add-to-list 'ido-ignore-files "\\.DS_Store")
  )

(add-to-list 'ido-work-directory-list-ignore-regexps tramp-file-name-regexp)

(add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-truncation)
(add-hook 'ido-minibuffer-setup-hook 'custom/ido-navigation)

(add-hook 'ido-setup-hook
          (lambda()
            (define-key ido-completion-map (kbd "C-M-p") (lookup-key ido-completion-map (kbd "C-p")))
            (define-key ido-completion-map (kbd "C-M-n") (lookup-key ido-completion-map (kbd "C-n"))) ; currently, this makes nothing. Maybe they'll make C-n key lately.
            (define-key ido-completion-map (kbd "C-p") 'ido-preview-backward)
            (define-key ido-completion-map (kbd "C-n") 'ido-preview-forward)
            (define-key ido-completion-map (kbd "M-m") 'ido-merge-work-directories)
            ))
(add-hook 'ido-setup-hook
          (lambda ()
              ;; Use C-w to go back up a dir to better match normal usage of C-w
              ;; - insert current file name with C-x C-w instead.
              (define-key ido-file-completion-map (kbd "C-w") 'ido-delete-backward-updir)
              (define-key ido-file-completion-map (kbd "C-x C-w") 'ido-copy-current-file-name)))

;; Increase minibuffer size when ido completion is active
(add-hook 'ido-minibuffer-setup-hook
          (function
           (lambda ()
             (make-local-variable 'resize-minibuffer-window-max-height)
             (setq resize-minibuffer-window-max-height 1))))

(global-set-key (kbd "M-s b") 'ido-switch-buffer-by-major-mode)
(global-set-key (kbd "M-s B") 'ido-switch-buffer-by-ext-name)

(provide 'rc-ido)

;;; rc-ido.el ends here
