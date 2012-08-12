;;; emacs-rc-server.el --- working with server/client

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(unless (string-equal "root" (getenv "USER"))
  ;; Only start server mode if I'm not root
  (require 'server)
  (server-start))

(provide 'rc-server)

;;; emacs-rc-server.el ends here

