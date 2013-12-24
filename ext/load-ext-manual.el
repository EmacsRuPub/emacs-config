(setq ext-dirs
      (quote
       ("ext/emacs-jabber"
        "ext/git-contrib/emacs"
        ;; "ext/ghc-mod"
        "ext/mingus"
        )))

(setq ext-files
      (quote
       ("ext/python/python-pylint.el"
        "ext/smerge-mode.el"
        "ext/gmail-notifier.el"
        "ext/mingus/mingus-stays-home.el"
        )))

(mapcar (lambda (ext-dir) (add-to-list 'load-path (concat config-basedir ext-dir))) ext-dirs)
(mapcar (lambda (ext-file) (load (concat config-basedir ext-file))) ext-files)
