;; -*- coding: utf-8 -*-
;;
;; Filename: rc-special-major-modes.el
;; Created:  Sun May 4 23:57:55 2014 +0400
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(autoload 'smerge-mode "smerge-mode" nil t)

(defun custom/sh-check-finish-hook (buf msg)
  "Function, that is executed at the end of sh check"
  (when (not (string-match "finished" msg))
    (next-error 1 t)))

(defun custom/sh-check-syntax ()
  "Check syntax of current file"
  (interactive)
  (when (string-match "^\\(ba\\|z\\)sh" (symbol-name sh-shell))
    (save-some-buffers t)
    (compilation-start (concat (symbol-name sh-shell) " -n " (buffer-file-name))
                       'sh-check-mode)))

(defun sm-try-smerge ()
  (save-excursion
    (goto-char (point-min))
    (when (re-search-forward "^<<<<<<< " nil t)
      (smerge-mode 1))))

(define-compilation-mode sh-check-mode "SH"
  "Mode for check sh source code."
  (set (make-local-variable 'compilation-disable-input) t)
  (set (make-local-variable 'compilation-scroll-output) nil)
  (set (make-local-variable 'compilation-finish-functions)
       (list 'custom/sh-check-finish-hook)))

(add-hook 'sh-mode-hook 'common-hooks/prog-helpers)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(add-hook 'sh-mode-hook 'common-hooks/newline-hook)
(add-hook 'find-file-hooks 'sm-try-smerge t)

(define-key sh-mode-map (kbd "C-c l") 'custom/sh-check-syntax)

(provide 'rc-special-major-modes)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-special-major-modes.el ends here
