;;; emacs-rc-doxygen.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

;#############################################################################
;#   Load extensions
;############################################################################
(require 'tempo)
(require 'doxymacs)


;#############################################################################
;#   Customizations
;############################################################################
(setq-default doxymacs-doxygen-style "JavaDoc")


;#############################################################################
;#   Hooks
;############################################################################
(defun custom/doxymacs-font-lock-hook ()
  (if (or (eq major-mode 'c-mode)
       (eq major-mode 'c++-mode))
      (doxymacs-font-lock)))

(add-hook 'font-lock-mode-hook 'custom/doxymacs-font-lock-hook)
(add-hook 'c-mode-common-hook 'doxymacs-mode)

(provide 'rc-tools-doxygen)

;;; emacs-rc-doxygen.el ends here
