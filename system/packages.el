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
        bitlbee
        bookmark+
        c-eldoc
        calfw
        column-marker
        crontab-mode
        css-eldoc
        csv-mode
        deft
        diminish
        dired+
        dired-sort-menu
        dired-toggle-sudo
        discover
        drag-stuff
        dtrt-indent
        el-spice
        eldoc-eval
        elisp-slime-nav
        emmet-mode
        epoch-view
        erefactor
        expand-region
        fic-mode
        flycheck
        flycheck-color-mode-line
        framemove
        ggtags
        git-gutter
        git-timemachine
        google-contacts
        google-translate
        haskell-mode
        helm-ag
        helm-c-yasnippet
        helm-descbinds
        helm-flycheck
        helm-gtags
        helm-projectile
        help+
        hide-comnt
        hydra
        irony
        jedi
        js2-mode
        js2-refactor
        json-mode
        keyfreq
        latex-preview-pane
        list-processes+
        lua-mode
        magit
        markdown-mode
        multifiles
        multiple-cursors
        names
        nginx-mode
        notify
        oauth2
        openwith
        org-gcal
        org-magit
        org-pomodoro
        org-toodledo
        orglink
        paredit
        paredit-everywhere
        pdf-tools
        phi-search
        popwin
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
        swoop
        tern
        twittering-mode
        undo-tree
        unicode-fonts
        use-package
        vimrc-mode
        vline
        volatile-highlights
        wc-mode
        web
        web-mode
        wgrep
        whole-line-or-region
        wrap-region
        yaml-mode
        zoom-window
        jabber
        ))

(mapcar
 (lambda (package)
   (unless (package-installed-p package)
     (package-install package))) package-el-packages)

(setq el-get-packages
      '(
        ac-irony
        auto-complete-emacs-lisp
        auto-complete-extension
        auto-complete-latex
        auto-complete-yasnippet
        breadcrumb-custom
        color-theme-zenburn
        coverlay
        doxymacs
        emacs-w3m
        erc-extras
        erc-highlight-nicknames
        file-template
        git-emacs
        helm-recentd
        helm-slime
        hs-lint
        hungry-delete-el
        init-paredit
        joseph-file-util
        js2-highlight-vars
        mingus
        minibuf-electric-gnuemacs
        org-mode
        org-occur-goto
        po-mode
        pylookup
        revbufs
        rst-mode
        swank-js
        tail
        w3m-session
        w3m-type-ahead
        ))

(provide 'packages)

;;; sources-common.el ends here
