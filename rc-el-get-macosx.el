;;; rc-el-get.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(add-to-list 'load-path (concat config-basedir "el-get/el-get"))

(unless (require 'el-get nil t)
  (url-retrieve
   "https://github.com/dimitri/el-get/raw/master/el-get-install.el"
   (lambda (s)
     (end-of-buffer)
     (eval-print-last-sexp))))

(load-file (concat config-basedir "el-get-sources/sources-common.el"))
(load-file (concat config-basedir "el-get-sources/sources-emacswiki.el"))
(load-file (concat config-basedir "el-get-sources/sources-custom.el"))

(setq el-get-sources
      (append
       el-get-sources-common
       el-get-sources-emacswiki
       el-get-sources-custom))

(el-get 'sync)

;;; rc-el-get.el ends here
