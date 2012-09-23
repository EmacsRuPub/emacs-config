;;; emacs-rc-javascript.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

;#############################################################################
;#   Load extensions
;############################################################################
;; (add-to-list 'load-path custom-ext-path/ejacs)
(load-library "js2-mode")
;; (load-library "js2")

(autoload 'js2-mode "js2" nil t)
(autoload 'js2-mode "js2-mode" nil t)
(autoload 'js-console "js-console" nil t)


;#############################################################################
;#   Customizations
;############################################################################
(setq js2-use-font-lock-faces t)
(setq js2-allow-keywords-as-property-names nil)
(setq js2-bounce-indent-flag nil)
(setq js2-cleanup-whitespace t)
(setq js2-enter-indents-newline nil)
(setq js2-highlight-level 3)
(setq js2-indent-on-enter-key nil)
(setq js2-skip-preprocessor-directives t)
(setq js2-basic-offset 4)

(provide 'rc-lang-javascript)

;;; emacs-rc-javascript.el ends here
