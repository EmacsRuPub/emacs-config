;;; sources-custom.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(setq el-get-sources-custom
      '(
        (:name yasnippet
               :type git
               :url "https://github.com/capitaomorte/yasnippet.git"
               :load-path ("."))
        ;; (:name cdlatex
        ;;        :type http
        ;;        :url "http://staff.science.uva.nl/~dominik/Tools/cdlatex/cdlatex.el"
        ;;        :load "cdlatex.el")
        (:name color-theme-sanityinc-solarized
               :type git
               :url "git://github.com/purcell/color-theme-sanityinc-solarized.git"
               :load "color-theme-sanityinc-solarized.el")
        (:name emacs-calfw
               :type git
               :url "https://github.com/kiwanami/emacs-calfw.git"
               :load-path ("."))
        (:name drag-stuff
               :type http
               :url "https://github.com/rejeep/drag-stuff/raw/master/drag-stuff.el")
        (:name egg
               :type git
               :url "https://github.com/byplayer/egg.git"
               :load-path ("."))
        ;; (:name egit
        ;;        :type git
        ;;        :url "git://github.com/jimhourihan/egit.git"
        ;;        :load "egit.el")
        ;; (:name emacs-juick-el
        ;;        :type git
        ;;        :url "git://github.com/mad/emacs-juick-el.git"
        ;;        :load "juick.el")
        (:name full-ack
               :type http
               :url "http://nschum.de/src/emacs/full-ack/full-ack.el"
               :load "full-ack.el")
        (:name gitsum
               :type git
               :url "git://github.com/chneukirchen/gitsum.git"
               :load "gitsum.el")
        (:name highlight-symbol
               :type http
               :url "http://nschum.de/src/emacs/highlight-symbol/highlight-symbol.el"
               :load "highlight-symbol.el")
        (:name haskell-mode
               :type git
               :url "https://github.com/pheaver/haskell-mode"
               :load "haskell-site-file.el")
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
        ;; (:name icicles
        ;;        :type git
        ;;        :url "https://github.com/emacsmirror/icicles.git"
        ;;        :load-path ("."))
        (:name emacs-psto-el
               :type git
               :url "git://github.com/wiedzmin/emacs-psto-el.git"
               :load-path ("."))
        (:name color-theme-darkmate
               :type http
               :url "http://myvimemacs.googlecode.com/svn-history/r2/trunk/emacs/.emacs.d/site-lisp/color-theme-darkmate.el")
        (:name multiple-cursors
               :type git
               :url "https://github.com/magnars/multiple-cursors.el.git"
               :load-path ("."))
        (:name sauron
               :type git
               :url "https://github.com/djcb/sauron.git"
               :load-path ("."))
        (:name expand-region
               :type git
               :url "https://github.com/magnars/expand-region.el.git"
               :load-path ("."))
        (:name himark
               :type http
               :url "http://www.emacswiki.org/emacs/download/himark.el"
               :load "himark.el")
        (:name camelcase-mode
               :type http
               :url "http://lilypond.org/blog/jan/software/ooo/camelCase-mode.el"
               :load "camelCase-mode.el")
        (:name csv-mode
               :type http
               :url "http://www.emacswiki.org/emacs/download/csv-mode.el"
               :load "csv-mode.el")
        (:name fill-column-indicator
               :type http
               :url "http://www.emacswiki.org/emacs/download/fill-column-indicator.el"
               :load "fill-column-indicator.el")
        (:name hexview-mode
               :type http
               :url "http://emacswiki.org/emacs/download/hexview-mode.el"
               :load "hexview-mode.el")
        (:name org-occur-goto
               :type http
               :url "http://www.emacswiki.org/emacs/download/org-occur-goto.el"
               :load "org-occur-goto.el")
        (:name paredit
               :type http
               :url "http://mumble.net/~campbell/emacs/paredit.el"
               :load "paredit.el")
        (:name parenface
               :type http
               :url "http://www.davep.org/emacs/parenface.el"
               :load "parenface.el")
        (:name pdftools
               :type http
               :url "http://www.emacswiki.org/emacs-en/download/pdftools.el"
               :load "pdftools.el")
        (:name savekill
               :type http
               :url "http://www.emacswiki.org/emacs/download/savekill.el"
               :load "savekill.el")
        (:name silentcomp
               :type http
               :url "http://larch.cs.iastate.edu/emacs/ecb/silentcomp.el"
               :load "silentcomp.el")
        (:name emacs-minimap
               :type git
               :url "https://github.com/dustinlacewell/emacs-minimap.git"
               :load "minimap.el")
        (:name command-log-mode
               :type git
               :url "https://github.com/lewang/command-log-mode.git"
               :load "command-log-mode.el")
        (:name zenburn-el
               :type git
               :url "https://github.com/dbrock/zenburn-el.git"
               :load "zenburn.el")
        (:name change-windows-intuitively
               :type http
               :url "http://quimby.gnus.org/s/change-windows-intuitively.el"
               :load "change-windows-intuitively.el")
        (:name point-stack
               :type git
               :url "https://github.com/mattharrison/point-stack.git"
               :load "point-stack.el")
        ;; (:name helm-slime
        ;;        :type git
        ;;        :url "https://github.com/emacs-helm/helm-slime.git"
        ;;        :load "helm-slime.el")
        (:name rebox2
               :type git
               :url "https://github.com/lewang/rebox2.git"
               :load "rebox2.el")
        (:name zencoding
               :type git
               :url "https://github.com/rooney/zencoding.git"
               :load-path ("."))
        (:name workgroups-el
               :type git
               :url "https://github.com/tlh/workgroups.el.git"
               :load-path ("."))
        (:name helm
               :type git
               :url "https://github.com/emacs-helm/helm.git"
               :load-path ("."))
))

;;; sources-custom.el ends here
