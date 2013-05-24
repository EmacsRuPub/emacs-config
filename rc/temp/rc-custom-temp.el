;;; rc-custom-temp.el ---

;; Copyright (C) 2012 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:

;; ;;;;;;;;;;;;;;;;;;;
;; ;;;; CUSTOM ;;;;;;;
;; ;;;;;;;;;;;;;;;;;;;
;; (put 'scroll-left 'disabled t)
;; (custom-set-variables
;;   ;; custom-set-variables was added by Custom.
;;   ;; If you edit it by hand, you could mess it up, so be careful.
;;   ;; Your init file should contain only one such instance.
;;   ;; If there is more than one, they won't work right.
;;  '(add-log-current-defun-function nil)
;;  '(auto-compression-mode t)
;;  '(auto-save-interval 40)
;;  '(auto-save-timeout 900)
;;  '(backup-by-copying t)
;;  '(backup-by-copying-when-linked t)
;;  '(backup-directory-alist (quote (("." . "~/.saves"))))
;;  '(before-save-hook (quote (time-stamp delete-trailing-whitespace)))
;;  '(blink-cursor-delay 1)
;;  '(blink-cursor-interval 0.6)
;;  '(browse-url-xterm-program "urxvt")
;;  '(byte-compile-generate-call-tree nil)
;;  '(change-log-default-name "CHANGELOG")
;;  '(color-theme-history-max-length 10)
;;  '(completion-max-candidates 15)
;;  '(completion-min-chars 3)
;;  '(completion-resolve-old-method (quote reject))
;;  '(delete-old-versions t)
;;  '(dired-recursive-copies (quote always))
;;  '(display-buffer-reuse-frames t)
;;  '(display-hourglass t)
;;  '(display-time-mode t)
;;  '(exec-path (quote ("/usr/local/sbin" "/usr/local/bin" "/usr/sbin" "/usr/bin" "/sbin" "/bin" "/usr/games" "/home/gwern/bin/bin")))
;;  '(file-cache-find-command-posix-flag t)
;;  '(file-cache-ignore-case t)
;;  '(file-precious-flag t)
;;  '(fill-column 80)
;;  '(font-lock-maximum-size (quote ((t))))
;;  '(font-lock-verbose 10000)
;;  '(frame-background-mode (quote dark))
;;  '(gc-cons-threshold 30000000)
;;  '(global-font-lock-mode t)
;;  '(hourglass-delay 2)
;;  '(icomplete-compute-delay 0.2)
;;  '(icomplete-mode t)
;;  '(indent-tabs-mode nil)
;;  '(inhibit-startup-screen t)
;;  '(initial-scratch-message "")
;;  '(ispell-following-word t)
;;  '(ispell-highlight-p t)
;;  '(ispell-program-name "aspell")
;;  '(ispell-silently-savep t)
;;  '(jde-compile-option-command-line-args (quote ("")))
;;  '(jde-compile-option-verbose t)
;;  '(jde-compiler (quote ("javac" "/usr/bin/javac")))
;;  '(kill-ring-max 120)
;;  '(markdown-command "pandoc --smart --number-sections --toc --reference-links")
;;  '(markdown-italic-underscore t)
;;  '(message-log-max 1024)
;;  '(mouse-yank-at-point t)
;;  '(read-file-name-completion-ignore-case t)
;;  '(save-place-file "~/.emacs.d/emacs-places")
;;  '(save-place-limit 1024)
;;  '(scroll-down-aggressively 0.4)
;;  '(scroll-up-aggressively 0.5)
;;  '(server-temp-file-regexp "^/tmp/.*|/draft$")
;;  '(show-paren-delay 1)
;;  '(show-paren-priority 500)
;;  '(show-paren-ring-bell-on-mismatch t)
;;  '(show-paren-style (quote mixed))
;;  '(tab-width 4)
;;  '(text-mode-hook (quote (flyspell-mode text-mode-hook-identify)))
;;  '(tramp-default-method "ssh")
;;  '(vc-follow-symlinks t)
;;  '(vc-make-backup-files t)
;;  '(version-control t)
;;  '(visible-bell t)
;;  '(window-min-height 3)
;;  '(words-include-escapes t)
;;  '(x-select-enable-clipboard t))

;; ====================


(custom-set-variables
 '(auto-save-interval 300)
 '(auto-save-list-file-prefix (concat iy-data-dir "autosaves/saves-"))
 '(auto-save-timeout 10)
 '(backup-directory-alist (list (cons "." (expand-file-name "~/.backup/emacs"))))
 '(delete-old-versions t)
 '(desktop-base-file-name ".emacs.desktop")
 '(desktop-path (list "." iy-data-dir))
 '(desktop-restore-eager 14)
 '(desktop-save (quote ask-if-new))
 '(desktop-load-locked-desktop t)
 '(kept-new-versions 20)
 '(kept-old-versions 5)
 '(recentf-arrange-rules (quote (("Elisp files (%d)" ".\\.el\\'") ("Java files (%d)" ".\\.java\\'") ("C/C++ files (%d)" ".\\.c\\(pp\\)?\\'" ".\\.h\\(pp\\)?\\'") ("Org files (%d)" ".\\.org\\'"))))
 '(recentf-exclude (quote ("semantic\\.cache" "COMMIT_EDITMSG" "git-emacs-tmp.*" "\\.breadcrumb" "\\.ido\\.last" "\\.projects.ede" "/g/org/")))
 '(recentf-menu-filter (quote recentf-arrange-by-rule))
 '(recentf-save-file (concat iy-data-dir "recentf"))
 '(recentf-max-saved-items 100)
 '(session-initialize (quote (de-saveplace session)))
 '(session-save-file (concat iy-data-dir "session"))
 '(vc-make-backup-files t)
 '(version-control t))

(defcustom iy-backup-enable-desktop
  t
  "Whether to use desktop-save-mode"
  :group 'iy-config
  :type 'boolean)

;;; rc-custom-temp.el ends here
