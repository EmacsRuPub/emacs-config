;;; rc-dir-locals.el ---

;; Copyright (C) 2012 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:

(dir-locals-set-class-variables 'opossum-codestyle
                                '((nil . ((setq django-indent-width 4)
                                          (setq sgml-basic-offset 4)))))
(dir-locals-set-class-variables 'webdrive-codestyle
                                '((nil . ((setq django-indent-width 4)
                                          (setq sgml-basic-offset 4)))))

(dir-locals-set-directory-class "/home/octocat/workspace/opossum/" 'opossum-codestyle)
(dir-locals-set-directory-class "/home/octocat/workspace/webdrive/" 'webdrive-codestyle)

(provide 'rc-dir-locals)

;;; rc-dir-locals.el ends here
