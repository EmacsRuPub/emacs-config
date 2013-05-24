;; -*- coding: utf-8 -*-
;;
;; Filename: defun-recipes.el
;; Created: Вт апр 30 20:28:12 2013 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun get-all-template-variables-django ()
  (interactive)
  (beginning-of-buffer)
  (let ((variables-list '()))
    (while (search-forward "{{" nil t)
      (let ((beg (+ (point) 1)))
        (search-forward "}}" nil t)
        (let ((end (- (point) 3)))
          (setq variables-list (cons (buffer-substring-no-properties beg end) variables-list)))))
    (spawn-buffer)
    (dolist (variable (nreverse variables-list))
      (insert variable)
      (insert "\n"))))

(defun generate-debug-print-python ()
  (interactive)
  (insert "print '")
  (yank)
  (insert ":', ")
  (yank))

(defvar domain-regexp-ru "[0-9a-z\-]*\\.ru")
(defvar domain-regexp-rf "[0-9а-я\-]*\\.рф")

(defvar domain-regexp-ru-op "[0-9a-z\-]*\\.ru\s*.Opossum")
(defvar domain-regexp-rf-op "[0-9а-я\-]*\\.рф\s*.Opossum")

(defun custom/find-domain-regexp-ru-forward ()
  (interactive)
  (re-search-forward domain-regexp-ru-op nil t))

(defun custom/find-domain-regexp-rf-forward ()
  (interactive)
  (re-search-forward domain-regexp-rf nil t))

(defun custom/find-domain-regexp-ru-backward ()
  (interactive)
  (re-search-backward domain-regexp-ru-op nil t))

(defun custom/find-domain-regexp-rf-backward ()
  (interactive)
  (re-search-backward domain-regexp-rf nil t))

(defun join-region (beg end)
  "Apply join-line over region."
  (interactive "r")
  (if mark-active
      (let ((beg (region-beginning))
            (end (copy-marker (region-end))))
        (goto-char beg)
        (while (< (point) end)
          (join-line 1)))))


(provide 'defun-recipes)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; defun-recipes.el ends here
