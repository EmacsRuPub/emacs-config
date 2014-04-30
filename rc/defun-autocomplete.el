;; -*- coding: utf-8 -*-
;;
;; Filename: defun-autocomplete.el
;; Created: Ср апр 30 19:16:41 2014 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'auto-complete)
(require 'yasnippet)

(defun ac-yasnippet-candidate ()
  (let ((table (yas/get-snippet-tables major-mode)))
    (if table
      (let (candidates (list))
            (mapcar (lambda (mode)
              (maphash (lambda (key value)
                (push key candidates))
              (yas/snippet-table-hash mode)))
            table)
        (all-completions ac-prefix candidates)))))

(defun ac-yasnippet-candidate-1 (table)
  (let ((hashtab (yas/snippet-table-hash table))
        (parent (if (fboundp 'yas/snippet-table-parent)
                    (car (yas/snippet-table-parent table))))
        candidates)
    (maphash (lambda (key value)
               (push key candidates))
             hashtab)
    (setq candidates (all-completions ac-prefix (nreverse candidates)))
    (if parent
        (setq candidates
              (append candidates (ac-yasnippet-candidate-1 parent))))
    candidates))

(defface ac-yasnippet-candidate-face
  '((t (:background "sandybrown" :foreground "black")))
  "Face for yasnippet candidate.")

(defface ac-yasnippet-selection-face
  '((t (:background "coral3" :foreground "white")))
  "Face for the yasnippet selected candidate.")

(defvar ac-source-yasnippet
  '((candidates . ac-yasnippet-candidate)
    (action . yas/expand)
    (limit . 3)
    (candidate-face . ac-yasnippet-candidate-face)
    (selection-face . ac-yasnippet-selection-face))
  "Source for Yasnippet.")

(defun set-auto-complete-as-completion-at-point-function ()
  (setq completion-at-point-functions '(auto-complete)))

(provide 'defun-autocomplete)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; defun-autocomplete.el ends here
