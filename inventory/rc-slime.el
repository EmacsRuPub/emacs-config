(defun slime-sanitize-bindings ()
  "Removes SLIME's keybinding on C-c x"
  (cond ((boundp 'slime-mode-map)
         (define-key slime-mode-map (kbd "C-c x") nil)
         (message "slime keybinding C-c x has been sanitized"))
        ('t (message "slime keybindings not sanitized"))))
(add-hook 'slime-mode-hook 'slime-sanitize-bindings)

;; (defun slime-quit-lisp (&optional kill)
;;   "Quit lisp, kill the inferior process and associated buffers."
;;   (interactive "P")
;;   (slime-quit-lisp-internal (slime-connection) 'slime-quit-sentinel kill))

;; (defadvice exit-swank (before slime-quit-lisp
;;                               (&optional kill))
  "Exit StumpWM Swank server before exiting Slime REPL"

;; (defadvice previous-line (before next-line-at-end
;;                                       (&optional arg try-vscroll))
;;        "Insert an empty line when moving up from the top line."
;;        (if (and next-line-add-newlines (= arg 1)
;;                 (save-excursion (beginning-of-line) (bobp)))
;;            (progn
;;              (beginning-of-line)
;;              (newline))))
