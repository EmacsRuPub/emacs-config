;;; emacs-rc-iswitchb.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(require 'iswitchb)
(require 'iswitchb-highlight)

(iswitchb-mode 1)
(iswitchb-default-keybindings)

(setq iswitchb-case t)
(setq iswitchb-default-method 'samewindow)


;#############################################################################
;#   Keybindings
;############################################################################
(defun iswitchb-local-keys ()
  (mapc (lambda (K)
          (let* ((key (car K)) (fun (cdr K)))
            (define-key iswitchb-mode-map (edmacro-parse-keys key) fun)))
        '(("<right>" . iswitchb-next-match)
          ("<left>"  . iswitchb-prev-match)
          ("<up>"    . ignore             )
          ("<down>"  . ignore             ))))
(add-hook 'iswitchb-define-mode-map-hook 'iswitchb-local-keys)


;#############################################################################
;#   Buffer ignores
;############################################################################
(add-to-list 'iswitchb-buffer-ignore "*Org Agenda*")
(add-to-list 'iswitchb-buffer-ignore "\\*Apropos\\*")
(add-to-list 'iswitchb-buffer-ignore "\\*Article\\*")
(add-to-list 'iswitchb-buffer-ignore "\\*BBDB\\*")
(add-to-list 'iswitchb-buffer-ignore "\\*Backtrace")
(add-to-list 'iswitchb-buffer-ignore "\\*Buffer")
(add-to-list 'iswitchb-buffer-ignore "\\*CEDET")
(add-to-list 'iswitchb-buffer-ignore "\\*Calc")
(add-to-list 'iswitchb-buffer-ignore "\\*Calendar\\*")
(add-to-list 'iswitchb-buffer-ignore "\\*Compile-Log\\*")
(add-to-list 'iswitchb-buffer-ignore "\\*Completions")
(add-to-list 'iswitchb-buffer-ignore "\\*Customize")
(add-to-list 'iswitchb-buffer-ignore "\\*ECB")
(add-to-list 'iswitchb-buffer-ignore "\\*ESS\\*")
(add-to-list 'iswitchb-buffer-ignore "\\*GTAGS")
(add-to-list 'iswitchb-buffer-ignore "\\*Git ")
(add-to-list 'iswitchb-buffer-ignore "\\*Help")
(add-to-list 'iswitchb-buffer-ignore "\\*Quail Com")
(add-to-list 'iswitchb-buffer-ignore "\\*Shell Command")
(add-to-list 'iswitchb-buffer-ignore "\\*Symref")
(add-to-list 'iswitchb-buffer-ignore "\\*cvs-commit")
(add-to-list 'iswitchb-buffer-ignore "\\*cvs\\*")
(add-to-list 'iswitchb-buffer-ignore "\\*fsm-debug")
(add-to-list 'iswitchb-buffer-ignore "\\*git-")
(add-to-list 'iswitchb-buffer-ignore "\\*gitsum")
(add-to-list 'iswitchb-buffer-ignore "\\*inferior-")
(add-to-list 'iswitchb-buffer-ignore "\\*info\\*")
(add-to-list 'iswitchb-buffer-ignore "\\*magit")
(add-to-list 'iswitchb-buffer-ignore "\\*reg group-leader\\*")
(add-to-list 'iswitchb-buffer-ignore "\\*semantic")
(add-to-list 'iswitchb-buffer-ignore "\\*sent mail")
(add-to-list 'iswitchb-buffer-ignore "\\*sent reply")
(add-to-list 'iswitchb-buffer-ignore "\\*sent wide reply")
(add-to-list 'iswitchb-buffer-ignore "\\*slime-")
(add-to-list 'iswitchb-buffer-ignore "\\*svn")
(add-to-list 'iswitchb-buffer-ignore "\\*trace of SMTP")
(add-to-list 'iswitchb-buffer-ignore "\\*w3m\\*")
(add-to-list 'iswitchb-buffer-ignore "\\.bbdb")
(add-to-list 'iswitchb-buffer-ignore "\\.cvsignore")
(add-to-list 'iswitchb-buffer-ignore "\\.hgignore")
(add-to-list 'iswitchb-buffer-ignore "\\.newsrc-dribble")
(add-to-list 'iswitchb-buffer-ignore "^ ")
(add-to-list 'iswitchb-buffer-ignore "^[tT][aA][gG][sS]$")
(add-to-list 'iswitchb-buffer-ignore "^\\.cabal$")
(add-to-list 'iswitchb-buffer-ignore "irc\\.")

(provide 'rc-iswitchb)

;;; emacs-rc-iswitchb.el ends here
