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
  (setq aw-mode-line-face
        '((t (:foreground "white"))))
  (custom-set-faces
     '(aw-leading-char-face
       ((t (:inherit ace-jump-face-foreground :height 3.0))))))

(use-package swiper
  :config
  (bind-key "o" 'swiper custom-search-keymap))

(provide 'staging)

;;; staging.el ends here
