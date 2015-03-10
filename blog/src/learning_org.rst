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

Adding a Bibtex Entry
-----------------------

Getting everything to work nicely with Bibtex takes a bit of extra effort. My
goal was to add the following to my generated Latex (matching previous
presentations):

```
\begin{frame}[allowframebreaks]
  \frametitle{References}
  \bibliographystyle{plain}
  \bibliography{main}
\end{frame}
```

That part is relatively straightforward in Org-mode, just add to the bottom of
your `pres.org` the following, replacing the `\bibliography{pres}` entry with
your own bib file(s):

```
** References
  :PROPERTIES:
  :BEAMER_opt: allowframebreaks
  :END:
   \bibliographystyle{plain}
   \bibliography{pres}
```

However, this won't work out of the box. I found a related
[thread](http://lists.gnu.org/archive/html/emacs-orgmode/2013-05/msg00791.html),
and implemented its fix by adding the following to my `~/.emacs`:

```
(setq org-latex-pdf-process (quote ("texi2dvi --pdf --clean --verbose
--batch %f" "bibtex %b" "texi2dvi --pdf --clean --verbose --batch %f"
"texi2dvi --pdf --clean --verbose --batch %f")))
```

Finally, you can get numbers instead of images by adding

```
#+LATEX_HEADER: \setbeamertemplate{bibliography item}[text]
```

Outer Themes, Short Titles, etc.
----------------------------------

Org-mode naturally picks up on outer themes with `BEAMER_OUTER_THEME`, but they
don't support the constructs that usually comprise outer themes, like
institutions, short titles, etc. If you use the bleeding edge master repository
(as of Tues. March 10, 2015), then you can use the `BEAMER_HEADER` to inject the
appropriate structures. For example, to get a title in all output forms *and* a
short title in Beamer using an outer theme, let's say `infolines`, you can do
the following:

```
#+TITLE: A Long Title
#+BEAMER_OUTER_THEME: infolines
#+BEAMER_HEADER: \title[A Short Title]{A Long Title}
```

Yes, I know. You have to type `A Long Title` twice. I tried using
`\inserttitle`, but it borked on computers with "small" memory size (4GB). This
is a small hit for what I'd consider a large effect.

Helpful Hints
--------------

[Cycling](http://orgmode.org/manual/Global-and-local-cycling.html#Global-and-local-cycling) through collapseable regions.