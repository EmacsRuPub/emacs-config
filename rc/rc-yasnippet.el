;;; rc-yasnippet.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(require 'yasnippet) ;; not yasnippet-bundle

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

(setq yas/next-field-key '("<backtab>" "<S-tab>"))
(setq yas/prev-field-key '("<C-tab>"))
(setq yas/snippet-dirs custom/yasnippet-dir)
(yas--initialize)
(yas/load-directory custom/yasnippet-dir)

(setq yas/prompt-functions '(
                             yas/ido-prompt
                             yas/completing-prompt
                             yas/x-prompt
                             yas/no-prompt))

;; Wrap around region
(setq yas/wrap-around-region t)

;; hook for automatic reloading of changed snippets
(defun update-yasnippets-on-save ()
  (when (string-match "/resources/yasnippet" buffer-file-name)
    (yas/load-directory custom/yasnippet-dir)))
(add-hook 'after-save-hook 'update-yasnippets-on-save)

;; Jump to end of snippet definition
(define-key yas/keymap (kbd "<return>") 'yas/exit-all-snippets)
(define-key yas/keymap (kbd "C-e") 'yas/goto-end-of-active-field)
(define-key yas/keymap (kbd "C-a") 'yas/goto-start-of-active-field)

(provide 'rc-yasnippet)

;;; rc-yasnippet.el ends here
