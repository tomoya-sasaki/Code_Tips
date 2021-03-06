# Cython
* [Official Tutorials](#http://docs.cython.org/en/latest/src/tutorial/cython_tutorial.html)

## Table of Contents
1. [Basics](#basics)
    * [C variable and type definitions](#c-variable-and-type-definitions)
2. [With Numpy](#with-numpy)
3. [Class](#class)
   * [class内の変数の呼び出し](#class内の変数の呼び出し)
   * [for loop](#for-loop)
4. [Global Variable](#global-variable)

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
