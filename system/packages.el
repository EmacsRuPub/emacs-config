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
        backup-walker
        bbdb
        bookmark+
        c-eldoc
        calfw
        comment-dwim-2
        common-lisp-snippets
        crontab-mode
        crosshairs
        css-eldoc
        csv-mode
        deep-thought-theme
        diminish
        dired+
        dired-sort-menu
        dired-toggle-sudo
        discover-my-major
        drag-stuff
        dtrt-indent
        edebug-x
        el-spice
        eldoc-eval
        elisp-slime-nav
        emmet-mode
        epoch-view
        erc-hl-nicks
        ercn
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
        highlight-sexp
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
        mark
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
        phi-search-mc
        projectile
        python
        python-pep8
        rainbow-mode
        rebox2
        recentf-ext
        recursive-narrow
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
        snakehump
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
        wgrep-helm
        whole-line-or-region
        windsize
        wrap-region
        yaml-mode
        zenburn-theme
        zoom-window
        ))

(setq package-el-packages-staging
      '(
        calfw-gcal
        esup
        eww-lnum
        gitignore-mode
        grep-a-lot
        memory-usage
        nose
        nose-mode
        pep8
        py-autopep8
        py-import-check
        runner
        rust-mode
        searchq
        shift-text
        slime-annot
        spinner
        tern-auto-complete
        unbound
        wand
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
