;;; rc-el-get.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(add-to-list 'load-path (at-config-basedir "el-get/el-get"))

(setq el-get-git-install-url "http://github.com/wiedzmin/el-get.git")

(unless (require 'el-get nil t)
  (url-retrieve
   "https://github.com/wiedzmin/el-get/raw/master/el-get-install.el"
   (lambda (s)
     (let (el-get-master-branch)
       (end-of-buffer)
       (eval-print-last-sexp)))))

(require 'packages)

(add-to-list 'el-get-recipe-path (at-config-basedir "el-get-custom-recipes"))

(el-get nil el-get-packages)

;;; rc-el-get.el ends here
