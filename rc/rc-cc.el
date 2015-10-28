;; -*- coding: utf-8 -*-
;;
;; Filename: rc-cc.el
;; Created:  Sun Nov 30 18:41:23 2014 +0300
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package cc-mode)
(use-package info-look)
(use-package ac-c-headers :ensure auto-complete)
(use-package ac-clang :ensure auto-complete)
(use-package auto-complete-clang :ensure auto-complete)
(use-package irony :ensure t)

(use-package function-args
  :ensure t
  :config
  (define-key c-mode-map (kbd "C-c j") 'moo-jump-local)
  (define-key c++-mode-map (kbd "C-c j") 'moo-jump-local)
  (define-key c-mode-map (kbd "C-c C-<tab>") 'moo-complete)
  (define-key c++-mode-map (kbd "C-c C-<tab>") 'moo-complete))

(use-package rtags
  :ensure t
  :config
  (define-key c-mode-map (kbd "C-.") 'rtags-find-symbol-at-point)
  (define-key c-mode-map (kbd "C-u C-.") 'rtags-find-references-at-point)
  (define-key c-mode-map (kbd "C-,") 'rtags-location-stack-back)
  (define-key c-mode-map (kbd "C-c TAB") 'rtags-diagnostics)
  (define-key c++-mode-map (kbd "C-.") 'rtags-find-symbol-at-point)
  (define-key c++-mode-map (kbd "C-u C-.") 'rtags-find-references-at-point)
  (define-key c++-mode-map (kbd "C-,") 'rtags-location-stack-back)
  (define-key c++-mode-map (kbd "C-c TAB") 'rtags-diagnostics))

(info-lookup-add-help
 :mode 'c-mode
 :regexp "[^][()'\" \t\n]+"
 :ignore-case t
 :doc-spec '(("(libc)Symbol Index" nil nil nil)))

(defun custom/c-mode-common-hook ()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers)
  (add-to-list 'ac-sources 'ac-source-gtags)
  (add-to-list 'ac-sources 'ac-source-clang)
  ;; (hs-minor-mode 1)
  )

;; replace the `completion-at-point' and `complete-symbol' bindings in
;; irony-mode's buffers by irony-mode's function
(defun custom/irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async))

(add-hook 'c++-mode-hook 'common-hooks/newline-hook)
(add-hook 'c++-mode-hook 'custom/c-mode-common-hook)
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-common-hook 'common-hooks/prog-helpers)
(add-hook 'c-mode-hook 'common-hooks/newline-hook)
(add-hook 'c-mode-hook 'custom/c-mode-common-hook)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'irony-mode-hook 'custom/irony-mode-hook)

;;TODO: review and maybe rebind
(define-key c-mode-map (kbd "M-.") 'helm-gtags-select)
(define-key c++-mode-map (kbd "C-j") 'helm-gtags-select)
(define-key c-mode-map (kbd "C-c t") 'helm-gtags-show-stack)
(define-key c++-mode-map (kbd "C-c t") 'helm-gtags-show-stack)
(define-key c-mode-map (kbd "C-c i") 'helm-gtags-tags-in-this-function)
(define-key c++-mode-map (kbd "C-c i") 'helm-gtags-tags-in-this-function)
(define-key c-mode-map (kbd "C-c u") 'helm-gtags-update-tags)
(define-key c++-mode-map (kbd "C-c u") 'helm-gtags-update-tags)

;;TODO: bind helm-gtags-find-{rtags,symbol}

(provide 'rc-cc)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-cc.el ends here
