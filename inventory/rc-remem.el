;; -*- coding: utf-8 -*-
;;
;; Filename: rc-remem.el
;; Created: Вт май 21 11:03:26 2013 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "/usr/share/emacs/site-lisp/remem")
(require 'remem)
(setq remem-prog-dir "/usr/bin")
(setq remem-database-dir (expand-file-name "~/.remem"))
(setq remem-scopes-list
      '(("emacs-wiki" 3 20 100)
        ("plans" 3 20 100)))

(set-face-foreground 'remem-odd "White")

;; (define-key global-map (kbd "<f11> 1") 'remem-display-line-1)
;; (define-key global-map (kbd "<f11> 2") 'remem-display-line-2)
;; (define-key global-map (kbd "<f11> 3") 'remem-display-line-3)
;; (define-key global-map (kbd "<f11> 4") 'remem-display-line-4)
;; (define-key global-map (kbd "<f11> 5") 'remem-display-line-5)
;; (define-key global-map (kbd "<f11> 6") 'remem-display-line-6)
;; (define-key global-map (kbd "<f11> 7") 'remem-display-line-7)
;; (define-key global-map (kbd "<f11> 8") 'remem-display-line-8)
;; (define-key global-map (kbd "<f11> 9") 'remem-display-line-9)
(setq remem-load-original-suggestion t)

(defun sacha/remem-say-match (arg)
  (interactive "P")
  (save-excursion
    (set-buffer (get-buffer remem-buffer-name))
    (goto-char (point-min))
    (goto-line arg)
    (message (field-string-no-properties (+ (point) 21)))))

(provide 'rc-remem)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-remem.el ends here
