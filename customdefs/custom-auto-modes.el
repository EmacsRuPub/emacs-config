;; -*- coding: utf-8 -*-
;;
;; Filename: custom-auto-modes.el
;; Created: Вт июл  8 15:25:42 2014 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun pgsql-c-mode ()
  ;; sets up formatting for PostgreSQL C code
  (interactive)
  (c-mode)
  (setq-default tab-width 4)
  (c-set-style "bsd")             ; set c-basic-offset to 4, plus other stuff
  (c-set-offset 'case-label '+)   ; tweak case indent to match PG custom
  (setq fill-column 79)           ; matches what pgindent does
  (setq indent-tabs-mode t))      ; make sure we keep tabs when indenting

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; custom-auto-modes.el ends here
