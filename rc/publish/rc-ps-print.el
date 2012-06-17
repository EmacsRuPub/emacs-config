;;; emacs-rc-ps-print.el --- 

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords: 
;; Requirements: 
;; Status: not intended to be distributed yet

;; TODO: fix encoding issues (questions marks instead of russian letters)
;; TODO: investigate how to deal with bright letters on dark background being printed (in such cases lettersare almost invisible)

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
(defvar ps-print-path "Path for ps-print output")

(setq ps-print-path "~/ps-print")

;#############################################################################
;#   Keybindings
;############################################################################
(global-set-key "\M-p" 'custom/ps-print-buffer-with-faces)
(global-set-key "\C-c\M-p" 'custom/ps-print-region-with-faces)

;;; emacs-rc-ps-print.el ends here
