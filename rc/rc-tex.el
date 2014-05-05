;;; emacs-rc-tex.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

;; TODO: get rid of whizzytex from package manager

(require 'tex-site)
(require 'preview-latex)

(defun flymake-get-tex-args (file-name)
  (list "pdflatex" (list "-file-line-error" "-draftmode" "-interaction=nonstopmode" file-name)))

;#############################################################################
;#   Hooks
;############################################################################
(defun custom/TeX-keymap ()
  (local-set-key (kbd "M-i")
                 '(lambda ()
                    (interactive)
                    (insert "\n\\item "))))

(defun custom/texinfo-hook ()
  (local-set-key [delete]  'delete-char)
  (setq delete-key-deletes-forward t))
(add-hook 'texinfo-mode-hook 'custom/texinfo-hook)

(defun custom/tex-mode-hook ()
  (local-set-key "\\" 'TeX-electric-macro)
  (turn-on-bib-cite)
  (custom/TeX-keymap)
  (setq bib-cite-use-reftex-view-crossref t))

(add-hook 'TeX-mode-hook 'custom/tex-mode-hook)
(add-hook 'LaTeX-mode-hook 'TeX-PDF-mode)
(add-hook 'LaTeX-mode-hook 'custom/tex-mode-hook)
(add-hook 'TeX-mode-hook '(lambda () (TeX-fold-mode 1)))
(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)


;#############################################################################
;#   Common
;############################################################################

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
;; TODO extact system-specific parts
(setq TeX-output-view-style
      (cond
       ((eq system-type 'darwin)
        (quote
         (("^pdf$" "." "open -a preview %s.pdf")
          ("^html?$" "." "open %o"))))
       ((eq system-type 'gnu/linux)
        (quote
         (("^pdf$" "." "zathura %s.pdf")
          ("^html?$" "." "open %o"))))))

;; mark some variables as safe
(add-to-list 'safe-local-variable-values '(TeX-open-quote . "<<"))
(add-to-list 'safe-local-variable-values '(TeX-close-quote . ">>"))


;#############################################################################
;#   CDLaTeX
;############################################################################
(autoload 'cdlatex-mode "cdlatex" "CDLaTeX Mode" t)
(autoload 'turn-on-cdlatex "cdlatex" "CDLaTeX Mode" nil)

;; CDLaTeX mode
(add-hook 'LaTeX-mode-hook 'turn-on-cdlatex)   ; with AUCTeX LaTeX mode
(add-hook 'latex-mode-hook 'turn-on-cdlatex)   ; with Emacs latex mode


;#############################################################################
;#   WhizzyTex
;############################################################################
(autoload 'whizzytex-mode "whizzytex" "WhizzyTeX, a minor-mode WYSIWIG environment for LaTeX" t)

(setq-default whizzy-viewers '(("-dvi" "xdvi") ("-ps" "gv")))

(global-set-key (kbd "C-c m w") 'whizzytex-mode)


;#############################################################################
;#   RefTex
;############################################################################
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(add-hook 'latex-mode-hook 'turn-on-reftex)

(setq reftex-enable-partial-scans t)
(setq reftex-save-parse-info t)
(setq reftex-use-multiple-selection-buffers t)

(provide 'rc-tex)

;;; emacs-rc-tex.el ends here
