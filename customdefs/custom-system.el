;; -*- coding: utf-8 -*-
;;
;; Filename: custom-system.el
;; Created: Вс июл 20 12:28:02 2014 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun server-save-edit ()
  (interactive)
  (save-buffer)
  (server-edit))

(defun save-buffer-clients-on-exit ()
  (interactive)
  (if (and (boundp 'server-buffer-clients) server-buffer-clients)
        (server-save-edit)
      (save-buffers-kill-emacs t)))

(provide 'custom-system)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; custom-system.el ends here
