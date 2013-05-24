;; -*- coding: utf-8 -*-
;;
;; Filename: sources-disabled.el
;; Created: Чт май  2 11:49:35 2013 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq el-get-sources-diasbled
      '(
        auctex
        distel
        emacs-jabber
        ess
        haskell-mode
        todochiku
        cmake-mode
        ecb
        mmm-mode
        psvn
        pymacs
        python
        python-mode
        quack
        (:name haskell-mode-exts
               :type git
               :url "http://github.com/pheaver/haskell-mode-exts.git"
               :load-path (".")
               :features (
                          haskell-align-imports
                          haskell-installed-packages
                          haskell-navigate-imports
                          haskell-sort-imports
                          inf-haskell-send-cmd))
        (:name po-mode+ :type emacswiki :load "po-mode+.el")
        (:name anything-extension :type emacswiki)
        (:name anything-match-plugin :type emacswiki)
        (:name icicles-iswitchb :type emacswiki)
        (:name iswitchb-highlight :type emacswiki)
        (:name anything-grep :type emacswiki)
        (:name lacarte :type emacswiki)
        (:name workspaces :type emacswiki :load "workspaces.el")
        (:name vlf :type emacswiki :load "vlf.el")
        (:name change-windows-intuitively
               :type http
               :url "http://quimby.gnus.org/s/change-windows-intuitively.el"
               :load "change-windows-intuitively.el")
        (:name hexview-mode
               :type http
               :url "http://emacswiki.org/emacs/download/hexview-mode.el"
               :load "hexview-mode.el")
        (:name electric-dot-and-dash :type emacswiki :load "electric-dot-and-dash.el")
        (:name devel-notes :type emacswiki :load "devel-notes.el")
        (:name framemove :type emacswiki :load "framemove.el")
        (:name loccur
               :type git
               :url "https://github.com/fourier/loccur.git"
               :load "loccur.el")
        ))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; sources-disabled.el ends here
