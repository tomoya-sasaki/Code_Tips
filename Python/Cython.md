# Cython
* [Official Tutorials](#http://docs.cython.org/en/latest/src/tutorial/cython_tutorial.html)

## Table of Contents
1. [Basics](#basics)

## Basics
### Make Cython library
```python
# setup.py
from distutils.core import setup
from Cython.Build import cythonize

setup(
    ext_modules = cythonize("NewCython.pyx")
)
```
Then,
```terminal
$ python setup.py build_ext --inplace
```
