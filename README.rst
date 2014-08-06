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

========    =================   =============
Host Name   IP Address/URL      Record Type
---------   -----------------   -------------
@           199.27.74.133       A (Address)
www         gidden.github.io.   CNAME (Alias)
========    =================   =============

On Aug. 6, 2014, I noticed that the website no longer loads. I ran ``nslookup``
with the following results.

.. code-block::

    $ nslookup gidden.github.io
    Server:127.0.1.1
    Address:127.0.1.1#53

    Non-authoritative answer:
    gidden.github.iocanonical name = github.map.fastly.net.
    Name:github.map.fastly.net
    Address: 23.235.40.133

I am now trying to change the ``@`` record IP Address to ``23.235.40.133``.

LICENSE
=======

Everything in ``index.html`` and ``blog`` are Copyright Matthew
Gidden. Everything in ``cyclopts`` licensed as found in the `cyclopts repo
<https://github.com/gidden/cyclopts/blob/master/license>`_.