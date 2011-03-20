;;; emacs-rc-cmake.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

;#############################################################################
;#   Load extensions
;############################################################################
(autoload 'cmake-mode "cmake-mode" t)
(add-to-list 'auto-mode-alist '("CMakeLists\\.txt\\'" . cmake-mode))
(add-to-list 'auto-mode-alist '("\\.cmake\\'" . cmake-mode))

(require 'cmake-mode)


;#############################################################################
;#   Hooks
;############################################################################
(add-hook 'cmake-mode-hook 'custom/cmake-mode-hook)
(add-hook 'cmake-mode-hook 'common-hooks/comment-hook)
(add-hook 'cmake-mode-hook 'common-hooks/show-prog-keywords)
(add-hook 'cmake-mode-hook 'common-hooks/newline-hook)

;;; emacs-rc-cmake.el ends here

