# Boost-Python
pybind11 might be better?

## Table of Contents
1. [Compile](#compile)

## Compile
### `pyconfig.h` error

1. If you use virtualenv, search `/usr/local/var/pyenv/versions/3.6.0/include/python3.6m/pyconfig.h`. 
2. add `export CPLUS_INCLUDE_PATH="$CPLUS_INCLUDE_PATH:/usr/local/var/pyenv/versions/3.6.0/include/python3.6m/"` in `~/.bash_profile`. Do not forget to execute `source ~/.bash_profile` after editing.

### Link error
Install boost-python with Python3.x support but without Python2.x support: `brew install boost-python --with-python3 --without-python`. Before do it, make sure you are in Python3.x environment (Do we need `brew install boost --with-c++11`??).

### makefile
