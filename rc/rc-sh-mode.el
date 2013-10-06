;;; rc-sh-mode.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(require 'defun-sh-mode)

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
