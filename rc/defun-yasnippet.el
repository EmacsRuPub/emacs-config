;;; defun-yasnippet.el ---

;; Copyright (C) 2012 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:

;; Inter-field navigation
(defun yas/goto-end-of-active-field ()
  (interactive)
  (let* ((snippet (car (yas/snippets-at-point)))
         (position (yas/field-end (yas/snippet-active-field snippet))))
    (if (= (point) position)
        (move-end-of-line)
      (goto-char position))))

(defun yas/goto-start-of-active-field ()
  (interactive)
  (let* ((snippet (car (yas/snippets-at-point)))
         (position (yas/field-start (yas/snippet-active-field snippet))))
    (if (= (point) position)
        (move-beginning-of-line)
      (goto-char position))))

(defun yas-popup-isearch-prompt (prompt choices &optional display-fn)
  (when (featurep 'popup)
    (popup-menu*
     (mapcar
      (lambda (choice)
        (popup-make-item
         (or (and display-fn (funcall display-fn choice))
             choice)
         :value choice))
      choices)
     :prompt prompt
     :isearch t
     )))

(defun yas-safer-expand ()
  (let ((yas/fallback-behavior 'return-nil))
    (call-interactively 'yas/expand)))

(defun yas-ido-insert-snippets (&optional no-condition)
  (interactive "P")
  (let ((yas-prompt-functions '(yas/ido-prompt)))
    (yas/insert-snippet)))

(defun yasnippet-unbind-trigger-key ()
  "Unbind `yas/trigger-key'."
  (let ((key yas/trigger-key))
    (setq yas/trigger-key nil)
    (yas/trigger-key-reload key)))

(provide 'defun-yasnippet)

;;; defun-yasnippet.el ends here
