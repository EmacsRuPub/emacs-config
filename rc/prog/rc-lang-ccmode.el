;;; emacs-rc-ccmode.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

;#############################################################################
;#   Load extensions
;############################################################################
;; (load custom-ext-path/c-eldoc)

(require 'cc-mode)
(require 'info-look)


;#############################################################################
;#   Customizations
;############################################################################
(setq-default c-default-style (quote ((java-mode . "java") (other . "bsd"))))
(setq c-eldoc-includes "-I~/exp/include -I./ -I../ ")


;#############################################################################
;#   Setup
;############################################################################
(info-lookup-add-help
 :mode 'c-mode
 :regexp "[^][()'\" \t\n]+"
 :ignore-case t
 :doc-spec '(("(libc)Symbol Index" nil nil nil)))


;#############################################################################
;#   Hooks
;############################################################################
(defun custom/c-mode-ws-hook ()
  (c-set-style "linux")
  (let ((whitespace-style
      '(trailing lines-tail space-before-tab space-before-tab::tab newline
                 indentation empty space-after-tab space-after-tab::tab)))
    (whitespace-mode 0)
    (whitespace-mode 1))
  (auto-fill-mode t)
  (c-toggle-auto-hungry-state -1))

(defun custom/c-mode-common-hook ()
  ;; style customization
  (c-set-offset 'member-init-intro '++)
  (setq tab-width 4) ;; was 4
  (setq indent-tabs-mode nil)
  (c-set-offset 'substatement-open 0)
  (c-set-style "bsd")
  (setq c-basic-offset 4)
  (c-toggle-auto-hungry-state 0)
  ;; minor modes
  (auto-fill-mode 1)
  (gtags-mode 1)
  (hs-minor-mode 1)
  (c-turn-on-eldoc-mode)
  ;; local keys
  (local-set-key (kbd "<delete>") 'delete-char)
  ;; (company-mode 1)
  (setq show-trailing-whitespace t) ;; show trailing whitespace
)
(add-hook 'c-mode-common-hook 'custom/c-mode-common-hook)
(add-hook 'c++-mode-hook 'custom/c-mode-common-hook)
(add-hook 'c-mode-common-hook 'common-hooks/comment-hook)
(add-hook 'c-mode-common-hook 'common-hooks/show-prog-keywords)
;; (add-hook 'c-mode-hook 'custom/c-mode-ws-hook)
;; (add-hook 'c++-mode-hook 'custom/c-mode-ws-hook)
(add-hook 'c-mode-hook 'common-hooks/newline-hook)
(add-hook 'c++-mode-hook 'common-hooks/newline-hook)

(provide 'rc-lang-ccmode)

;;; emacs-rc-ccmode.el ends here
