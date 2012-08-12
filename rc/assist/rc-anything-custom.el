;;; rc-anything-custom.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(defvar anything-contentrees-c-source-file-search
 '((name . "Contentrees Search")
  (candidates . (lambda ()
          (let ((args
              (format "'%s' \\( -path \\*/.svn \\) -prune
-o -iregex '.*%s.*' -print"
                  (get-source-directory "contentrees")
                  anything-pattern)))
          (start-process-shell-command "file-search-process" nil
                  "find" args))))
  (type . file)
  (requires-pattern . 4)
  (delayed))
 "Source for searching matching files in contentrees recursively.")

(defvar anything-weblocks-saikat-c-source-file-search
 '((name . "Weblocks-saikat Search")
  (candidates . (lambda ()
          (let ((args
              (format "'%s' \\( -path \\*/.svn \\) -prune
-o -iregex '.*%s.*' -print"
                  (get-source-directory "weblocks-saikat")
                  anything-pattern)))
          (start-process-shell-command "file-search-process" nil
                  "find" args))))
  (type . file)
  (requires-pattern . 4)
  (delayed))
 "Source for searching matching files in weblocks-saikat recursively.")

(provide 'rc-anything-custom)

;;; rc-anything-custom.el ends here
