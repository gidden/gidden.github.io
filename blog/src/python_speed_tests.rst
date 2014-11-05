uuid hex equality
-----------------

Test
====

In [135]: import uuid

In [136]: x = uuid.uuid4()

In [8]: timeit -n100000 x == uuid.uuid4()
100000 loops, best of 3: 28.5 µs per loop

In [9]: timeit -n100000 x.hex == uuid.uuid4().hex
100000 loops, best of 3: 29.7 µs per loop

In [10]: timeit -n100000 x == x
100000 loops, best of 3: 682 ns per loop

In [11]: timeit -n100000 x.hex == x.hex
100000 loops, best of 3: 1.76 µs per loop

Conclusion
==========

No difference in comparing different values between uuid form and string form,
3x speedup in comparing same values for uuid form. Use uuid form.

cyclopts get n_arcs
-------------------

In [6]:
for iid, sids in iid_to_sids.items():
    %timeit -n 1000 cycio.uuid_rows(prop_tbl, iid)[0]['n_arcs']
1000 loops, best of 3: 503 µs per loop
1000 loops, best of 3: 498 µs per loop
1000 loops, best of 3: 475 µs per loop
1000 loops, best of 3: 490 µs per loop