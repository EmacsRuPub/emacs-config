;; -*- coding: utf-8 -*-
;;
;; Filename: rc-publishing.el
;; Created:  Sun May 4 23:57:55 2014 +0400
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package tex-site)
(use-package preview-latex)
(use-package cdlatex)
(use-package bib-cite)
(use-package whizzytex)
(use-package auctex :ensure t)
(use-package latex-preview-pane :ensure t)
(use-package pdf-tools :ensure t)

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

(defun custom/tex-mode-hook ()
  (TeX-fold-mode 1)
  (turn-on-bib-cite)
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


;;TODO: plan docstring or reorganize hydra
(defhydra hydra-publishing ()
  ("w" whizzytex-mode)
  ("p" custom/ps-print-buffer-with-faces)
  ("P" custom/ps-print-region-with-faces)
  ("s" pdf-save-buffer-with-faces)
  ("S" pdf-save-region-with-faces)
  ("q" nil))
(global-set-key (kbd "C-c n") 'hydra-publishing/body)

;; TODO: investigate TEXT_INPUTS usage
;; TODO: fix encoding issues (questions marks instead of russian letters)
;; TODO: investigate how to deal with bright letters on bright
;; background being printed (in such cases letters are almost invisible)

(provide 'rc-publishing)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-publishing.el ends here
