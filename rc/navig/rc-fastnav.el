;;; rc-fastnav.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(require 'fastnav)

(global-set-key (kbd "M-n z") 'fastnav-zap-up-to-char-forward)
(global-set-key (kbd "M-n Z") 'fastnav-zap-up-to-char-backward)
(global-set-key (kbd "M-n s") 'fastnav-jump-to-char-forward)
(global-set-key (kbd "M-n S") 'fastnav-jump-to-char-backward)
(global-set-key (kbd "M-n r") 'fastnav-replace-char-forward)
(global-set-key (kbd "M-n R") 'fastnav-replace-char-backward)
(global-set-key (kbd "M-n i") 'fastnav-insert-at-char-forward)
(global-set-key (kbd "M-n I") 'fastnav-insert-at-char-backward)
(global-set-key (kbd "M-n j") 'fastnav-execute-at-char-forward)
(global-set-key (kbd "M-n J") 'fastnav-execute-at-char-backward)
(global-set-key (kbd "M-n k") 'fastnav-delete-char-forward)
(global-set-key (kbd "M-n K") 'fastnav-delete-char-backward)
(global-set-key (kbd "M-n m") 'fastnav-mark-to-char-forward)
(global-set-key (kbd "M-n M") 'fastnav-mark-to-char-backward)

(global-set-key (kbd "M-n p") 'fastnav-sprint-forward)
(global-set-key (kbd "M-n P") 'fastnav-sprint-backward)


;;; rc-fastnav.el ends here
