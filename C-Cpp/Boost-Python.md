# Boost-Python

## Table of Contents
1. [Compile](#compile)

## Compile
### `pyconfig.h` error

1. If you use virtualenv, search `/usr/local/var/pyenv/versions/3.6.0/include/python3.6m/pyconfig.h`. 
2. add `export CPLUS_INCLUDE_PATH="$CPLUS_INCLUDE_PATH:/usr/local/var/pyenv/versions/3.6.0/include/python3.6m/"` in `~/.bash_profile`. Do not forget to execute `source ~/.bash_profile` after editing.
