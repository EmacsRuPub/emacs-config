;; -*- coding: utf-8 -*-
;;
;; Filename: rc-multiple-cursors.el
;; Created: Пн авг 19 20:09:09 2013 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'multiple-cursors)

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)

(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-*") 'mc/mark-all-like-this)

(global-set-key (kbd "C-^") 'mc/edit-beginnings-of-lines)
(global-set-key (kbd "C-$") 'mc/edit-ends-of-lines)

(global-set-key (kbd "C-#") 'mc/mark-more-like-this-extended)
(global-set-key (kbd "C-%") 'mc/mark-all-in-region)
(global-set-key (kbd "C-(") 'mc/mark-all-like-this-in-defun)
(global-set-key (kbd "C-)") 'mc/mark-all-like-this-dwim)

(global-set-key (kbd "C-~") 'mc/sort-regions)
(global-set-key (kbd "C-!") 'mc/insert-numbers)
(global-set-key (kbd "C-|") 'mc/reverse-regions)

(provide 'rc-multiple-cursors)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-multiple-cursors.el ends here
