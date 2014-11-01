;; -*- coding: utf-8 -*-
;;
;; Filename: systemtraits.el
;; Created: Ср май  7 01:21:59 2014 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(when (eq system-type 'darwin)
  (load "rc-darwin.el"))
(when (eq system-type 'gnu/linux)
  (load "rc-linux.el"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; systemtraits.el ends here
