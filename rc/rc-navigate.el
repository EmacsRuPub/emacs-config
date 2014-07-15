;; -*- coding: utf-8 -*-
;;
;; Filename: rc-navigate.el
;; Created: Чт май 29 17:33:42 2014 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(autoload 'smex "smex" nil t)
(autoload 'custom-helm "helm" nil t)
(add-hook 'ag-mode-hook 'wgrep-ag-setup)
(autoload 'wgrep-ag-setup "wgrep-ag")

(require 'ace-jump-mode)
(require 'ag)
(require 'fuzzy)
(require 're-builder)
(require 'bookmark+)
(require 'crosshairs)
(require 'breadcrumb)

(eval-after-load "helm"
  '(progn
     (require 'helm-files)
     (require 'helm-info)
     (require 'helm-locate)
     (require 'helm-misc)
     (require 'helm-recentd)
     (setq helm-recentd--action
           (append
            helm-recentd--action
            (cond ((executable-find "urxvt")
                   '(("Open in Urxvt"
                      . (lambda (ignored)
                          (shell-command (format "urxvt -e $SHELL -c 'cd %s && $SHELL' &"
                                                 (helm-recentd--get-target-string))))))))))
     (setq helm-recentd-sort 'frequency)
     (global-set-key (kbd "C-&") 'custom-helm)
     (global-set-key (kbd "C-x C-d") 'helm-recentd)
     ))

(eval-after-load "ido"
  '(progn
     (require 'ido-ubiquitous)
     (require 'ido-vertical-mode)
     (require 'flx-ido)
     (require 'thingatpt)
     (require 'imenu)

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
     ))

(eval-after-load "smex"
  '(progn
     (smex-initialize)
     (global-set-key (kbd "M-x") 'smex)
     (global-set-key (kbd "M-X") 'smex-major-mode-commands)
     (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command) ; old M-x
     ))

(eval-after-load "wgrep"
  '(progn
     (define-key ag-mode-map (kbd "C-x C-s") 'wgrep-save-all-buffers)
     (define-key grep-mode-map (kbd "C-x C-s") 'wgrep-save-all-buffers)
     ))

(turn-on-fuzzy-isearch)

(setq ag-highlight-search t)


;#############################################################################
;#   Keybindings
;############################################################################
;; isearch
(global-unset-key (kbd "C-s"))
(global-unset-key (kbd "C-r"))
(global-unset-key (kbd "C-M-s"))
(global-unset-key (kbd "C-M-r"))
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(define-key isearch-mode-map (kbd "C-o") 'isearch-occur)

;; custom search keymap
(define-key custom-search-keymap (kbd "m") 'swoop-multi)
(define-key custom-search-keymap (kbd "o") 'helm-occur)
(define-key custom-search-keymap (kbd "r") 'rgrep)
(define-key custom-search-keymap (kbd "l") 'locate)
(define-key custom-search-keymap (kbd "f") 'find-lisp-find-dired)
(define-key custom-search-keymap (kbd "s") 'find-lisp-find-dired-subdirectories)
(define-key custom-search-keymap (kbd "g") 'custom/projectile-ag)
(define-key custom-search-keymap (kbd "p") 'ag-regexp-project-at-point)
(define-key custom-search-keymap (kbd "i") 'swoop) ;; was ioccur
(define-key custom-search-keymap (kbd "b") 'swoop-back-to-last-position)
(define-key custom-search-keymap (kbd "q") 'projectile-find-file)
(define-key custom-search-keymap (kbd "s") 'ido-goto-symbol)
(define-key custom-search-keymap (kbd "a") 'ace-jump-char-mode)
(define-key custom-search-keymap (kbd "A") 'ace-jump-word-mode)
(define-key custom-search-keymap (kbd "n") 'sr-speedbar-toggle)
(define-key custom-search-keymap (kbd "C-n") 'sr-speedbar-select-window)
(define-key custom-search-keymap (kbd "h") 'helm-mini)
(define-key custom-search-keymap (kbd "j") 'bc-list)
(define-key custom-search-keymap (kbd "SPC") 'bc-set)

(provide 'rc-navigate)

;; TODO: See if we can customize Bookmarks[+] further

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-navigate.el ends here
