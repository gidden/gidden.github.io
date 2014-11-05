Keyword Argument Filter
-----------------------

Say you want to plot some data from some aggregate set of data. Reducing your
set to just he data you want to plot may require a function call with keywords,
and how you plot it may require a function call with keywords. Finally, you want
a driver function that will grab the right data *and* plot it for you. How do
you pass in keyword arguments to two possibly disparate functions using a single
driver without *explicitly naming all appropriate kwargs*?

Take the following example:

In [4]: def a(x=1):
    print(x)
   ...:     

In [5]: def b(y=2):
    print(y)
   ...:

In [3]: def c(**kwargs):
   ...:     a(**kwargs)
   ...:     b(**kwargs)
   ...:   

Invoking `c(x=4, y=5)` results in the following error:

In [7]: c(x=5, y=6)
---------------------------------------------------------------------------
TypeError                                 Traceback (most recent call last)
<ipython-input-7-3f1c2cdaa099> in <module>()
----> 1 c(x=5, y=6)

<ipython-input-6-2a1195db3df0> in c(**kwargs)
      1 def c(**kwargs):
----> 2     a(**kwargs)
      3     b(**kwargs)
      4 

TypeError: a() got an unexpected keyword argument 'y'

Ok, we can start to fix this up, let's redefine a to pass through our `**kwargs`

In [8]: def a(x=1, **kwargs):
    print(x)
   ...:     

In [9]: c(x=5, y=6)
5
---------------------------------------------------------------------------
TypeError                                 Traceback (most recent call last)
<ipython-input-9-3f1c2cdaa099> in <module>()
----> 1 c(x=5, y=6)

<ipython-input-6-2a1195db3df0> in c(**kwargs)
      1 def c(**kwargs):
      2     a(**kwargs)
----> 3     b(**kwargs)
      4 

TypeError: b() got an unexpected keyword argument 'x'

Hmmm, ok, following that pattern, we can redefine b similarly:

In [11]: def b(y=2, **kwargs):
    print(y)
   ....:     

In [13]: c(x=5, y=6)
5
6

Ok, great! Our function does as we intend, but we had to mess with our other
function signatures. What if the function you want to call using your driver
exists in another library? In short, we want to deal with the case in which a
looks like `a(x=1)`.

One approach would be to *condition* our kwargs. That is, inspect them, and only
give `a()` the kwargs it expects. But how?

There are two basic approaches

#. Use the `inspect` module

In [55]: import inspect

In [56]: inspect.getargspec(a)
Out[56]: ArgSpec(args=['x'], varargs=None, keywords=None, defaults=(1,))

In [57]: spec = inspect.getargspec(a)

In [58]: spec.args[-len(spec.defaults):]
Out[58]: ['x']

(thanks http://stackoverflow.com/questions/10120974/where-is-the-default-parameter-in-python-function)

#. Use a combination of  `func_defaults` and `func_code.co_varnames`

In [63]: a.func_defaults
Out[63]: (1,)

In [64]: a.func_code.co_varnames
Out[64]: ('x',)

In [65]: a.func_code.co_varnames[-len(a.func_defaults):]
Out[65]: ('x',)

Since the inspect module gives you a nicer interface, why not use it?

Ok, so back to the problem at hand: we want to condition the kwargs we send to a
function based on its signature. Let's state our goals as getting the following
situation to work:

In [66]: def a(x=1):
   ....:     print(x)
   ....:     

In [67]: def b(y=2, **kwargs):
   ....:     print(y)
   ....:  
   
In [71]: def c(**kwargs):
    a(**some_condition_function(kwargs, a))
    b(**some_condition_function(kwargs, b))
   ....:  

So now we need to go about implementing our condition function. Let's take a first hack at it:

In [73]: def some_condition_function(kwargs, func):
    spec = inspect.getargspec(func)
    fkwargs = spec.args[-len(spec.defaults):]
    return {k: v for k, v in kwargs.items() if k in fkwargs}
   ....:

In [75]: c()
1
2

In [76]: c(x=5)
5
2

In [77]: c(y=5)
1
5

Sweet! There's only one catch. Let's look at the output of our condition function:
In [78]: some_condition_function({'x': 5}, a)
Out[78]: {'x': 5}

In [79]: some_condition_function({'x': 5}, b)
Out[79]: {}

Ahh, but `b()` also passes along its `**kwargs`, and our conditioning function 
just took them out.. Let's fix that.

In [97]: def some_condition_function(kwargs, func):
    spec = inspect.getargspec(func)
    if spec.keywords is not None:
        return kwargs
    return {k: v for k, v in kwargs.items() if k in spec.args[-len(spec.defaults):]}

In [99]: some_condition_function({'x': 5}, b)
Out[99]: {'x': 5}

Et voila!