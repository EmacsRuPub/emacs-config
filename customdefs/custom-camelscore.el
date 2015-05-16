;; -*- coding: utf-8 -*-
;;
;; Filename: util-camelscore.el
;; Created: Чт апр 11 01:28:48 2013 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define-namespace custom/

(defvar thing-at-point-type 'word)      ;'symbol

(defun camelscore-word-at-point ()
  (interactive)
  (let* ((prev-point (point))
         (case-fold-search nil)
         (beg (and (skip-chars-backward "[:alnum:]:_-") (point)))
         (end (and (skip-chars-forward  "[:alnum:]:_-") (point)))
         (txt (buffer-substring beg end))
         (cml (camelscore txt)) )
    (if cml
        (progn
          (delete-region beg end)
          (insert cml)
          (goto-char prev-point)
          ))))

(defun camelscore (s)
  (cond ((string-match-p "\\(?:[a-z]+_\\)+[a-z]+" s) (dasherize s))
        ((string-match-p "\\(?:[a-z]+-\\)+[a-z]+" s) (camelcase s))
        ((string-match-p "\\(?:[A-Z][a-z]+\\)+$"  s) (colonize  s))
        (t                                           (underscore s))))

(defun camelscore (s)
  (cond ((string-match-p "\:"  s) (camelcase s))
        ((string-match-p "-" s)   (colonize s))
        ((string-match-p "_" s)   (dasherize s))
        (t                        (underscore s))))

(defun camelcase  (s) (mapconcat 'identity
                                 (mapcar-head 'downcase 'capitalize
                                              (split-name s)) ""))
(defun pascalcase (s) (mapconcat 'capitalize (split-name s) ""))
(defun underscore (s) (mapconcat 'downcase   (split-name s) "_"))
(defun dasherize  (s) (mapconcat 'downcase   (split-name s) "-"))
(defun colonize   (s) (mapconcat 'capitalize (split-name s) "::"))

(defun split-name (s)
  (split-string
   (let ((case-fold-search nil))
     (downcase
      (replace-regexp-in-string "\\([a-z]\\)\\([A-Z]\\)" "\\1 \\2" s)))
   "[^A-Za-z0-9]+"))

(defun mapcar-head (fn-head fn-rest list)
  "Like MAPCAR, but applies a different function to the first element."
  (if list
      (cons (funcall fn-head (car list)) (mapcar fn-rest (cdr list)))))

)

(provide 'custom-camelscore)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; util-camelscore.el ends here
