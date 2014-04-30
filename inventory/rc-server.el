;; -*- coding: utf-8 -*-
;;
;; Filename: rc-server.el
;; Created: Чт апр  4 14:05:51 2013 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; ----------
;; (defun server-save-edit ()
;;   (interactive)
;;   (save-buffer)
;;   (server-edit))

;; (add-hook 'server-visit-hook
;;           (lambda ()
;;             (local-set-key [(control c) (control c)] 'server-save-edit)
;;             ))

;; (global-set-key "\C-x\C-c"
;;                 '(lambda () (interactive)
;;                    (progn (if (and (boundp 'server-buffer-clients) server-buffer-clients)
;;                               (server-edit)
;;                             (save-buffers-kill-emacs t)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-server.el ends here
