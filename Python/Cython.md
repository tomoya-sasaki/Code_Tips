# Cython
* [Official Tutorials](#http://docs.cython.org/en/latest/src/tutorial/cython_tutorial.html)

## Table of Contents
1. [Basics](#basics)
    * [C variable and type definitions](#c-variable-and-type-definitions)

## Basics
### Import Cython Code
#### If you need setup manually
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

#### Extra C libraries or a special build setup is not required
```python
import pyximport; pyximport.install()
```
Then, you can `import NeyCython`.

### C variable and type definitions
