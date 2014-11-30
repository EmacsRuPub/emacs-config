(require 'cc-mode)
(require 'info-look)
(require 'auto-complete-clang)

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

;; RTags essential keybindings
(define-key c-mode-map (kbd "C-.") 'rtags-find-symbol-at-point)
(define-key c-mode-map (kbd "C-u C-.") 'rtags-find-references-at-point)
(define-key c-mode-map (kbd "C-,") 'rtags-location-stack-back)
(define-key c-mode-map (kbd "C-c TAB") 'rtags-diagnostics)
(define-key c++-mode-map (kbd "C-.") 'rtags-find-symbol-at-point)
(define-key c++-mode-map (kbd "M-.") 'rtags-find-references-at-point)
(define-key c++-mode-map (kbd "C-,") 'rtags-location-stack-back)
(define-key c++-mode-map (kbd "C-c TAB") 'rtags-diagnostics)

(provide 'rc-cc)
