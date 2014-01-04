;; -*- coding: utf-8 -*-
;;
;; Filename: rc-wrap-region.el
;; Created: Сб янв  4 17:30:54 2014 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(wrap-region-global-mode 1)

(wrap-region-add-wrapper "*" "*")
(wrap-region-add-wrapper "(" ")")
(wrap-region-add-wrapper "{-" "-}" "#")
(wrap-region-add-wrapper "/* " " */" "#" '(javascript-mode css-mode))

(provide 'rc-wrap-region)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-wrap-region.el ends here
