;;; rc-markdown.el ---

;; Copyright (C) 2012 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:

(autoload 'markdown-mode "markdown-mode")

(eval-after-load 'markdown-mode
  '(progn
     (define-key markdown-mode-map (kbd "C-c C-v") 'markdown-preview)
     (define-key markdown-mode-map (kbd "<tab>") 'yas/expand)
     ))

(provide 'rc-markdown)

;;; rc-markdown.el ends here
