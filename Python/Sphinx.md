# Sphinx
[Reference 1](https://joppot.info/2018/03/30/4156)

## Table of Contents
1. [Install](#install)
2. [Initialization](#initialization)
3. [Compile](#compile)

## Install
```terminal
$ pip install Sphinx
```

## Initialization

### Create a folder
```terminal
$ mkdir docs
$ sphinx-quickstart docs
```
Default values are shown in square brackets. Be sure to select yes to the `autodoc` extension (you might want to use MathJax as well).

### Edit conf.py

Set up path:
```py
import os
import sys
sys.path.insert(0, os.path.abspath('../'))
```

Under `extentions = [...]`:
```py
# Include Python objects as they appear in source files
# Default: alphabetically ('alphabetical')
autodoc_member_order = 'bysource'
# Default flags used by autodoc directives
autodoc_default_flags = ['members', 'show-inheritance']
```

### Add mock libralies
If you get an error such as `No module named numpy` when you compile, add the following line in `conf.py`:
```py
autodoc_mock_imports = ["numpy"]
```

## Compile
### Easy
```terminal
$ cd docs
$ make html
$ make latexpdf
```

### Manual
```terminal
$ sphinx-apidoc -f -o ./docs ./
$ sphinx-build -b html ./docs ./docs/_build
```
