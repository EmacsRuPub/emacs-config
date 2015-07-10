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

;;;###autoload
(defun keys-describe-prefixes ()
  (interactive)
  (with-output-to-temp-buffer "*Bindings*"
    (dolist (letter-group (list
                           (cl-loop for c from ?a to ?z
                                    collect (string c))
                           (cl-loop for c from ?α to ?ω
                                    collect (string c))))
      (dolist (prefix '("" "C-" "M-" "C-M-"))
        (princ (mapconcat
                (lambda (letter)
                  (let ((key (concat prefix letter)))
                    (format ";; (global-set-key (kbd \"%s\") '%S)"
                            key
                            (key-binding (kbd key)))))
                letter-group
                "\n"))
        (princ "\n\n")))))

(defun remove-elc-on-save ()
  "If you're saving an elisp file, likely the .elc is no longer valid."
  (make-local-variable 'after-save-hook)
  (add-hook 'after-save-hook
            (lambda ()
              (if (file-exists-p (concat buffer-file-name "c"))
                  (delete-file (concat buffer-file-name "c"))))))

)

(provide 'custom-system)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; custom-system.el ends here
