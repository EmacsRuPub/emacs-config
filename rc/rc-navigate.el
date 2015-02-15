;; -*- coding: utf-8 -*-
;;
;; Filename: rc-navigate.el
;; Created:  Thu May 29 17:37:11 2014 +0400
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(autoload 'smex "smex" nil t)
(add-hook 'ag-mode-hook 'wgrep-ag-setup)
(add-hook 'c-mode-hook 'helm-gtags-mode)
(autoload 'wgrep-ag-setup "wgrep-ag")

(require 'ace-jump-mode)
(require 'ag)
(require 'fuzzy)
(require 're-builder)
(require 'bookmark+)
(require 'crosshairs)
(require 'breadcrumb)
(require 'neotree)
(require 'helm)
(require 'swoop)

(with-eval-after-load "helm"
  (require 'helm-files)
  (require 'helm-info)
  (require 'helm-locate)
  (require 'helm-misc)
  (require 'helm-recentd)
  (require 'helm-grep)
  (setq helm-recentd--action
        (append
         helm-recentd--action
         (cond ((executable-find "urxvt")
                '(("Open in Urxvt"
                   . (lambda (ignored)
                       (shell-command (format "urxvt -e $SHELL -c 'cd %s && $SHELL' &"
                                              (helm-recentd--get-target-string))))))))))
  (setq helm-recentd-sort 'frequency)
  (setq helm-quick-update t)
  (setq helm-split-window-in-side-p t)
  (setq helm-ff-search-library-in-sexp t)
  (setq helm-ff-file-name-history-use-recentf t)
  (pushnew 'python-mode helm-buffers-favorite-modes)
  (global-set-key (kbd "C-x C-d") 'helm-recentd)
  (global-set-key (kbd "C-x b") 'ido-switch-buffer)
  (define-key custom-search-keymap (kbd "h") 'helm-mini)
  (define-key custom-search-keymap (kbd "o") 'helm-occur)
  (define-key custom-search-keymap (kbd "f") 'custom/helm-find-files))

(with-eval-after-load "ido"
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
  (setq ido-default-file-method 'selected-window)
  (setq ido-default-buffer-method 'selected-window)

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

  (add-hook 'ido-setup-hook
            (lambda()
              (define-key ido-completion-map (kbd "C-M-p") (lookup-key ido-completion-map (kbd "C-p")))
              (define-key ido-completion-map (kbd "C-M-n") (lookup-key ido-completion-map (kbd "C-n"))) ; currently, this makes nothing. Maybe they'll make C-n key lately.
              (define-key ido-completion-map (kbd "C-p") 'ido-preview-backward)
              (define-key ido-completion-map (kbd "C-n") 'ido-preview-forward)
              (define-key ido-completion-map (kbd "M-m") 'ido-merge-work-directories)
              (define-key ido-file-completion-map (kbd "C-w") 'ido-delete-backward-updir)
              (define-key ido-file-completion-map (kbd "C-x C-w") 'ido-copy-current-file-name)
              ))
  ;; Increase minibuffer size when ido completion is active
  (add-hook 'ido-minibuffer-setup-hook
            (lambda ()
              (make-local-variable 'resize-minibuffer-window-max-height)
              (setq resize-minibuffer-window-max-height 1)
              (ido-disable-line-truncation)
              (define-key ido-completion-map (kbd "<up>") 'ido-prev-match)
              (define-key ido-common-completion-map (kbd "<up>") 'ido-prev-match)
              (define-key ido-buffer-completion-map (kbd "<up>") 'ido-prev-match)
              (define-key ido-file-completion-map (kbd "<up>") 'ido-prev-match)
              (define-key ido-file-dir-completion-map (kbd "<up>") 'ido-prev-match)
              (define-key ido-completion-map (kbd "<down>") 'ido-next-match)
              (define-key ido-common-completion-map (kbd "<down>") 'ido-next-match)
              (define-key ido-buffer-completion-map (kbd "<down>") 'ido-next-match)
              (define-key ido-file-completion-map (kbd "<down>") 'ido-next-match)
              (define-key ido-file-dir-completion-map (kbd "<down>") 'ido-next-match)
              ))
  (global-set-key (kbd "M-s b") 'ido-switch-buffer-by-major-mode)
  (global-set-key (kbd "M-s B") 'ido-switch-buffer-by-ext-name))

(with-eval-after-load "smex"
  (smex-initialize)
  (global-set-key (kbd "M-x") 'smex)
  (global-set-key (kbd "M-X") 'smex-major-mode-commands)
  (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command) ; old M-x
  )

(with-eval-after-load "wgrep"
  (define-key ag-mode-map (kbd "C-x C-s") 'wgrep-save-all-buffers)
  (define-key grep-mode-map (kbd "C-x C-s") 'wgrep-save-all-buffers))

(turn-on-fuzzy-isearch)

(setq ag-highlight-search t)

(with-eval-after-load "helm-gtags"
  (define-key helm-gtags-mode-map (kbd "M-t") 'helm-gtags-find-tag)
  (define-key helm-gtags-mode-map (kbd "M-r") 'helm-gtags-find-rtag)
  (define-key helm-gtags-mode-map (kbd "C-M-s") 'helm-gtags-find-symbol)
  ;; (define-key helm-gtags-mode-map (kbd "M-s") 'helm-gtags-select)
  (define-key helm-gtags-mode-map (kbd "M-g M-p") 'helm-gtags-parse-file)
  (define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
  (define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)
  (define-key helm-gtags-mode-map (kbd "M-.") 'helm-gtags-dwim)
  (define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)
  (setq helm-gtags-path-style 'relative)
  (setq helm-gtags-ignore-case t)
  (setq helm-gtags-auto-update t)
  (setq helm-gtags-use-input-at-cursor t)
  (setq helm-gtags-pulse-at-cursor t)
  (setq helm-gtags-suggested-key-mapping t)
  (add-hook 'dired-mode-hook 'helm-gtags-mode)
  (add-hook 'c-mode-hook 'helm-gtags-mode)
  (add-hook 'c++-mode-hook 'helm-gtags-mode))

(with-eval-after-load "ace-jump-mode"
  (setq ace-jump-mode-scope 'visible)
  (ace-jump-mode-enable-mark-sync)
  (define-key global-map (kbd "C-x SPC") 'ace-jump-mode-pop-mark)
  (define-key custom-search-keymap (kbd "a") 'ace-jump-char-mode)
  (define-key custom-search-keymap (kbd "A") 'ace-jump-word-mode))

(with-eval-after-load "swoop"
  (define-key custom-search-keymap (kbd "m") 'swoop-multi)
  (define-key custom-search-keymap (kbd "i") 'swoop)
  (define-key swoop-map (kbd "<down>") 'swoop-action-goto-line-next)
  (define-key swoop-map (kbd "<up>") 'swoop-action-goto-line-prev))

(with-eval-after-load "neotree"
  (define-key custom-search-keymap (kbd "n") 'neotree-toggle))

(with-eval-after-load "breadcrumb"
  (define-key custom-search-keymap (kbd "j") 'bc-list)
  (define-key custom-search-keymap (kbd "SPC") 'bc-set))

;; (with-eval-after-load "bookmark+"
;;   (global-set-key (kbd "C-x j j") 'helm-bookmarks))

(use-package zoom-window
  :bind ("C-x C-z" . zoom-window-zoom)
  :config
  (setq zoom-window-mode-line-color "DarkGreen"))

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
(define-key custom-search-keymap (kbd "r") 'rgrep)
(define-key custom-search-keymap (kbd "s") 'helm-semantic-or-imenu)

(provide 'rc-navigate)

;; TODO: See if we can customize Bookmarks[+] further

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-navigate.el ends here
