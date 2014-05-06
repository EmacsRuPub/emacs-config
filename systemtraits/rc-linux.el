;; -*- coding: utf-8 -*-
;;
;; Filename: rc-linux.el
;; Created: Ср май  7 01:19:34 2014 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq x-alt-keysym 'meta)

(when (eq window-system 'x)
  (eval-after-load "jabber"
    '(progn
       ;; TODO get rid of progn
       (require 'custom-jabber-linux)
       )))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-linux.el ends here
