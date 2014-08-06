gidden.github.io
================

Matt Gidden's github website


Notes
=====

The `original
<http://www.styleshout.com/hits.php?id=35&url=templates/downloads/Ceevee10.zip>`_
version from `styleshout <http://www.styleshout.com/>`_ had a couple of other
cool out-of-the-box features that weren't necessary for a first-blush
implementation. They could easily be reimplemented by either uncommenting them
in ``index.html`` or pulling the desired blocks out of
``boilerplate/index.html``. Note that the original ``layout.css`` also lives in
``boilerplate/layout.css``.

Github IP Address Forwarding
============================

Upon initially setting this site up, I registered ``mattgidden.com`` with
namecheap and modified the host records as follows:

=========   =================   =============
Host Name   IP Address/URL      Record Type
---------   -----------------   -------------
@           199.27.74.133       A (Address)
www         gidden.github.io.   CNAME (Alias)
=========   =================   =============

On Aug. 6, 2014, I noticed that the website no longer loads. Github has a page
discussing the `configuration of A records
<https://help.github.com/articles/tips-for-configuring-an-a-record-with-your-dns-provider>`,
suggesting that ``192.30.252.153`` and ``192.30.252.154`` should be
used. Namecheap (with minimal searching) looks to only have one ``@`` entry. I
changed it to ``192.30.252.153``, and now we're live again. Huzzah!


LICENSE
=======

Everything in ``index.html`` and ``blog`` are Copyright Matthew
Gidden. Everything in ``cyclopts`` licensed as found in the `cyclopts repo
<https://github.com/gidden/cyclopts/blob/master/license>`_.