;;; defun-tex.el ---

;; Copyright (C) 2012 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:

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

(provide 'defun-tex)

;;; defun-tex.el ends here
