;;; rc-helm.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(require 'helm-config)
(require 'helm-gtags)
(require 'helm-files)
(require 'helm-info)
(require 'helm-locate)
(require 'helm-misc)

(helm-mode 1)

(setq enable-recursive-minibuffers t)

(setq helm-gtags-ignore-case t)
(setq helm-gtags-read-only t)
(setq helm-gtags-auto-update t)

(add-hook 'php-mode-hook 'helm-gtags-mode)
;; (add-hook 'helm-gtags-mode-hook
;;           '(lambda ()
;;               (local-set-key (kbd "M-t") 'helm-gtags-find-tag)
;;               (local-set-key (kbd "M-r") 'helm-gtags-find-rtag)
;;               (local-set-key (kbd "M-s") 'helm-gtags-find-symbol)
;;               (local-set-key (kbd "M-g M-p") 'helm-gtags-parse-file)
;;               (local-set-key (kbd "C-t") 'helm-gtags-pop-stack)))

(defun custom-helm ()
  (interactive)
  (helm-other-buffer '(
                       helm-c-source-buffer-not-found
                       helm-c-source-buffers-list
                       helm-source-bookmarks
                       helm-source-bookmark-set
                       helm-source-jabber-contacts
                       helm-c-source-files-in-current-dir
                       helm-c-source-recentf
                       helm-source-file-name-history
                       helm-source-minibuffer-history
                       helm-source-occur
                       helm-source-locate
                       )
                     "*helm-custom*"))

(global-set-key (kbd "C-&") 'custom-helm)

(provide 'rc-helm)

(require 'iy-dep)
(require 'iy-eproject)

(eval-when-compile (require 'cl))

(custom-set-variables
 '(helm-command-prefix-key "M-S")
 '(helm-c-adaptive-history-file (concat iy-data-dir "helm-c-adaptive-history")))


;;; Libraries
(push 'helm el-get-packages)

(defun iy-el-get-after-helm ()
  (require 'helm-mode)
  (require 'helm-match-plugin)
  (require 'helm-buffers)
  (require 'helm-files)
  (require 'helm-locate)
  (require 'helm-w3m)

  (defvar helm-c-source-eproject-projects nil)
  (defvar helm-c-source-eproject-files-in-project nil)

  (setq helm-c-source-eproject-projects
    '((name . "Projects")
      (candidates . (lambda ()
                      (mapcar 'cdr (eproject-projects))))
      (real-to-display . (lambda (e)
                           (file-name-nondirectory (directory-file-name e))))
      (type . file)))

  (setq helm-c-source-eproject-files-in-project
     '((name . "Project Files")
       ;; (delayed)
       (candidate-number-limit . 9999)
       (requires-pattern . 3)
       (real-to-display . (lambda (e)
                            (with-helm-current-buffer
                               (file-relative-name e (eproject-root-safe)))))
       (candidates . (lambda ()
                       (with-helm-current-buffer
                         (iy-eproject-list-project-files-with-cache eproject-root))))
       (type . file)))

  (defun helm-c-eproject-projects ()
    (interactive)
    (helm-other-buffer 'helm-c-source-eproject-projects "*helm projects*"))

  (defun helm-c-eproject-files-in-project ()
    (interactive)
    (helm-other-buffer 'helm-c-source-eproject-files-in-project "*helm files in project*"))


  ;;; Sources
  (defvar iy-helm-sources nil)
  (setq iy-helm-sources
        '(helm-c-source-ffap-line
          helm-c-source-ffap-guesser
          helm-c-source-buffers-list
          helm-c-source-files-in-current-dir
          helm-c-source-eproject-files-in-project
          helm-c-source-eproject-projects
          helm-c-source-file-cache
          helm-c-source-recentf
          helm-c-source-file-name-history
          helm-c-source-bookmarks
          helm-c-source-w3m-bookmarks))

  (setq helm-enable-shortcuts 'prefix)
  (define-key helm-map (kbd "M-s") 'helm-select-with-prefix-shortcut)

  (define-key helm-command-map (kbd "g") 'helm-do-grep)
  (define-key helm-command-map (kbd "o") 'helm-occur)
  (define-key helm-command-map (kbd "r") 'helm-register)
  (define-key helm-command-map (kbd "R") 'helm-regexp)
  (define-key helm-command-map (kbd "b") 'helm-c-pp-bookmarks)
  (define-key helm-command-map (kbd "p") 'helm-c-eproject-projects)
  (define-key helm-command-map (kbd "f") 'helm-c-eproject-files-in-project)
  (define-key helm-command-map (kbd "<SPC>") 'helm-all-mark-rings)

  (fset 'helm-command-prefix helm-command-map)
  (setq helm-command-prefix helm-command-map))

(autoload 'helm-command-prefix "helm-config" nil nil 'keymap)

(defun iy-helm-go ()
  "Preconfigured `helm' to fidn fiels"
  (interactive)
  (helm-other-buffer iy-helm-sources "*helm go*"))

;;; Shortcuts
(global-set-key (kbd "M-X") 'iy-helm-go)
(define-key iy-map (kbd "M-s") 'iy-helm-go)
(define-key iy-map (kbd "s") 'helm-command-prefix)

;; Customization
(setq helm-input-idle-delay 0)
(setq helm-idle-delay 0.3)
(setq helm-quick-update t)
(setq helm-c-use-standard-keys t)
(setq helm-quick-update nil)

;;; Bindings
(defun helm-insert-buffer-base-name ()
  "Insert buffer name stub."
  (interactive)
  (helm-insert-string
   (with-current-buffer helm-current-buffer
     (buffer-stub-name))))

;; 1. Quote the string
;; 2. If we didn't input any typically regexp characters, convert spaces to .*,
;; however, it is still order related.
(defun helm-pattern-to-regexp (string)
  (prin1-to-string
   (if (string-match-p "[][*+$^]" string) string
     (let ((parts (split-string string "[ \t]+" t)))
       (if (eq 2 (length parts))
           ;; for two parts a,b we make a.*b\|b.*a
           (concat
            (mapconcat 'regexp-quote parts ".*")
            "\\|"
            (mapconcat 'regexp-quote (reverse parts) ".*"))
         ;; only 1 part or more than 2 parts, fine, just combine them using .*,
         ;; thus it will slow down locate a lot. This means you have to type in order
         (mapconcat 'regexp-quote parts ".*"))))))

;; Hack
;; Convert helm pattern to regexp for locate
(defadvice helm-c-locate-init (around helm-pattern-to-regexp () activate)
  (let ((helm-pattern (helm-pattern-to-regexp helm-pattern)))
    ad-do-it))

(provide 'iy-helm)

;;; rc-helm.el ends here
