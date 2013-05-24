;;; emacs-rc-server.el --- working with server/client

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(unless (and (string-equal "root" (getenv "USER"))
             (server-running-p))
  ;; Only start server mode if I'm not root and it is not running
  (require 'server)
  (server-start))

(provide 'rc-server)

;;; emacs-rc-server.el ends here
