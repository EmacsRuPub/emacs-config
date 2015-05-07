;;; staging.el ---

;; Copyright (C) 2015 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:

(use-package sauron
  ;; note, you add (setq sauron-debug t) to get errors which can debug if
  ;; there's something wrong; normally, we catch such errors, since e.g an error
  ;; in one of the hooks may cause ERC to fail (i.e., the message won't come
  ;; trough).
  :config
  (progn
    (setq sauron-separate-frame nil)
    (setq sauron-hide-mode-line t)
    (setq sauron-max-line-length 200)
    (setq sauron-modules
     '(sauron-erc sauron-dbus sauron-org sauron-notifications))
    (add-hook 'sauron-event-added-functions 'sauron-fx-notify)
    (bind-key "C-c r t" 'sauron-toggle-hide-show)
    (bind-key "C-c r c" 'sauron-clear)
    (sauron-start)
    ))

;; TODO: extract emacs init file name
;; TODO: deal with emacs server someway
(defun custom/test-emacs-config ()
  (interactive)
  (require 'async)
  (async-start
   (lambda () (shell-command-to-string
          "emacs --batch --eval \"
(condition-case e
    (progn
      (load \\\"~/.emacs.d/init.el\\\")
      (message \\\"-OK-\\\"))
  (error
   (message \\\"ERROR!\\\")
   (signal (car e) (cdr e))))\""))
   `(lambda (output)
      (if (string-match "-OK-" output)
          (when ,(called-interactively-p 'any)
            (message "All is well"))
        (switch-to-buffer-other-window "*startup error*")
        (delete-region (point-min) (point-max))
        (insert output)
        (search-backward "ERROR!")))))

(defhydra hydra-magit (:color teal :hint nil)
   "
PROJECT: %(projectile-project-root)

     Immuting            Mutating
-----------------------------------------
  _s_: status          _c_: checkout
  _l_: log             _B_: branch mgr
  _f_: file log
  _r_: reflog
  _w_: diff worktree
  _t_: time machine

"
  ("s" magit-status)
  ("f" magit-file-log)
  ("c" magit-checkout)
  ("w" magit-diff-working-tree)
  ("r" magit-reflog)
  ("B" magit-branch-manager)
  ("l" magit-log)
  ("t" git-timemachine))
(global-set-key (kbd "C-'") 'hydra-magit/body)

(defvar custom/transform-whole-words nil)

(defadvice upcase-word (before upcase-word-advice activate)
  (when (and (not (looking-back "\\b")) custom/transform-whole-words)
    (backward-word)))

(defadvice downcase-word (before downcase-word-advice activate)
  (when (and (not (looking-back "\\b")) custom/transform-whole-words)
    (backward-word)))

(defadvice capitalize-word (before capitalize-word-advice activate)
  (when (and (not (looking-back "\\b")) custom/transform-whole-words)
    (backward-word)))

(provide 'staging)

;;; staging.el ends here
