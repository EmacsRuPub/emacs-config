;;; rc-sh-mode.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

;#############################################################################
;#   Custom definitions
;############################################################################
(defun custom/sh-check-finish-hook (buf msg)
  "Function, that is executed at the end of sh check"
  (when (not (string-match "finished" msg))
    (next-error 1 t)))

(defun custom/sh-check-syntax ()
  "Check syntax of current file"
  (interactive)
  (when (string-match "^\\(ba\\|z\\)sh" (symbol-name sh-shell))
    (save-some-buffers t)
    (compilation-start (concat (symbol-name sh-shell) " -n " (buffer-file-name))
                       'sh-check-mode))
  )


;#############################################################################
;#   Load extensions
;############################################################################
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)


;#############################################################################
;#   Custom definitions
;############################################################################
(define-compilation-mode sh-check-mode "SH"
  "Mode for check sh source code."
  (set (make-local-variable 'compilation-disable-input) t)
  (set (make-local-variable 'compilation-scroll-output) nil)
  (set (make-local-variable 'compilation-finish-functions)
       (list 'custom/sh-check-finish-hook))
  )


;#############################################################################
;#   Hooks
;############################################################################
(defun custom/sh-mode-hook ()
  (local-set-key (kbd "C-c l") 'custom/sh-check-syntax)
  )

(add-hook 'sh-mode-hook 'custom/sh-mode-hook)
(add-hook 'sh-mode-hook 'common-hooks/comment-hook)
(add-hook 'sh-mode-hook 'common-hooks/prog-helpers)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(add-hook 'sh-mode-hook 'common-hooks/newline-hook)

(provide 'rc-sh-mode)

;;; rc-sh-mode.el ends here
