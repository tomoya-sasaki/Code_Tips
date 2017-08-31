# pybind11
In AmazonEC2, check [this](https://github.com/Shusei-E/Code_Tips/blob/master/AmazonEC2/pybind11.md).

## Table of Contents
1. [Install](#install)
2. [Compile](#compile)
3. [Vector](#vector)
4. [Class](#class)
5. [Return values](#return-values)

## Install
### Prerequisite
1. Download files and move `pybind11-master/include/pybind11` to `/usr/local/include/pybind11`
2. cmake: `brew install cmake`
3. `pip install pybind11`

You may want to edit `~/.bash_profile`:
```
export PYENV_ROOT="/usr/local/var/pyenv"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export CPLUS_INCLUDE_PATH="$CPLUS_INCLUDE_PATH:/usr/local/var/pyenv/versions/3.6.0/include/python3.6m/"
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)" ; fi
```

## Compile
### Use pyenv
#### pybind11 package
We need a Python package called `pybind11` ([Official Manual](http://people.duke.edu/~ccc14/sta-663-2016/18G_C++_Python_pybind11.html#)). We prepare two cpp files.
```cpp
#include <pybind11/pybind11.h>
#include <string>
using namespace std;

class Car {
public:
  Car(const string &name) : name(name) {}
  void setOwner(const string &name_) { name = name_; }
  const string &getOwner() const { return name; }
  static string getClassName() { return "Car"; }

  string name;
};

namespace py = pybind11;

PYBIND11_PLUGIN(example) {
  py::module m("example", "pybind11 example plugin");

  py::class_<Car>(m, "Car")
      .def(py::init<const string &>())
      .def("setOwner", &Car::setOwner)
      .def("getOwner", &Car::getOwner)
      .def_static("getClassName", &Car::getClassName);

  return m.ptr();
}
```
```cpp
// wrap.cpp
#include <pybind11/pybind11.h>
int add(int i, int j) {
    return i + j;
};

namespace py = pybind11;
using namespace pybind11::literals;

PYBIND11_PLUGIN(wrap) {
    py::module m("wrap", "pybind11 example plugin");
    m.def("add", &add, "A function which adds two numbers",
          "i"_a=1, "j"_a=2);
    return m.ptr();
}
```
We need setup.py:
```py
import os, sys
from distutils.core import setup, Extension
from distutils import sysconfig

cpp_args = ['-std=c++11', '-stdlib=libc++', '-mmacosx-version-min=10.7']

ext_modules = [
    Extension(
    'example',
        ['example.cpp'],
        include_dirs=['pybind11/include'],
    language='c++',
    extra_compile_args = cpp_args,
    ),
    Extension(
    'wrap',
        ['wrap.cpp'],
        include_dirs=['pybind11/include'],
    language='c++',
    extra_compile_args = cpp_args,
    )
]

setup(
    #name='example', version='0.0.1', author="Name", author_email='Email', description='Example',
    ext_modules=ext_modules
)
```
Finally,
```terminal
$ python setup.py build_ext -i
```

#### cppimport
Let's prepare the package by typing `$ pip install cppimport`.

Fitst, we need add a header in front of the cpp files. For example, `wrap.cpp` in the previous example will become,
```cpp
<%
cfg['compiler_args'] = ['-std=c++11', '-stdlib=libc++', '-mmacosx-version-min=10.7']
setup_pybind11(cfg)
%>
// wrap.cpp
...[[SAME AS BEFORE]]...
```
In python, you can load cpp:
```python
>>> import cppimport
>>> wrap = cppimport.imp('wrap')
```

### Use System Python
```
clang++ -stdlib=libc++ -std=c++11  -O3 -shared -std=c++11 -I/usr/local/include/pybind11/ `python-config --cflags --ldflags` example.cpp -o example.so
```
C++ file (I used an example in [this blog](http://myenigma.hatenablog.com/entry/2016/12/17/075812#サンプルコード)):
```cpp
#include <pybind11/pybind11.h>
#include <string>
using namespace std;

class Car {
public:
  Car(const string &name) : name(name) {}
  void setOwner(const string &name_) { name = name_; }
  const string &getOwner() const { return name; }
  static string getClassName() { return "Car"; }

  string name;
};

namespace py = pybind11;

PYBIND11_PLUGIN(example) {
  py::module m("example", "pybind11 example plugin");

  py::class_<Car>(m, "Car")
      .def(py::init<const string &>())
      .def("setOwner", &Car::setOwner)
      .def("getOwner", &Car::getOwner)
      .def_static("getClassName", &Car::getClassName);

  return m.ptr();
}
```

```python
>>> import example
>>> a = example.Car('you')
>>> a.getOwner()
'you'
```

## Vector
test.cpp:
```cpp
// test.cpp
#include <vector>
#include <pybind11/pybind11.h>
#include <pybind11/stl.h>

using namespace std;
namespace py = pybind11;


vector<int> make_list1() {
  vector<int> v;
  v.push_back(1);
  return v;
}

vector<vector<int>> make_list2() {
  vector<vector<int>> v;
  
  for(int i=0; i<3; i++){
    vector<int> temp_vec;
    temp_vec.push_back(i);
    v.push_back(temp_vec);
  }

  return v;
}

PYBIND11_PLUGIN(test) {
  py::module m("test", "pybind11 example plugin");

  m.def("make_list1", &make_list1);
  m.def("make_list2", &make_list2);

  return m.ptr();
}
```
test.py
```py
if __name__ == '__main__':
  import test
  print(test.make_list1())
  print(test.make_list2())
```

## Class
test.cpp
```cpp
// test.cpp
#include <vector>
#include <pybind11/pybind11.h>
#include <pybind11/stl.h>

using namespace std;
namespace py = pybind11;

class Vec1{
public:
  Vec1(){ }

  vector<int> make_list1() {
    vector<int> v;
    v.push_back(1);
    return v;
  }
};

class Vec2{
private:
  int loop_num=0;
public:
  Vec2(int &num){
    loop_num = num;
  }

  vector<vector<int>> make_list2() {
    vector<vector<int>> v;
    
    for(int i=0; i<loop_num; i++){
      vector<int> temp_vec;
      temp_vec.push_back(i);
      v.push_back(temp_vec);
    }
    return v;
  }
};

PYBIND11_PLUGIN(test) {
  py::module m("test", "pybind11 example plugin");

  py::class_<Vec1>(m, "Vec1")
    .def(py::init()) // for constructor
    .def("make_list1", &Vec1::make_list1);

  py::class_<Vec2>(m, "Vec2")
    .def(py::init<int &>()) // for constructor
    .def("make_list2", &Vec2::make_list2);

  return m.ptr();
}
```
test_main.py
```py
# test_main.py

if __name__ == '__main__':
    import test
    v1 = test.Vec1()
    v2 = test.Vec2(5)
    print(v1.make_list1())
    print(v2.make_list2())
```

## Return values
If you use Eigen and Numpy, you can use pass-by-reference (not for sparse matrix) and returning reference ([check](http://pybind11.readthedocs.io/en/master/advanced/cast/eigen.html#returning-values-to-python)).

(Probably) If Python object is immutable, the value won't change even if you return reference.
* Immutable
  * int, float, str, tuple, bytes, frozenset
* Mutable
  * list, dict, set, bytearray
