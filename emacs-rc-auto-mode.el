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

(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(add-to-list 'auto-mode-alist (cons (concat "\\."
                                            (regexp-opt '("xml" "xsd" "sch" "rng" "xslt" "svg" "rss" "rdf" "html") t) "\\'")
                                    'nxml-mode))

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

;; (push '("<\\?xml" . nxml-mode) magic-mode-alist)

;; (add-to-list 'auto-mode-alist '("\\.plg$" . prolog-mode))

;;; emacs-rc-auto-mode.el ends here
