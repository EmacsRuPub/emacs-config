;; -*- coding: utf-8 -*-
;;
;; Filename: defun-search.el
;; Created: Вт апр 23 00:21:03 2013 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defadvice ack-and-a-half-arguments-from-options (after search-text-files disable)
  (let ((current-arguments ad-return-value))
    (push "--text" current-arguments)
    (setf ad-return-value current-arguments)))

(defadvice ack-and-a-half-list-files (around list-text-files disable)
  (let ((arguments (ad-get-args 1)))
    (push "--text" arguments)
    (ad-set-args 1 arguments)
    (setq ad-return-value ad-do-it)))

(defun occur-and-switch (search)
  (interactive "sSearch for: ")
  (occur (regexp-quote search))
  (switch-to-buffer-other-window "*Occur*"))

(defun isearch-occur ()
  (interactive)
  (let ((case-fold-search isearch-case-fold-search))
    (occur-and-switch (if isearch-regexp isearch-string
             (regexp-quote isearch-string)))))

(defadvice occur-mode-goto-occurrence (after close-occur activate)
  (delete-other-windows))

(provide 'defun-search)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; defun-search.el ends here
