# Cython
You might want to use [pybind11](https://github.com/Shusei-E/Code_Tips/blob/master/C-Cpp/pybind11.md) to integrate C++ and Python.

* [Official Tutorials](#http://docs.cython.org/en/latest/src/tutorial/cython_tutorial.html)

cdefの中では特に使う変数に型を明示。return valueも型がわかれば`cdef double func():`のようにできる。

## Table of Contents
1. [Basics](#basics)
    * [C variable and type definitions](#c-variable-and-type-definitions)
2. [With Numpy](#with-numpy)
3. [Class](#class)
   * [class内の変数の呼び出し](#class内の変数の呼び出し)
   * [for loop](#for-loop)
4. [Global Variable](#global-variable)
5. [Make Cython even faster](#make-cython-even-faster)
6. [Parallel](#parallel)

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
Then, ([将来的に変わる？](https://github.com/cython/cython/issues/1509))
```terminal
$ python setup.py build_ext --inplace
```

#### If extra C libraries or a special build setup is not required
```python
import pyximport; pyximport.install()
```
Then, you can `import NewCython`.  
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
### .pyx
```python
from __future__ import division
import numpy as np
cimport numpy as np
cimport cython
```

### setup.py
基本はこのように設定すれば良いはず:
```python
#setup.py
from distutils.core import setup
from Cython.Build import cythonize
import numpy

setup(
    name = 'test',
    ext_modules = cythonize('test.pyx'),
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
これで、`cd`でディレクトリに移動して`python setup.py build_ext --inplace`する。場合によっては`sudo`つける必要があるかも。

### 注意事項
* `.pyx`の冒頭には`from __future__ import division`が要るかも
* 保存しているフォルダ名に`_`や`-`があると上手くいかなかった (理想的には小文字じゃないとダメ?)

## Class
[Reference](http://nekowarau.seesaa.net/article/429150491.html)    
`def`としても`cdef`としてもOK。恐らく`cdef`とするとpython側から使えない。<br>
クラスに対しても`class`ではなく`cdef class`とできる(classに`cdef`とすることでclassのメソッドに`cdef`を使える)。

```python
cdef class Node:
    cdef list path
    def __cinit__(self):
       self.path = [] 
    cdef int method(self):
        for i in range(100000):
            self.f()
        return i
```

### class内の変数の呼び出し
[Reference](http://omake.accense.com/static/doc-ja/cython/src/userguide/extension_types.html)
```python
cdef class Shrubbery:

    cdef int width, height

    def __init__(self, w, h):
        self.width = w
        self.height = h

    def describe(self):
        print "This shrubbery is", self.width, \
            "by", self.height, "cubits."
```
というクラスがあったら、
```python
cdef widen_shrubbery(Shrubbery sh, extra_width):
    sh.width = sh.width + extra_width
```
や
```python
cdef Shrubbery another_shrubbery(Shrubbery sh1):
    cdef Shrubbery sh2
    sh2 = Shrubbery()
    sh2.width = sh1.width
    sh2.height = sh1.height
    return sh2
```
また、関数でreturnさせるには、
```python
cdef Shrubbery sh = quest() # Shrubbery 型のオブジェクトを返す quest() というメソッド
```

### for loop
上と関連して、for loopのiterationのobjectとしてclassをそのまま扱うことはできなかった。以下`Node`というクラスがあるとする。

```python
# Bad Example
for node in root_node.children: # children is a list in class, and contains a lot of nodes
	if prob < node.phi: # check horizontal stop
		prob = npr.uniform(0.0, 1.0)
```
これを動かすには、
```python
# Good Example
cdef Node iter_node
for node in root_node.children: # children is a list in class, and contains a lot of nodes
	iter_node = node

	if prob < iter_node.phi: # check horizontal stop
		prob = npr.uniform(0.0, 1.0)
```

## Global Variable
[Reference](https://github.com/cython/cython/wiki/FAQ#how-do-i-declare-a-global-variable)
```python
cdef double alpha

cdef main():
  global alpha
  alpha = 5.0
```

## Make Cython even faster
```python
cdef extern from "math.h":
   double log (double x) nogil
   double exp (double x) nogil
   double lgamma (double x)
   double tgamma (double x) nogil
```
`"math.h"` might be `"<math.h>"`. I'm not sure `nogil` is necessary. Functions are listed in [cython/Cython/Includes/libc/math.pxd](https://github.com/cython/cython/blob/master/Cython/Includes/libc/math.pxd)

## Parallel
### Prepare
We need set up OpenMP for clang ([reference](https://qiita.com/hinatades/items/79935d8a2a93ddabe077#%E8%BF%BD%E8%A8%9820161109)).
```terminal
$ brew install llvm
```
In `~/.bashrc` (not necessary),
```bashrc
alias clang-omp='/usr/local/opt/llvm/bin/clang -fopenmp -L/usr/local/opt/llvm/lib -Wl,-rpath,/usr/local/opt/llvm/lib'
alias clang-omp++='/usr/local/opt/llvm/bin/clang++ -fopenmp -L/usr/local/opt/llvm/lib -Wl,-rpath,/usr/local/opt/llvm/lib'
```

### setup.py
```python
from distutils.core import setup
from distutils.extension import Extension
from Cython.Distutils import build_ext
import numpy

import os
os.environ["CC"] = "/usr/local/opt/llvm/bin/clang -L/usr/local/opt/llvm/lib -Wl,-rpath,/usr/local/opt/llvm/lib"
os.environ["CXX"] = "/usr/local/opt/llvm/bin/clang++ -L/usr/local/opt/llvm/lib -Wl,-rpath,/usr/local/opt/llvm/lib"

# loglik uses parallel
ext_modules=[
    Extension("loglik", sources=["loglik.pyx"], include_dirs = [numpy.get_include()], libraries=["m"],
              extra_compile_args = ["-O3", "-ffast-math", "-march=native", "-fopenmp" ],
              extra_link_args=['-fopenmp']),
    Extension("utilTSTM", sources=["utilTSTM.pyx"], include_dirs = [numpy.get_include()], extra_compile_args = ["-ffast-math"])
]

setup(
  name = 'TSSB_CSTM',
  cmdclass = {'build_ext': build_ext},
  ext_modules = ext_modules,
)
```
`loglik.py`
```python
cdef double calc_nodellk_loop(np.ndarray[ftype_t, ndim=1] Psi_s, list word_ids, int num):
    cdef double loglik = 0.0
    cdef int index
    cdef int word_id

    
    cdef np.ndarray[dtype_t, ndim=1] word_ids_np = np.array(word_ids, dtype=np.int32)
    
    for index in prange(num, nogil=True):
        word_id = word_ids_np[index]
        loglik += Psi_s[word_id]
    
    return loglik
```
