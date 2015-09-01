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
        auto-complete-clang
        auto-yasnippet
        backup-walker
        bbdb
        bookmark+
        c-eldoc
        calfw
        comment-dwim-2
        common-lisp-snippets
        counsel
        crontab-mode
        crosshairs
        css-eldoc
        csv-mode
        deep-thought-theme
        deft
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
        fuzzy
        ggtags
        git-gutter
        git-timemachine
        gitignore-mode
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
        pdf-tools
        phi-search
        phi-search-mc
        popwin
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
        rust-mode
        sauron
        savekill
        scratch
        smart-mode-line
        snakehump
        swiper
        swiper-helm
        swoop
        tern
        tern-auto-complete
        twittering-mode
        unbound
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

(mapcar
 (lambda (package)
   (unless (package-installed-p package)
     (package-install package))) package-el-packages)

(provide 'packages)

;;; sources-common.el ends here
