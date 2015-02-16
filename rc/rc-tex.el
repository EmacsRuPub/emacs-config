;; -*- coding: utf-8 -*-
;;
;; Filename: rc-tex.el
;; Created:  Fri May 24 22:41:54 2013 +0400
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; TODO: get rid of whizzytex from package manager

(require 'tex-site)
(require 'preview-latex)

(defun custom/texinfo-hook ()
  (local-set-key [delete]  'delete-char)
  (setq delete-key-deletes-forward t))
(add-hook 'texinfo-mode-hook 'custom/texinfo-hook)

(defun custom/tex-mode-hook ()
  (local-set-key "\\" 'TeX-electric-macro)
  (turn-on-bib-cite)
  (local-set-key (kbd "M-i") '(lambda () (interactive) (insert "\n\\item ")))
  (setq bib-cite-use-reftex-view-crossref t))

(add-hook 'TeX-mode-hook 'custom/tex-mode-hook)
(add-hook 'LaTeX-mode-hook 'TeX-PDF-mode)
(add-hook 'LaTeX-mode-hook 'custom/tex-mode-hook)
(add-hook 'TeX-mode-hook '(lambda () (TeX-fold-mode 1)))
(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)

(autoload 'turn-on-bib-cite "bib-cite")

(setq-default TeX-master nil)
(setq TeX-parse-self t)
(setq TeX-auto-save t)
(setq TeX-default-mode 'latex-mode)
(setq TeX-open-quote "``")
(setq TeX-close-quote "''")
(setq TeX-PDF-mode t)
(setq font-latex-title-fontify 'color)      ; this gets rid of
(setq font-latex-title-fontity 'color)      ; the large fonts
(setq font-latex-fontify-sectioning 'color) ; in sections etc

;; mark some variables as safe
(add-to-list 'safe-local-variable-values '(TeX-open-quote . "<<"))
(add-to-list 'safe-local-variable-values '(TeX-close-quote . ">>"))

(autoload 'cdlatex-mode "cdlatex" "CDLaTeX Mode" t)
(autoload 'turn-on-cdlatex "cdlatex" "CDLaTeX Mode" nil)

;; CDLaTeX mode
(add-hook 'LaTeX-mode-hook 'turn-on-cdlatex)   ; with AUCTeX LaTeX mode
(add-hook 'latex-mode-hook 'turn-on-cdlatex)   ; with Emacs latex mode

(autoload 'whizzytex-mode "whizzytex" "WhizzyTeX, a minor-mode WYSIWIG environment for LaTeX" t)

(setq-default whizzy-viewers '(("-dvi" "xdvi") ("-ps" "gv")))

(global-set-key (kbd "C-c m w") 'whizzytex-mode)

(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(add-hook 'latex-mode-hook 'turn-on-reftex)

(setq reftex-enable-partial-scans t)
(setq reftex-save-parse-info t)
(setq reftex-use-multiple-selection-buffers t)

;TODO: investigate TEXT_INPUTS usage

(provide 'rc-tex)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-tex.el ends here
