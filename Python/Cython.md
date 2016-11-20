# Cython
* [Official Tutorials](#http://docs.cython.org/en/latest/src/tutorial/cython_tutorial.html)

## Table of Contents
1. [Basics](#basics)
    * [C variable and type definitions](#c-variable-and-type-definitions)
2. []()

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
`main.py`みたいなのを作って、以下のようにして簡単で良さそう。
```python
if __name__ == '__main__':
 import pyximport; pyximport.install()  
 import NewCython
```

### C variable and type definitions
[Reference](http://docs.cython.org/en/latest/src/userguide/language_basics.html#c-variable-and-type-definitions)

変数の宣言時には、以下に注意
> a Cython module, Python functions and C functions can call each other freely, but only Python functions can be called from outside the module by interpreted Python code
