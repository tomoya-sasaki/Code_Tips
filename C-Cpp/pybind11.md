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
// example.cpp
#include <pybind11/pybind11.h>
#include <string>

class Pet {
public:
  Pet(const std::string &name) : name(name) {}
  void setName(const std::string &name_) { name = name_; }
  const std::string &getName() const { return name; }
  static std::string getClassName() { return "Pet"; }
  std::string name;
};

namespace py = pybind11;

PYBIND11_PLUGIN(example) {
  py::module m("example", "pybind11 example plugin");

  py::class_<Pet>(m, "Pet")
      .def(py::init<const std::string &>())
      .def("setName", &Pet::setName)
      .def("getName", &Pet::getName)
      .def_static("getClassName", &Pet::getClassName);

  return m.ptr();
}
```

```python
>>> import example
>>> a = example.Pet('taro')
>>> a
<example.Pet object at 0x7f9563de5e68>
>>> a.getName()
'taro'
```
