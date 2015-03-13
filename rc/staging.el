;;; staging.el ---

;; Copyright (C) 2015 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:

(use-package ace-window
  :init
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  (setq aw-background nil)
  (setq aw-leading-char-style 'char)
  (ace-window-display-mode)
  (set-face-attribute 'aw-mode-line-face nil :foreground "white")
  (custom-set-faces
     '(aw-leading-char-face
       ((t (:inherit ace-jump-face-foreground :height 3.0))))))

(use-package ace-link
  :config
  (progn
    (ace-link-setup-default)
    (define-key org-mode-map (kbd "M-o") 'ace-link-org)))

(use-package sauron
  ;; note, you add (setq sauron-debug t) to get errors which can debug if
  ;; there's something wrong; normally, we catch such errors, since e.g an error
  ;; in one of the hooks may cause ERC to fail (i.e., the message won't come
  ;; trough).
  :config
  (progn
    (setq sauron-separate-frame nil)
    (setq sauron-hide-mode-line t)
    (setq sauron-max-line-length 200)
    (setq sauron-modules
     '(sauron-erc sauron-dbus sauron-org sauron-notifications))
    (add-hook 'sauron-event-added-functions 'sauron-fx-notify)
    (bind-key "C-c r t" 'sauron-toggle-hide-show)
    (bind-key "C-c r c" 'sauron-clear)
    (sauron-start)
    ))

(provide 'staging)

;;; staging.el ends here
