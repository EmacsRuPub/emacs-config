(setq config-basedir (file-name-directory
                      (or (buffer-file-name) load-file-name)))

(setq home-directory (getenv "HOME"))
(setq global-username user-login-name)

(setq diredp-hide-details-initially-flag nil)

(defun reverse-input-method (input-method)
  "Build the reverse mapping of single letters from INPUT-METHOD."
  (interactive
   (list (read-input-method-name "Use input method (default current): ")))
  (if (and input-method (symbolp input-method))
      (setq input-method (symbol-name input-method)))
  (let ((current current-input-method)
        (modifiers '(nil (control) (meta) (control meta))))
    (when input-method
      (activate-input-method input-method))
    (when (and current-input-method quail-keyboard-layout)
      (dolist (map (cdr (quail-map)))
        (let* ((to (car map))
               (from (quail-get-translation
                      (cadr map) (char-to-string to) 1)))
          (when (and (characterp from) (characterp to))
            (dolist (mod modifiers)
              (define-key local-function-key-map
                (vector (append mod (list from)))
                (vector (append mod (list to)))))))))
    (when input-method
      (activate-input-method current))))

;TODO: unify slashes usage
(defun at-config-basedir (&optional suffix)
  (concat config-basedir suffix))

(defun at-homedir (&optional suffix)
  (concat home-directory suffix))

(defun at-org-dir (&optional suffix)
  (concat (at-homedir "/org") suffix))

(defun at-data-dir (&optional suffix)
  (concat (at-config-basedir "data") suffix))

(reverse-input-method 'russian-computer)
(setq shell-file-name "/bin/bash")
(setq message-log-max t)

(setq custom-file (at-config-basedir "customizations.el"))

;; A bunch of directories for various working datasets
;; As the order of loading corresponding extensions,
;; is cumbersome to maintain we should customize them ASAP (here)
;;TODO: think of less straightforward customization way
(setq auto-save-list-file-prefix (at-data-dir "/auto-save-list/.saves-"))
(setq bookmark-default-file (at-data-dir "/bookmarks"))
(setq tramp-persistency-file-name (at-data-dir "/tramp"))
(setq eshell-directory-name (at-data-dir "/eshell/"))
(setq shared-game-score-directory (at-data-dir "/games"))
(setq pcache-directory (at-data-dir "/var/pcache/"))
(setq url-configuration-directory (at-data-dir "/url/"))
(setq request-storage-directory (at-data-dir "/request"))
(setq image-dired-dir (at-data-dir "/image-dired/"))

(mapcar 'load
        (mapcar
         (lambda (path) (at-config-basedir path))
         '("constants.el"
           "credentials.el.gpg"
           )))

(require 'package)
(add-to-list 'package-archives
       '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
       '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives
       '("elpa" . "http://tromey.com/elpa/"))
(add-to-list 'package-archives
       '("org" . "http://orgmode.org/elpa/"))
(package-initialize)

(mapcar
 (lambda (package)
   (unless (package-installed-p package)
     (package-install package)))
 ;;base system packages for bootstrapping
 '(bind-key diminish use-package f names))

(require 'use-package)
(setq use-package-verbose t)
(setq load-prefer-newer t)

(use-package auto-compile
  :ensure t
  :config
  (auto-compile-on-load-mode 1)
  (auto-compile-on-save-mode 1)
  (setq auto-compile-display-buffer nil)
  (setq auto-compile-mode-line-counter t))

(use-package f :ensure t)

(org-babel-load-file (at-config-basedir "config.org"))
