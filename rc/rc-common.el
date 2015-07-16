;;; rc-common.el ---

;; Copyright (C) 2015 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:

(load-library "time")

(use-package popwin)
(use-package epg)
(use-package edebug-x)

;;; Enable functions that are disabled by default
(put 'dired-find-alternate-file 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'erase-buffer 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'scroll-left 'disabled nil)
(put 'scroll-right 'disabled nil)
(put 'set-goal-column 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

(setq auto-save-file-name-transforms `((".*" ,emacs-tmp-dir t)))
(setq backup-by-copying t)
(setq backup-by-copying-when-linked t)
(setq backup-directory-alist `(("." . ,emacs-tmp-dir)))
(setq color-theme-is-global t)
(setq column-number-mode t)
(setq custom-buffer-done-kill t)
(setq delete-old-versions -1)
(setq disabled-command-function nil)
(setq display-time-day-and-date t)
(setq display-time-form-list (list 'time 'load))
(setq display-time-mail-file t)
(setq display-time-string-forms '( day " " monthname " (" dayname ") " 24-hours ":" minutes))
(setq echo-keystrokes 0.1)
(setq enable-local-variables nil)
(setq enable-recursive-minibuffers t)
(setq eval-expression-print-length nil)
(setq eval-expression-print-level nil)
(setq font-lock-maximum-decoration t)
(setq frame-title-format custom/frame-title-format)
(setq gc-cons-percentage 0.3)
(setq inhibit-startup-echo-area-message "octocat")
(setq inhibit-startup-message t)
(setq inhibit-startup-screen t)
(setq initial-scratch-message nil)
(setq line-number-mode t)
(setq locale-coding-system 'utf-8)
(setq password-cache-expiry 7200)
(setq print-circle t)
(setq print-gensym t)
(setq redisplay-dont-pause t)
(setq scalable-fonts-allowed t)
(setq size-indication-mode t)
(setq split-width-threshold nil)
(setq truncate-partial-width-windows nil)
(setq use-dialog-box nil)
(setq version-control t)
(setq visible-bell t)
(setq warning-suppress-types nil)
(setq openwith-associations
      '(("\\.pdf\\'" "zathura" (file))
        ("\\.djvu\\'" "zathura" (file))
        ("\\.\\(?:mpe?g\\|avi\\|wmv\\|mkv\\|flv\\|mp4\\)\\'" "vlc" (file))
        ("\\.\\(?:jp?g\\|png\\)\\'" "feh" (file))
        ("\\.doc\\'" "abiword" (file))
        ("\\.swf\\'" "swfdec-player" (file))
        ))

;; clean trailing whitespaces automatically
(setq custom/trailing-whitespace-modes
      '(
        c++-mode
        c-mode
        haskell-mode
        emacs-lisp-mode
        lisp-mode
        scheme-mode
        erlang-mode
        python-mode
        js-mode
        js2-mode
        html-mode
        lua-mode
))
;; untabify some modes
(setq custom/untabify-modes
      '(
        haskell-mode
        emacs-lisp-mode
        lisp-mode
        scheme-mode
        erlang-mode
        clojure-mode
        python-mode
))

(set-default buffer-file-coding-system 'utf-8-unix)
(set-default default-buffer-file-coding-system 'utf-8-unix)
(fset 'yes-or-no-p 'y-or-n-p)

(and (fboundp 'scroll-bar-mode) (scroll-bar-mode 0))
(prefer-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8 'utf-8-unix)
(set-default-coding-systems 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(menu-bar-mode -1)
(scroll-bar-mode 0)
(blink-cursor-mode 0)
(tool-bar-mode 0)
;; (global-hl-line-mode t) ;FIXME: regeression (24.4): corresponding overlay value is nil
(tooltip-mode nil)
(global-font-lock-mode t)
(display-battery-mode 1)
(display-time)

(auto-compression-mode t)
(unless (and (string-equal "root" (getenv "USER"))
             (server-running-p))
  ;; Only start server mode if I'm not root and it is not running
  (require 'server)
  (server-start))

(use-package uniquify
  :config
  (progn
    (setq uniquify-buffer-name-style 'post-forward)
    (setq uniquify-separator ":")
    (setq uniquify-ignore-buffers-re "^\\*")
    (setq uniquify-strip-common-suffix nil)))

(use-package rich-minority
  :config
  (setq rm-blacklist
        '(" GitGutter"
          " VHl"
          " WLR"
          " Emmet"
          " Wrap"
          " Fill"
          " Abbrev"
          " SliNav"
          " Helm"
          )))

(use-package backup-walker
  ;TODO: bind to key and other stuff
  )

(defun common-hooks/newline-hook ()
  (local-set-key (kbd "C-m") 'newline-and-indent)
  (local-set-key (kbd "<return>") 'newline-and-indent))

;; show FIXME/TODO/BUG keywords
(defun common-hooks/prog-helpers ()
  ;; highlight additional keywords
  (font-lock-add-keywords nil '(("\\<\\(FIXME\\|FIX_ME\\|FIX ME\\):" 1 font-lock-warning-face t)))
  (font-lock-add-keywords nil '(("\\<\\(BUG\\|BUGS\\):" 1 font-lock-warning-face t)))
  (font-lock-add-keywords nil '(("\\<\\(TODO\\|TO DO\\NOTE\\|TBD\\):" 1 font-lock-warning-face t)))
  (font-lock-add-keywords nil '(("\\<\\(DONE\\|HACK\\):" 1 font-lock-doc-face t)))
  ;; highlight too long lines
  (font-lock-add-keywords nil '(("^[^\n]\\{120\\}\\(.*\\)$" 1 font-lock-warning-face t)))
  )

(defun common-hooks/trailing-whitespace-hook ()
  (when (member major-mode custom/trailing-whitespace-modes)
    (delete-trailing-whitespace)))

(defun common-hooks/untabify-hook ()
  (when (member major-mode custom/untabify-modes)
    (untabify (point-min) (point-max))))

(add-hook 'before-save-hook 'common-hooks/trailing-whitespace-hook)
(add-hook 'before-save-hook 'common-hooks/untabify-hook)
(add-hook 'server-visit-hook
          (lambda () (local-set-key (kbd "C-c C-c") 'custom/server-save-edit)))
;; (add-hook 'kill-emacs-hook 'custom/save-buffer-clients-on-exit)

(global-set-key (kbd "C-x c") 'proced)

(provide 'rc-common)

;;; rc-common.el ends here
