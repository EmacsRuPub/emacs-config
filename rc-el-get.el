;;; rc-el-get.el --- 

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords: 
;; Requirements: 
;; Status: not intended to be distributed yet

;; TODO: 
;; color-theme - check why it fails to download
;; elib - should be installed by package manager by now
;; haskell-mode haskell-mode-exts - check why it fails to download
;; anything anything-config - version and extension conflicts
;; whizzytex - find the source
;; nxml - make recipe (draft below)
;; (:name nxml-mode
;;        :type http-tar
;;        :options ("xzf")
;;        :url "http://www.thaiopensource.com/download/nxml-mode-20041004.tar.gz"
;;        :load "nxml-mode.el"
;;        :load-path ("./lisp")
;;        :post-init (lambda () (nil)))

(add-to-list 'load-path "/mnt/work/projects/oss/el-get/")
(require 'el-get)
(setq el-get-recipe-path '("/mnt/work/projects/oss/el-get/recipes/"))
(setq el-get-sources '(ahg anything auctex bbdb bookmark+ cmake-mode
													 color-theme-mac-classic
													 color-theme-sanityinc
													 color-theme-tango-2
													 color-theme-zenburn dired+ distel doxymacs
													 dvc egg emacs-jabber emacs-w3m ess
													 fit-frame git-emacs google-weather hs-lint
													 js2-mode mo-git-blame org-mode po-mode psvn
													 quack shime slime sunrise-commander
													 sunrise-x-buttons sunrise-x-checkpoints
													 sunrise-x-loop sunrise-x-mirror
													 sunrise-x-modeline sunrise-x-popviewer
													 sunrise-x-tabs sunrise-x-tree tail
													 undo-tree wrap-region yasnippet
													 (:name autosmiley :type emacswiki)
													 (:name c-eldoc :type emacswiki)
													 (:name cdlatex 
																	:type http
																	:url
																	"http://staff.science.uva.nl/~dominik/Tools/cdlatex/cdlatex.el"
																	:load "cdlatex.el")
													 (:name dired-sort-menu :type
																	emacswiki)
													 (:name egit
																	:type git
																	:url "git://github.com/jimhourihan/egit.git"
																	:load "egit.el")
													 (:name full-ack 
																	:type http
																	:url
																	"http://nschum.de/src/emacs/full-ack/full-ack.el"
																	:load "full-ack.el")
													 (:name gitsum
																	:type git
																	:url "git://github.com/chneukirchen/gitsum.git"
																	:load "gitsum.el")
													 (:name highlight-symbol
																	:type http
																	:url
																	"http://nschum.de/src/emacs/highlight-symbol/highlight-symbol.el"
																	:load "highlight-symbol.el")
													 (:name icicles
																	:type git
																	:url "https://github.com/emacsmirror/icicles.git"
																	:load-path ("."))
													 (:name icicles-iswitchb :type emacswiki)
													 (:name iswitchb-highlight :type
																	emacswiki)
													 (:name lacarte :type emacswiki)
													 (:name sunrise-x-old-checkpoints :type
																	emacswiki)
													 (:name window-number :type emacswiki)
													 (:name color-theme-darkmate 
																	:type http
																	:url
																	"http://myvimemacs.googlecode.com/svn-history/r2/trunk/emacs/.emacs.d/site-lisp/color-theme-darkmate.el")
													 ))
(el-get)

;;; rc-el-get.el ends here

