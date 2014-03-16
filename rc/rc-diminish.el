;;; rc-diminish.el ---

;; Copyright (C) 2012 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:

;; clean up modeline and hide standard minor modes
;; should be last so all modes are already loaded
(require 'diminish)

(diminish 'abbrev-mode)
(diminish 'auto-complete-mode " α")
(diminish 'auto-fill-function)
(diminish 'global-visual-line-mode)
(diminish 'undo-tree-mode)
(diminish 'visual-line-mode)
(diminish 'volatile-highlights-mode)
(diminish 'projectile-mode "prj")
(diminish 'git-gutter-mode)
(diminish 'eldoc-mode "ED")
(diminish 'whole-line-or-region-mode)

(provide 'rc-diminish)

;;; rc-diminish.el ends here
