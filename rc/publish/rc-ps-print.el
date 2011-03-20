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

(defun unicode-cyrillic-to-8859-5 ()
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (let ((re (format "[%c-%c]+"
		      (decode-char 'ucs #x0400) (decode-char 'ucs #x04ff)))
	  (case-fold-search nil)
	  pos)
      (while (re-search-forward re nil 'move)
	(setq pos (match-beginning 0))
	(encode-coding-region pos (point) 'iso-8859-5)
	(decode-coding-region pos (point) 'iso-8859-5)))))


;#############################################################################
;#   Custom definitions
;############################################################################
(defvar ps-print-path "Path for ps-print output")

(setq ps-print-path "~/ps-print")

(defun custom/ps-print-buffer-with-faces ()
  (interactive)
  (ps-print-buffer-with-faces (concat 
			       ps-print-path "/" 
			       (buffer-name) "-" 
			       (format-time-string "%Y-%m-%dT%H-%M-%S") ".ps")))

(defun custom/ps-print-region-with-faces ()
  (interactive)
  (ps-print-region-with-faces (region-beginning) (region-end) (concat 
							       ps-print-path "/" 
							       (buffer-name) "-" 
							       (format-time-string "%Y-%m-%dT%H-%M-%S") "-region.ps")))

;#############################################################################
;#   Keybindings
;############################################################################
(global-set-key "\M-p" 'custom/ps-print-buffer-with-faces)
(global-set-key "\C-c\M-p" 'custom/ps-print-region-with-faces)

;;; emacs-rc-ps-print.el ends here
