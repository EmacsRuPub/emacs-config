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

(provide 'rc-ps-print)

;;; emacs-rc-ps-print.el ends here
