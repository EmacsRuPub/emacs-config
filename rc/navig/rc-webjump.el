;;; rc-webjump.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(require 'webjump)

(global-set-key (kbd "C-x w") 'webjump)

(setq webjump-sites
      (append '(
                ("Reddit Search" .
                 [simple-query "www.reddit.com" "http://www.reddit.com/search?q=" ""])
                ("Google Image Search" .
                 [simple-query "images.google.com" "images.google.com/images?hl=en&q=" ""])
                ("Flickr Search" .
                 [simple-query "www.flickr.com" "flickr.com/search/?q=" ""])
                )
              webjump-sample-sites))

;;; rc-webjump.el ends here
