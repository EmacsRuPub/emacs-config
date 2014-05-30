;; -*- coding: utf-8 -*-
;;
;; Filename: rc-editing.el
;; Created: Вт апр 29 22:58:06 2014 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (electric-indent-mode 1)

;; (setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

;; (add-hook 'minibuffer-setup-hook 'conditionally-enable-parens-mode)

(when (eq system-type 'darwin) ;; mac specific settings
  ;; (setq mac-control-key-is-meta nil)
  ;; change command to meta, and ignore option to use weird Norwegian keyboard
  ;; (setq mac-option-modifier 'none)
  ;; (setq mac-command-modifier 'meta)
  ;; (setq ns-function-modifier 'hyper)
  )

;; (global-set-key (kbd "C-p") 'go-back)
;; (global-set-key (kbd "<up>") 'go-back)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-editing.el ends here
