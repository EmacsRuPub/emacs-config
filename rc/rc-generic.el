;;; rc-generic.el ---

;; Copyright (C) 2012 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:

(require 'generic)
(require 'generic-x)

(define-generic-mode 'keymap-mode
  '("#")
  '("control" "meta" "shift" "alt" "altgr" "compose" "keycode")
  nil
  '(".keymap\\'" ".map\\'")
  nil)

(setq generic-default-modes (delete 'javascript-generic-mode
                                    generic-default-modes))

(provide 'rc-generic)

;;; rc-generic.el ends here
