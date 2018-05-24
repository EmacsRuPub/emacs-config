(setq debug-on-error t)
(setq debug-on-quit t)

(setq load-prefer-newer t)
(setq message-log-max t) ;; we don't want to lose any startup log info
(setq shell-file-name "/bin/bash")

(defvar literate-config-filename "config.org")
(defvar tangled-config-filename (concat (file-name-sans-extension literate-config-filename) ".el"))

;; ================= Emergency keybindings =================
(global-set-key (kbd "C-x C-.") ;; Run use-package linter
                (lambda ()
                  (interactive)
                  (let ((tangled-config-file (concat user-emacs-directory "config.el")))
                    (when (file-exists-p tangled-config-file) ;; because tangled file may be removed for some reason
                      (find-file tangled-config-file)
                      (use-package-lint)))))
(global-set-key (kbd "C-x C-,") #'goto-char)
;; =========================================================

(require 'cl)

;; =================== Package management ===================
(require 'package)
(unless package--initialized
  (package-initialize))
(setq package-enable-at-startup nil)

(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives
             '("org" . "https://orgmode.org/elpa/"))
(setf (cdr (assoc "gnu" package-archives))
      "https://elpa.gnu.org/packages/")
(setq package-archive-priorities
      '(("melpa-stable" . 5)
        ("gnu" . 5)
        ("melpa" . 10)))

(mapcar
 (lambda (package)
   (unless (package-installed-p package)
     (unless package-archive-contents
       (package-refresh-contents))
     (package-install package)))
 ;;base system packages for bootstrapping
 '(use-package el-get))

(setq use-package-compute-statistics t)
(setq use-package-verbose t)
(setq use-package-hook-name-suffix "")
(put 'use-package 'lisp-indent-function 1)

(unless (require 'quelpa nil t) ;;TODO: consider trying self-upgrades
  (with-temp-buffer
    (url-insert-file-contents "https://raw.github.com/quelpa/quelpa/master/bootstrap.el")
    (eval-buffer)))

(use-package quelpa :ensure t)
(use-package quelpa-use-package
  :ensure t
  :custom
  (quelpa-use-package-inhibit-loading-quelpa
   t "Improve startup performance"))

(add-hook 'emacs-startup-hook
          (lambda ()
            (message "Emacs ready in %s with %d garbage collections."
                     (format "%.2f seconds"
                             (float-time
                              (time-subtract after-init-time before-init-time)))
                     gcs-done)))

(use-package use-package-el-get
  :ensure t
  :config
  (use-package-el-get-setup))
;; =========================================================

;; ============= A bunch of essential packages =============

(use-package exec-path-from-shell
  :ensure t
  :if (memq window-system '(mac ns))
  :custom
  (exec-path-from-shell-check-startup-files
   nil "Used WM(s) do not check non-interactive startup files anyway")
  :config
  (exec-path-from-shell-initialize))

(use-package bug-hunter :disabled)
;; =========================================================

(org-babel-load-file (concat (file-name-directory load-file-name) literate-config-filename))

;; ======= A bunch of essential packages (continued) =======
(use-package iqa ;; open literate config fast in case of emergency (and not only)
  :ensure t
  :init
  (setq iqa-user-init-file (concat user-emacs-directory literate-config-filename))
  :config
  (iqa-setup-default))

(use-package restart-emacs
  :ensure t
  :config
  (global-set-key (kbd "C-x C-c") 'restart-emacs))
;; =========================================================

(setq debug-on-error nil)
(setq debug-on-quit nil)
