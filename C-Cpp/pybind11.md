# pybind11
In AmazonEC2, check [this](https://github.com/Shusei-E/Code_Tips/blob/master/AmazonEC2/pybind11.md).

## Table of Contents
1. [Install](#install)
2. [Compile](#compile)

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
