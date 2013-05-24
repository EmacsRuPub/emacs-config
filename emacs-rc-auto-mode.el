;;; emacs-rc-auto-mode.el ---

;; Copyright (C) Ronin
;;
;; Author: Ronin <aaermolov@gmail.com>
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(add-to-list 'auto-mode-alist '("\\.ipp?$" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.h$" . c++-mode))
;; (add-to-list 'auto-mode-alist '("/usr/include/qt4" . c++-mode))
(add-to-list 'auto-mode-alist '("/usr/include/qt4/Qt" . c++-mode))
(add-to-list 'auto-mode-alist '("/usr/include/qt4/QtNetwork" . c++-mode))
(add-to-list 'auto-mode-alist '("/usr/include/boost" . c++-mode))
(add-to-list 'auto-mode-alist '("/usr/include/c++/4.3" . c++-mode))

(add-to-list 'auto-mode-alist '("CMakeLists\\.txt\\'" . cmake-mode))
(add-to-list 'auto-mode-alist '("\\.cmake\\'" . cmake-mode))

(add-to-list 'auto-mode-alist '("\\.dsl$" . scheme-mode))
(add-to-list 'auto-mode-alist '("\\.scm$" . scheme-mode))

;; ;; JavaScript
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . json-mode))

(add-to-list 'auto-mode-alist
             (cons (concat "\\."
                           (regexp-opt '("xml" "xsd" "sch" "rng" "xslt" "svg" "rss" "rdf") t) "\\'")
                   'nxml-mode))

(add-to-list 'auto-mode-alist '("\\.html$" . django-html-mumamo-mode))

;; HTML
;; (add-to-list 'auto-mode-alist '("\\.html\\'" . html-mode))
(add-to-list 'auto-mode-alist '("\\.tag$" . html-mode))
(add-to-list 'auto-mode-alist '("\\.vm$" . html-mode)) 

(add-to-list 'auto-mode-alist '("\\.wl$" . emacs-lisp-mode))

(add-to-list 'auto-mode-alist '("\\.muse$" . muse-mode))
(add-to-list 'auto-mode-alist '("\\.tex$" . latex-mode))
(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\|/TODO\\)$" . org-mode))
(add-to-list 'auto-mode-alist '("\\.tagged\\'" . tagger-mode))

(add-to-list 'auto-mode-alist '("\\.spec$" . rpm-spec-mode))
(add-to-list 'auto-mode-alist '("\\.po$\\|\\.po\\." . po-mode))
(add-to-list 'auto-mode-alist '("\\.log$" . auto-revert-mode))

(add-to-list 'auto-mode-alist '("\\.doku?$" . simple-dokuwiki-mode))
(add-to-list 'auto-mode-alist '("\\.properties$" . java-properties-generic-mode))

(add-to-list 'auto-mode-alist '("\\.erl?$" . erlang-mode))
(add-to-list 'auto-mode-alist '("\\.hrl?$" . erlang-mode))

(add-to-list 'auto-mode-alist '("\\.hsc$" . haskell-mode))

(add-to-list 'auto-mode-alist '("\\.el" . emacs-lisp-mode))
(add-to-list 'auto-mode-alist '("\\.emacs$" . emacs-lisp-mode))
(add-to-list 'auto-mode-alist '("\\.gnus$" . emacs-lisp-mode))

(add-to-list 'auto-mode-alist '("\\.rst$" . rst-mode))
(add-to-list 'auto-mode-alist '("\\.rest$" . rst-mode))

;; CSS
(add-to-list 'auto-mode-alist '("\\.scss$" . css-mode))

;; Clojure
(autoload 'clojure-mode "clojure-mode")
(add-to-list 'auto-mode-alist '("\\.clj$" . clojure-mode))

;; SVG
(add-to-list 'auto-mode-alist '("\\.svg$" . image-mode))

;; Snippets
(add-to-list 'auto-mode-alist '("yasnippet/snippets" . snippet-mode))
(add-to-list 'auto-mode-alist '("\\.yasnippet$" . snippet-mode))

;; Markdown
(add-to-list 'auto-mode-alist '("\\.markdown$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.mkd$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.pdc$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\bREADME$" . markdown-mode))

;; Highlighting in editmsg-buffer for magit
(add-to-list 'auto-mode-alist '("COMMIT_EDITMSG" . conf-javaprop-mode))

(push '("<\\?xml" . nxml-mode) magic-mode-alist)

;; (add-to-list 'auto-mode-alist '("\\.plg$" . prolog-mode))

(add-to-list 'auto-mode-alist '("bashrc$" . sh-mode))
(add-to-list 'auto-mode-alist '("bash_profile$" . sh-mode))
(add-to-list 'auto-mode-alist '("bash_aliases$" . sh-mode))
(add-to-list 'auto-mode-alist '("bash_local$" . sh-mode))
(add-to-list 'auto-mode-alist '("bash_completion$" . sh-mode))
(add-to-list 'auto-mode-alist '(".powenv$" . sh-mode))

;; Use gdb-script-mode for files ending in .gdb
(setq auto-mode-alist
      (cons '("\\.gdb$" . gdb-script-mode) auto-mode-alist))

(add-to-list 'auto-mode-alist '("\\.php" . php-mode))

(add-to-list 'auto-mode-alist '("\\.stumpwmrc\\'" . lisp-mode))

;;; emacs-rc-auto-mode.el ends here
