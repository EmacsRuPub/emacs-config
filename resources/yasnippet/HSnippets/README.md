
HSnippets :: Emacs YASnippet snippets for Haskell
=================================================

[YASnippet](http://code.google.com/p/yasnippet/) is a template system for 
Emacs. It allows you to type an abbreviation and automatically expand
it into function templates.

HSnippets is designed for use with haskell-indentation-mode, i.e. it does
not do any indentation itself, but relies on the mode (or the user) to do so.
Also note that the snippets never add any unnecessary lines to the code
listing, only the lines taken up by the snippet itself, leaving the user
to manage empty space themselves.

As a convenience, fields are `undefined` where possible/meaningful, so that you can
skip fields, compile the code to type check it, and come back and fill them
in later. Where types are expected, `T` is often the default. When I'm working
I like to put `data T = T deriving (Show)` at the top of the file, so that I
can skip some of those and fill them in later as well.

I highly recommend you do something like the following in your emacs file

    (require 'yasnippet)
    (setq yas/trigger-key "<C-tab>") ;; make sure this is before yas/initialize
    (yas/initialize)
    (yas/load-directory (concat site-lisp "snippets"))
    
Having the trigger-key as C-tab works out much better, because then the tab
key will only be used for both haskell indentation, and cycling through yas fields,
but not to trigger expansions. For example, if your point were at # below,
hitting tab would re-indent (as desired) instead of expanding the 'where' snippet.

    foo :: Foo -> Foo
    foo x = bar x y
    where#
    
The Snippets 
------------

-   **name [^note] : 'key'**
-   case   : 'case'
-   class  : 'class'
-   comprehension : '|'
-   data : 'data'
-   data_braced : 'datab'
-   data_family : 'dataf'
-   data_instance : 'datai'
-   definition ^1 : '='
-   definition_guarded ^1 : '|='
-   deriving : 'dv'
-   deriving_all : 'dva'
-   gadt : 'gadt'
-   hiding : 'hd'
-   if : 'if'
-   import : 'imp'
-   import_qualified : 'impq'
-   instance : 'inst'
-   lambda ^2 : '\\'
-   let : 'let'
-   main : 'main'
-   module : 'mod'
-   newtype : 'new'
-   newtype_braced : 'newb'
-   pragma : 'prag'
-   pragma_language : 'lang'
-   separator : 'sep'
-   tuple : ','
-   triple : ',,'
-   type : 'type'
-   undefined : 'un'
-   where ^1 : 'where'
-   xxs : 'xxs'

Notes
-----

Some things I couldn't get working. Any help/tips appreciated.

1. I could only get the definition snippets to indent properly at the top level by breaking indentation if nested, and vice versa, so i chose to break them if nested. Use the where snippet if you want a nested definition with a type declaration.

2. For some reason the lambda snippet does not work on my system if the key is the first character on the line. Since this should never happen in normal code, it shouldn't matter. Just a heads up.
