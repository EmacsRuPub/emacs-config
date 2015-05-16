;; -*- coding: utf-8 -*-
;;
;; Filename: custom-system.el
;; Created: Вс июл 20 12:28:02 2014 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define-namespace custom/

(defun server-save-edit ()
  (interactive)
  (save-buffer)
  (server-edit))

(defun save-buffer-clients-on-exit ()
  (interactive)
  (if (and (boundp 'server-buffer-clients) server-buffer-clients)
      (server-save-edit)
    (save-buffers-kill-emacs t)))

;;TODO: maybe implement as advice
(defun toggle-input-method ()
  "Toggle input method while keeping system keyboard layout in latin.
   Essential for WMs without this functionality built-in."
  (interactive)
  (toggle-input-method)
  (when (executable-find "kbdd")
    (start-process "dbus-send"
                   nil
                   "dbus-send"
                   "--dest=ru.gentoo.KbddService"
                   "/ru/gentoo/KbddService"
                   "ru.gentoo.kbdd.set_layout"
                   "uint32:1")))

)

(provide 'custom-system)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; custom-system.el ends here
