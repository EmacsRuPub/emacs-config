;; -*- coding: utf-8 -*-
;;
;; Filename: rc-publishing.el
;; Created:  Sun May 4 23:57:55 2014 +0400
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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

(global-set-key (kbd "C-c C-p") 'pdf-save-buffer-with-faces)
(global-set-key (kbd "C-c C-r") 'pdf-save-region-with-faces)

(provide 'rc-publishing)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-publishing.el ends here
