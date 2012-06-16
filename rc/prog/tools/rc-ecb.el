;;; rc-ecb.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(require 'semantic/analyze)
(provide 'semantic-analyze)
(provide 'semantic-ctxt)
(provide 'semanticdb)
(provide 'semanticdb-find)
(provide 'semanticdb-mode)
(provide 'semantic-load)

(load-file (concat config-basedir "/ext/ecb/ecb.el"))

(require 'ecb)

(global-set-key (kbd "\C-xtq") 'ecb-toggle-ecb-windows)
(global-set-key (kbd "\C-xta") 'ecb-activate)
(global-set-key (kbd "\C-xtd") 'ecb-deactivate)

;;; rc-ecb.el ends here
