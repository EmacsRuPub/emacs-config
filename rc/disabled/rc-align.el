;;; rc-align.el ---

;; Copyright (C) 2012 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:

(require 'align)

;; TODO create useful rules below, those for Ruby are EXAMPLES ONLY

(add-to-list 'align-rules-list
             '(ruby-comma-delimiter
                (regexp . ",\\(\\s-*\\)[^# \t\n]")
                (repeat . t)
                (modes . '(ruby-mode))))
(add-to-list 'align-rules-list
             '(ruby-hash-literal
                (regexp . "\\(\\s-*\\)=>\\s-*[^# \t\n]")
                (repeat . t)
                (modes . '(ruby-mode))))
(add-to-list 'align-rules-list
             '(ruby-assignment-literal
                (regexp . "\\(\\s-*\\)=\\s-*[^# \t\n]")
                (repeat . t)
                (modes . '(ruby-mode))))
(add-to-list 'align-rules-list ;TODO add to rcodetools.el
             '(ruby-xmpfilter-mark
                (regexp . "\\(\\s-*\\)# => [^#\t\n]")
                (repeat . nil)
                (modes . '(ruby-mode))))

(global-set-key "\C-c=" 'align-current)

(provide 'rc-align)

;;; rc-align.el ends here
