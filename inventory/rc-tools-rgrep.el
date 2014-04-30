;;; rc-tools-rgrep.el ---

;; Copyright (C) 2012 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:

(require 's)

(defvar git-grep-switches "--extended-regexp -I -n"
  "Switches to pass to `git grep'.")

(eval-after-load "grep"
  '(progn
     ;; Don't recurse into some directories
     (add-to-list 'grep-find-ignored-directories "target")
     (add-to-list 'grep-find-ignored-directories "node_modules")
     (add-to-list 'grep-find-ignored-directories "vendor")

     ;; Add custom keybindings
     (define-key grep-mode-map "q" 'rgrep-quit-window)
     (define-key grep-mode-map (kbd "C-<return>") 'rgrep-goto-file-and-close-rgrep)
     (define-key grep-mode-map (kbd "C-x C-s") 'wgrep-save-all-buffers)

     ;; Use same keybinding as occur
     (setq wgrep-enable-key "e")))

(provide 'rc-tools-rgrep)

;;; rc-tools-rgrep.el ends here
