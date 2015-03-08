Org-Mode (with Beamer) Hello World
-------------------------------------------

I started off very simply by downloading the (current) stable version of
org-mode [here](http://orgmode.org/org-8.2.10.tar.gz). I happen to keep my
emacs-related packages in a `~/elisp` directory, so I added the following line
to my `.emacs` file, which tells emacs to add org to it's startup path and to
require both the Latex and Beamer of the Org Exporter (ox). Technically, you
only need the Beamer require if you're working with both (since it `require`\s
`ox-latex` in `ox-beamer.el`).

```
(add-to-list 'load-path "~/etc/org-8.2.10/lisp")
(require 'ox-latex)
(require 'ox-beamer)
```

With that, you can add the following text to a file, say `pres.org`

```
#+TITLE:     A Presentation
#+AUTHOR:    Matthew J. Gidden
#+EMAIL:     matthew.gidden@gmail.com
#+DATE:      2015-03-26
#+DESCRIPTION: 
#+KEYWORDS: 
#+LANGUAGE:  en
#+OPTIONS:   H:2 num:t toc:t \n:nil @:t ::t |:t ^:t -:t f:t *:t <:t
#+OPTIONS:   TeX:t LaTeX:t skip:nil d:nil todo:t pri:nil tags:not-in-toc
#+INFOJS_OPT: view:nil toc:nil ltoc:t mouse:underline buttons:0 path:http://orgmode.org/org-info.js
#+EXPORT_SELECT_TAGS: export
#+EXPORT_EXCLUDE_TAGS: noexport
#+LINK_UP:   
#+LINK_HOME:

#+LaTeX_CLASS: beamer
#+LaTeX_CLASS_OPTIONS: [presentation,smaller]
#+BEAMER_THEME: default

* Introduction

** Overview
   This presentation provides an illustration of some of the capabilities of the *Beamer* export in =org= mode:

   1. simple slides (this one),
   2. slides with special blocks,
   3. multi-column slides and
   4. the use of *Babel* for literate programming.

** Another slide

   Just a test
```

Then, while in emacs, press `C-c C-e l P`, and you'll get two files
automatically generated for you: `pres.tex` and `pres.pdf`. The key strokes in
that command are very important! For example make sure *not* to use a lower-case
`p` rather than the upper-case `P`. Using a lower case will get still get you a
PDF but without having passed it through the Beamer translator.

