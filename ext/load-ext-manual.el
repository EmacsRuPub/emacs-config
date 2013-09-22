(setq ext-dirs
      (quote
       ("ext/emacs-jabber"
        "ext/git-contrib/emacs"
        ;; "ext/ghc-mod"
        )))

(setq ext-files
      (quote
       ("ext/php/php-mode/php-mode.el"
        "ext/php/php-electric.el" ;; AFTER php-mode !!!
        "ext/python/python-pylint.el"
        "ext/smerge-mode.el"
        )))

(mapcar (lambda (ext-dir) (add-to-list 'load-path (concat config-basedir ext-dir))) ext-dirs)
(mapcar (lambda (ext-file) (load (concat config-basedir ext-file))) ext-files)
