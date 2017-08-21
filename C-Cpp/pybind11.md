# pybind11

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
