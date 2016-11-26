# Cython
* [Official Tutorials](#http://docs.cython.org/en/latest/src/tutorial/cython_tutorial.html)

## Table of Contents
1. [Basics](#basics)
    * [C variable and type definitions](#c-variable-and-type-definitions)
2. [With Numpy](#with-numpy)

## Basics
### Import Cython Code
#### If you prepare "setup.py" manually
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
> a Cython module, Python functions and C functions can call each other freely, but only Python functions can be called from outside the module by interpreted Python code. So, any functions that you want to “export” from your Cython module must be declared as Python functions using **def**.

## With Numpy
基本はこのように設定すれば良いはず:
```python
#setup.py
from distutils.core import setup
from Cython.Build import cythonize
import numpy

setup(
    name = 'test',
    ext_modules = cythonize('test.pyx')
    include_dirs = [numpy.get_include()]
    )
```
しかし、`AttributeError: 'module' object has no attribute 'Handler'`というエラーが出てしまってコンパイルできない。
そこで、Pythonで`numpy.get_include()`して得たpathを直に入れた

```python
#setup.py
from distutils.core import setup
from Cython.Build import cythonize

setup(
        name = 'test',
        ext_modules = cythonize('test.pyx'),
        include_dirs = "/usr/local/lib/python3.4/site-packages/numpy/core/include"
)
```
これで、`cd`でディレクトリに移動して`python3 setup.py build_ext --inplace`する。場合によっては`sudo`つける必要があるかも。

### 注意事項
* `.pyx`の冒頭には`from __future__ import division`が要るかも
* 保存しているフォルダ名に`_`や`-`があると上手くいかなかった (理想的には小文字じゃないとダメ?)
