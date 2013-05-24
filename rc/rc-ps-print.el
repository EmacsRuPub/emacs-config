;;; emacs-rc-ps-print.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(require 'defun-ps-print)

;; TODO: fix encoding issues (questions marks instead of russian letters)
;; TODO: investigate how to deal with bright letters on bright
;; background being printed (in such cases letters are almost invisible)

;#############################################################################
;#   Fonts and encoding
;############################################################################
;; BDF fonts for printing
;; (load-library "ps-mule")
;; (setq bdf-directory-list '("/usr/X11R6/lib/X11/fonts/emacs/bdf"))
;; (setq ps-mule-font-info-database-default ps-mule-font-info-database-bdf)
(setq ps-multibyte-buffer 'bdf-font-except-latin)

;#############################################################################
;#   Custom definitions
;############################################################################
(defvar ps-print-path "~/ps-print"
  "Path for ps-print output")


;#############################################################################
;#   Keybindings
;############################################################################
(global-set-key (kbd "M-p") 'custom/ps-print-buffer-with-faces)
(global-set-key (kbd "C-c M-p") 'custom/ps-print-region-with-faces)

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; Printing
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (setq ps-paper-type 'a4
;;       ps-line-number nil
;;       ps-line-number-step 3
;;       ps-n-up-printing 1
;;       ps-header-lines 0)

(provide 'rc-ps-print)

;;; emacs-rc-ps-print.el ends here
