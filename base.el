;; -*- coding: utf-8 -*-
;;
;; Filename: base.el
;; Created: Ср июл 16 11:52:25 2014 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun solidload (filename)
  (condition-case err
      (load filename)
    (error (display-warning 'initialization
                            (concat "Load of " filename " failed "
                                    (prin1-to-string err)
                                    (with-output-to-string (backtrace)))
                            :warning))))

(defun at-config-basedir (suffix)
  (concat config-basedir suffix))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; base.el ends here
