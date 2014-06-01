;; -*- coding: utf-8 -*-
;;
;; Filename: custom-navigate.el
;; Created: Вс июн  1 21:30:30 2014 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun custom-helm ()
  (interactive)
  (helm-other-buffer '(
                       helm-c-source-buffers-list
                       helm-c-source-files-in-current-dir
                       helm-c-source-recentf
                       helm-source-bookmarks
                       helm-source-file-name-history
                       helm-source-findutils
                       helm-source-locate
                       helm-source-occur
                       )
                     "*helm-custom*"))

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

(provide 'custom-navigate)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; custom-navigate.el ends here
