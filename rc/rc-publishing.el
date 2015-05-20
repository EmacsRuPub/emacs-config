;; -*- coding: utf-8 -*-
;;
;; Filename: rc-publishing.el
;; Created:  Sun May 4 23:57:55 2014 +0400
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(autoload 'turn-on-bib-cite "bib-cite")
(autoload 'cdlatex-mode "cdlatex" "CDLaTeX Mode" t)
(autoload 'turn-on-cdlatex "cdlatex" "CDLaTeX Mode" nil)
(autoload 'whizzytex-mode "whizzytex" "WhizzyTeX, a minor-mode WYSIWIG environment for LaTeX" t)

(use-package tex-site)
(use-package preview-latex)

(setq-default TeX-master nil)
(setq TeX-parse-self t)
(setq TeX-auto-save t)
(setq TeX-default-mode 'latex-mode)
(setq TeX-open-quote "``")
(setq TeX-close-quote "''")
(setq TeX-PDF-mode t)
(setq font-latex-title-fontify 'color)      ; this gets rid of the large fonts
(setq font-latex-fontify-sectioning 'color) ; in sections etc
(setq reftex-enable-partial-scans t)
(setq reftex-save-parse-info t)
(setq reftex-use-multiple-selection-buffers t)
(setq-default whizzy-viewers '(("-dvi" "xdvi") ("-ps" "gv")))
(setq ps-multibyte-buffer 'bdf-font-except-latin)

(add-to-list 'safe-local-variable-values '(TeX-open-quote . "<<"))
(add-to-list 'safe-local-variable-values '(TeX-close-quote . ">>"))

(defvar ps-print-path "~/ps-print"
  "Path for ps-print output")

(defun custom/texinfo-hook ()
  (local-set-key [delete]  'delete-char)
  (setq delete-key-deletes-forward t))
(add-hook 'texinfo-mode-hook 'custom/texinfo-hook)

(defun custom/tex-mode-hook ()
  (TeX-fold-mode 1)
  (local-set-key "\\" 'TeX-electric-macro)
  (turn-on-bib-cite)
  (local-set-key (kbd "M-i") '(lambda () (interactive) (insert "\n\\item ")))
  (setq bib-cite-use-reftex-view-crossref t))

(add-hook 'TeX-mode-hook 'custom/tex-mode-hook)
(add-hook 'LaTeX-mode-hook 'TeX-PDF-mode)
(add-hook 'LaTeX-mode-hook 'custom/tex-mode-hook)
(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-cdlatex)   ; with AUCTeX LaTeX mode
(add-hook 'latex-mode-hook 'turn-on-cdlatex)   ; with Emacs latex mode
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(add-hook 'latex-mode-hook 'turn-on-reftex)

(global-set-key (kbd "C-c t w") 'whizzytex-mode)
(global-set-key (kbd "M-p") 'custom/ps-print-buffer-with-faces)
(global-set-key (kbd "C-c M-p") 'custom/ps-print-region-with-faces)
(global-set-key (kbd "C-c C-p") 'pdf-save-buffer-with-faces)
(global-set-key (kbd "C-c C-r") 'pdf-save-region-with-faces)

;; TODO: investigate TEXT_INPUTS usage
;; TODO: fix encoding issues (questions marks instead of russian letters)
;; TODO: investigate how to deal with bright letters on bright
;; background being printed (in such cases letters are almost invisible)

(provide 'rc-publishing)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-publishing.el ends here
