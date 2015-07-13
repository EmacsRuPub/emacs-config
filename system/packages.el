;;; sources-common.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(require 'package)
(add-to-list 'package-archives
       '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
       '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives
       '("elpa" . "http://tromey.com/elpa/"))
(package-initialize)

(setq package-el-packages
      '(
        ac-c-headers
        ac-clang
        ac-emmet
        ac-helm
        ac-math
        ac-slime
        ace-link
        ace-window
        actionscript-mode
        adaptive-wrap
        anchored-transpose
        auctex
        auto-yasnippet
        bbdb
        bookmark+
        c-eldoc
        calfw
        comment-dwim-2
        crontab-mode
        crosshairs
        css-eldoc
        csv-mode
        deep-thought-theme
        diminish
        dired+
        dired-sort-menu
        dired-toggle-sudo
        drag-stuff
        dtrt-indent
        el-spice
        eldoc-eval
        elisp-slime-nav
        emmet-mode
        epoch-view
        erc-hl-nicks
        erefactor
        expand-region
        fic-mode
        flycheck
        flycheck-color-mode-line
        framemove
        ggtags
        git-gutter
        git-timemachine
        google-translate
        helm-ag
        helm-c-yasnippet
        helm-descbinds
        helm-dired-recent-dirs
        helm-emmet
        helm-flycheck
        helm-gtags
        helm-helm-commands
        helm-projectile
        helm-themes
        help+
        hide-comnt
        hungry-delete
        hydra
        irony
        jabber
        jedi
        js2-mode
        js2-refactor
        json-mode
        keyfreq
        latex-preview-pane
        libmpdee
        list-processes+
        lua-mode
        magit
        magit-filenotify
        markdown-mode
        material-theme
        multifiles
        multiple-cursors
        names
        nginx-mode
        notify
        nzenburn-theme
        oauth2
        openwith
        org-bullets
        org-dashboard
        org-gcal
        org-magit
        org-pomodoro
        org-toodledo
        orgit
        orglink
        paredit
        paren-face
        pdf-tools
        phi-search
        projectile
        python
        python-pep8
        rainbow-mode
        rebox2
        recentf-ext
        regex-tool
        region-bindings-mode
        replace+
        restclient
        rich-minority
        rtags
        sauron
        savekill
        scratch
        smart-mode-line
        string-inflection
        swoop
        tern
        twittering-mode
        undo-tree
        unicode-fonts
        use-package
        vimrc-mode
        vline
        volatile-highlights
        w3m
        wc-mode
        web
        web-mode
        wgrep
        whole-line-or-region
        windsize
        wrap-region
        yaml-mode
        zenburn-theme
        zoom-window
        ))

(setq package-el-packages-staging
      '(
        ac-js2
        ac-python
        ansible
        backup-walker
        browse-url-dwim
        calfw-gcal
        common-lisp-snippets
        confluence
        dired-ranger
        discover-my-major
        edebug-x
        emacs-cl
        ercn
        esup
        eww-lnum
        git-messenger
        gitignore-mode
        grep-a-lot
        highlight-sexp
        mark
        memory-usage
        monky
        navigate
        navorski
        nose
        nose-mode
        nterm
        phi-search-mc
        pep8
        py-autopep8
        py-import-check
        pyimpsort
        rainbow-blocks
        readline-complete
        recursive-narrow
        req-package
        relative-buffers
        runner
        rust-mode
        searchq
        shift-text
        slime-annot
        snakehump
        spinner
        tern-auto-complete
        thing-cmds
        thingopt
        timesheet
        timestamper
        tj-mode
        turnip
        unbound
        vagrant
        vagrant-tramp
        wand
        wgrep-helm
        ))

(mapcar
 (lambda (package)
   (unless (package-installed-p package)
     (package-install package))) package-el-packages)

(mapcar
 (lambda (package)
   (unless (package-installed-p package)
     (package-install package))) package-el-packages-staging)

(provide 'packages)

;;; sources-common.el ends here
