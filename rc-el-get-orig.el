;;; rc-el-get.el --- 

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords: 
;; Requirements: 
;; Status: not intended to be distributed yet

;; TODO: 
;; anything-config - version and extension conflicts
;; erc-extras - broken
;; nxml - make recipe (draft below)
;; (:name nxml-mode
;;        :type http-tar
;;        :options ("xzf")
;;        :url "http://www.thaiopensource.com/download/nxml-mode-20041004.tar.gz"
;;        :load "nxml-mode.el"
;;        :load-path ("./lisp")
;;        :post-init (lambda () (nil)))
;; C. Packages are unsafe to install batched
;; must be installed after A batch,
;; preferably one line at a time
;; bookmark+
;; D. Trial packages
;; (:name ghc-mod
;; 			 :type git
;; 			 :url "git://github.com/kazu-yamamoto/ghc-mod.git"
;; 			 :load-path ("./elisp"))
;; dvc
(add-to-list 'load-path "/Users/octocat/projects/github/other/el-get.my/")
(require 'el-get)

(setq el-get-recipe-path
	'("/Users/octocat/projects/github/other/el-get.my/recipes/"))

(setq el-get-sources-common '(
	ahg 
	anything 
	cmake-mode 
	color-theme
	dired+ 
	erc-highlight-nicknames
	git-emacs 
	google-weather 
	highlight-symbol
	hs-lint 
	iedit 
	ioccur 
	js2-mode 
	mo-git-blame
	po-mode 
	psvn 
	quack 
	tail 
	undo-tree
	wrap-region 
))

(setq el-get-sources-custom '(
	(:name yasnippet
		:type git
		:url "https://github.com/capitaomorte/yasnippet.git"
		:load-path ("."))
	(:name anything-extension :type emacswiki)
	(:name anything-match-plugin :type emacswiki)
	(:name autosmiley :type emacswiki)
	(:name c-eldoc :type emacswiki)
	(:name cdlatex 
		:type http
		:url "http://staff.science.uva.nl/~dominik/Tools/cdlatex/cdlatex.el"
		:load "cdlatex.el")
	(:name color-theme-sanityinc-solarized
		:type git
		:url "git://github.com/purcell/color-theme-sanityinc-solarized.git"
		:load "color-theme-sanityinc-solarized.el")
	(:name emacs-calfw
		:type git
		:url "https://github.com/kiwanami/emacs-calfw.git"
		:load-path ("."))
	(:name dired-sort-menu :type
		emacswiki)
	(:name drag-stuff
		:type http
		:url "https://github.com/rejeep/drag-stuff/raw/master/drag-stuff.el")
	(:name egg
		:type git
		:url "https://github.com/byplayer/egg.git"
		:load-path ("."))
	(:name egit
		:type git
		:url "git://github.com/jimhourihan/egit.git"
		:load "egit.el")
	(:name emacs-juick-el
		:type git
		:url "git://github.com/mad/emacs-juick-el.git"
		:load "juick.el")
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
	;; for test - failed
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
	(:name icicles
		:type git
		:url "https://github.com/emacsmirror/icicles.git"
		:load-path ("."))
	(:name icicles-iswitchb :type emacswiki)
		(:name iswitchb-highlight :type emacswiki)
	(:name lacarte :type emacswiki)
	(:name emacs-psto-el
		:type git
		:url "git://github.com/wiedzmin/emacs-psto-el.git"
		:load-path ("."))
	(:name iproject :type emacswiki)
	(:name project-buffer-mode :type emacswiki)
	(:name project-buffer-mode+ :type emacswiki)
	(:name project-buffer-occur :type emacswiki)
	(:name window-number :type emacswiki)
	(:name color-theme-darkmate 
		:type http
		:url "http://myvimemacs.googlecode.com/svn-history/r2/trunk/emacs/.emacs.d/site-lisp/color-theme-darkmate.el")
))

(load el-get-sources-system-file)

(setq el-get-sources 
	(append 
		el-get-sources-common
		el-get-sources-custom
		el-get-sources-system))

(el-get)

;;; rc-el-get.el ends here

