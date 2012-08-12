;;; rc-instantblogs.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

;#############################################################################
;#   Juick
;############################################################################
(require 'juick)

(setq juick-tmp-dir "~/.juick-avatars/")
(setq juick-tag-subscribed '("emacs" "vim" "linux" "juick" "GTD" "todo"))
(setq juick-icon-mode t)

(custom-set-faces '(psto-user-name-face
                    ((((type tty)) :foreground "yellow")
                     (t :foreground "goldenrod1"))))


;#############################################################################
;#   Psto
;############################################################################
(require 'psto)

(setq psto-tmp-dir "~/.psto-avatars/")

(custom-set-faces '(juick-user-name-face
                    ((((type tty)) :foreground "yellow")
                     (t :foreground "goldenrod1"))))

;#############################################################################
;#   Hooks
;############################################################################

(provide 'rc-instantblogs)

;;; rc-instantblogs.el ends here
