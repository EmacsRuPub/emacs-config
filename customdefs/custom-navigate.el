;; -*- coding: utf-8 -*-
;;
;; Filename: custom-navigate.el
;; Created: Вс июн  1 21:30:30 2014 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun custom/helm-find-files ()
  (interactive)
  (helm-other-buffer '(
                       helm-source-files-in-current-dir
                       helm-source-recentf
                       helm-source-file-name-history
                       helm-source-findutils
                       helm-source-locate
                       )
                     "*helm-find-files*"))

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

(defadvice projectile-symbol-at-point (around projectile-suppress-symbol-at-point activate)
  (if custom/suppress-projectile-symbol-at-point
    (setq ad-return-value "")
    (setq ad-return-value ad-do-it)))

(defun custom/projectile-ag (arg)
  (interactive "p")
  (message "arg: %s" arg)
  (if (equal arg 4)
      (setq custom/suppress-projectile-symbol-at-point t)
    (setq custom/suppress-projectile-symbol-at-point nil))
  (call-interactively 'projectile-ag))

(defun isearch-forward-noeldoc ()
  "close eldoc temperaily"
  (interactive)
  (eldoc-mode -1)
  (isearch-forward)
  (eldoc-mode 1))

(defun isearch-backward-noeldoc ()
  "close eldoc temperaily"
  (interactive)
  (eldoc-mode -1)
  (isearch-backward)
  (eldoc-mode 1))

;TODO: make implemetation less straightforward or find "right way" to do it
(defun process-thing-at-point ()
  (interactive)
  (cond
   ((equal major-mode 'ag-mode) (compile-goto-error))
   ((or (equal major-mode 'jabber-chat-mode)
        (equal major-mode 'erc-mode)) (browse-url (thing-at-point 'url t)))

    (t (browse-url (thing-at-point 'url t)))))

(provide 'custom-navigate)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; custom-navigate.el ends here
