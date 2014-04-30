;; -*- coding: utf-8 -*-
;;
;; Filename: rc-lang-javascript.el
;; Created: Вт апр 29 23:19:28 2014 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (add-to-list 'load-path custom-ext-path/ejacs)
;; (load-library "js2")

;; (setq-default js2-rebind-eol-bol-keys nil)

;; Use lambda for anonymous functions
;; (font-lock-add-keywords
;;  'js2-mode `(("\\(function\\) *("
;;               (0 (progn (compose-region (match-beginning 1)
;;                                         (match-end 1) "\u0192")
;;                         nil)))))

;; ;; Use right arrow for return in one-line functions
;; (font-lock-add-keywords
;;  'js2-mode `(("function *([^)]*) *{ *\\(return\\) "
;;               (0 (progn (compose-region (match-beginning 1)
;;                                         (match-end 1) "\u2190")
;;                         nil)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-lang-javascript.el ends here
