;; -*- coding: utf-8 -*-
;;
;; Filename: base.el
;; Created: Ср июл 16 11:52:25 2014 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq home-directory (getenv "HOME"))
(setq global-username user-login-name)

(defun solidload (filename)
  (condition-case err
      (load filename)
    (error (display-warning 'initialization
                            (concat "Load of " filename " failed "
                                    (prin1-to-string err)
                                    (with-output-to-string (backtrace)))
                            :warning))))

(load-library "pathutil")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; base.el ends here
