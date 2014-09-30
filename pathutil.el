;; -*- coding: utf-8 -*-
;;
;; Filename: pathutil.el
;; Created: Пн авг 25 23:27:14 2014 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;TODO: unify slashes usage

(defun at-config-basedir (&optional suffix)
  (concat config-basedir suffix))

(defun at-homedir (&optional suffix)
  (concat home-directory suffix))

(defun at-org-dir (&optional suffix)
  (concat (at-homedir "/org/main") suffix))

(defun at-org-inventory-dir (&optional suffix)
  (concat (at-homedir "/org/inventory") suffix))

(defun at-org-mastering-dir (&optional suffix)
  (concat (at-homedir "/org/mastering") suffix))

(defun at-org-job-dir (&optional suffix)
  (concat (at-homedir "/org/job") suffix))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; pathutil.el ends here
