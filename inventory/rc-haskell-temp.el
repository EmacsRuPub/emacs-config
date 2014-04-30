;;; rc-haskell-temp.el ---

;; Copyright (C) 2012 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:

;;  '(haskell-doc-show-global-types t)
;;  '(haskell-hoogle-command "hoogle")
;;  '(haskell-program-name "ghci \"+.\"")
;;  '(inferior-haskell-wait-and-jump t)

;; ;Haskell-mode is provided through Ubuntu's haskell-mode package.
;; ;This changes some of the modules loaded.
;; ;; (idle-require "haskell-mode")
;; (idle-require 'haskell-mode)
;; ;; (load "~/.emacs.d/haskell-mode/haskell-site-file.elc")
;; (eval-after-load "haskell-mode" '(progn
;;                                    (require 'inf-haskell)
;;                                    (setq auto-mode-alist
;;                                          (append auto-mode-alist
;;                                                  '(("\\.[hg]s$"  . haskell-mode)
;;                                                    ("\\.hi$"     . haskell-mode)
;;                                                    ("\\.l[hg]s$" . literate-haskell-mode))))

;;                                    (autoload 'haskell-mode "haskell-mode"
;;                                      "Haskell programing major mode." t)
;;                                    (autoload 'literate-haskell-mode "haskell-mode"
;;                                      "Literate Haskell script major mode." t)

;;                                    ;Spellcheck comments
;;                                    (add-hook 'haskell-mode-hook 'flyspell-prog-mode)

;;                                    ;<http://www.emacswiki.org/cgi-bin/wiki/HaskellMode>
;;                                    (add-hook 'haskell-mode-hook
;;                                              #'(lambda ()
;;                                                  (setq comment-padding " "
;;                                                        comment-start "--")))

;;                                    ;Use my neat Unicode stuff
;;                                    (setq haskell-font-lock-symbols 'unicode)

;;                                    ;Default behaviour is to always jump to the GHCi window.
;;                                    ;Jump back automatically unless errors.
;;                                    (defadvice haskell-ghci-load-file (after name)
;;                                      (other-window 1))
;;                                    (ad-activate 'haskell-ghci-load-file t)

;;                                    ;Reflow comments
;;                                    (add-hook 'haskell-mode-hook
;;                                              (lambda ()
;;                                                (auto-fill-mode 1)
;;                                                (set (make-local-variable
;;                                                      'fill-nobreak-predicate)
;;                                                     (lambda ()
;;                                                       (not (eq (get-text-property (point) 'face)
;;                                                                'font-lock-comment-face))))))
;;                                         ; Highlight trailing whitespace in haskell files
;;                                    (add-hook 'haskell-mode-hook
;;                                              '(lambda ()
;;                                                 (setq show-trailing-whitespace t)))))



;;; rc-haskell-temp.el ends here
