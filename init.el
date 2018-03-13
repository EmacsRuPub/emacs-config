(setq debug-on-error t)
(setq debug-on-quit t)

(require 'package)
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
(package-initialize)

(unless (require 'quelpa nil t) ;;TODO: consider trying self-upgrades
  (with-temp-buffer
    (url-insert-file-contents "https://raw.github.com/quelpa/quelpa/master/bootstrap.el")
    (eval-buffer)))

(require 'cl)

(setq use-package-verbose t)
(setq use-package-hook-name-suffix "")

(mapcar
 (lambda (package)
   (unless (package-installed-p package)
     (unless package-archive-contents
       (package-refresh-contents))
     (package-install package)))
 ;;base system packages for bootstrapping
 '(use-package el-get))

(setq use-package-compute-statistics t)

(use-package quelpa :ensure t)
(use-package quelpa-use-package
  :ensure t
  :custom
  (quelpa-use-package-inhibit-loading-quelpa
   t "Improve performance"))

(use-package use-package-el-get
  :ensure t
  :config
  (use-package-el-get-setup))

(setq load-prefer-newer t)

(global-set-key (kbd "C-x C-.")
                (lambda ()
                  (interactive)
                  (let ((tangled-config-file (concat user-emacs-directory "config.el")))
                    (when (file-exists-p tangled-config-file) ;; because tangled file may be removed for some reason
                      (find-file tangled-config-file)
                      (use-package-lint)))))

;; open literate config fast in case of emergency (and not only)
(use-package iqa
  :ensure t
  :init
  (setq iqa-user-init-file (concat user-emacs-directory "config.org"))
  :config
  (iqa-setup-default))

(use-package restart-emacs
  :ensure t
  :config
  (global-set-key (kbd "C-x C-c") 'restart-emacs))

(use-package exec-path-from-shell
  :ensure t
  :if (memq window-system '(mac ns x))
  :custom
  (exec-path-from-shell-check-startup-files
   nil "Used WM(s) do not check non-interactive startup files anyway")
  :config
  (exec-path-from-shell-initialize))

(setq org-contrib-base '(org-agenda org-archive org-attach org-bbdb
                         org-bibtex org-clock org-docview org-habit
                         org-id org-info org-inlinetask org-irc
                         org-mouse org-protocol org-timer org-w3m))
(setq org-contrib-extra '(org-bookmark org-checklist org-collector
                          org-drill org-expiry org-index org-interactive-query
                          org-man org-velocity))
(setq org-modules `(,@org-contrib-base ,@org-contrib-extra))

(use-package bug-hunter :disabled)

(setq message-log-max t) ;; we don't want to lose any startup log info
(setq shell-file-name "/bin/bash")

(org-babel-load-file (concat (file-name-directory load-file-name) "config.org"))

(setq debug-on-error nil)
(setq debug-on-quit nil)
