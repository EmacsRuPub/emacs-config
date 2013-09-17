(setq ext-dirs
      (quote
       ("ext/ecb"
        "ext/crosshairs"
        "ext/emacs-jabber"
        "ext/emacs-nav"
        "ext/git-contrib/emacs"
        "ext/php"
        "ext/slime"
        "ext/slime/contrib"
        "ext/twittering-mode"
        ;; "ext/ghc-mod"
        )))

(setq ext-files
      (quote
       ("ext/rainbow-mode.el"
        "ext/php/php-mode/php-mode.el"
        "ext/php/php-electric.el" ;; AFTER php-mode !!!
        "ext/python/python-pep8.el"
        "ext/python/python-pylint.el"
        "ext/rst.el" ; nonwiki
        "ext/smerge-mode.el"
        "ext/tomorrow-themes-emacs/color-theme-tomorrow.el"
        "ext/golang/go-mode.el"
        )))

(mapcar (lambda (ext-dir) (add-to-list 'load-path (concat config-basedir ext-dir))) ext-dirs)
(mapcar (lambda (ext-file) (load (concat config-basedir ext-file))) ext-files)

;; (add-to-list 'load-path (concat config-basedir "ext/frame-tag.el"))
;; (add-to-list 'load-path (concat config-basedir "ext/python/pymacs"))
;; (load (concat config-basedir "ext/dired+.el"))
;; (load (concat config-basedir "ext/multi-term.el"))
