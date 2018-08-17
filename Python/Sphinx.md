# Sphinx
* [Reference 1](https://joppot.info/2018/03/30/4156)
* [Reference 2: pypi](https://pythonhosted.org/an_example_pypi_project/sphinx.html#code)
  * [Full code example](https://pythonhosted.org/an_example_pypi_project/sphinx.html#full-code-example)

## Table of Contents
1. [Install](#install)
2. [Initialization](#initialization)
3. [Compile](#compile)
4. [Exclude files](#exclude-files)
5. [Grammar](#grammar)

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

### Edit index.rst
```
.. toctree::
   :maxdepth: 2
   :caption: Contents:

   modules
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

Make a `run.py`:
```python
import subprocess
 
def run():
    commands = [["sphinx-apidoc","-f","-o","./docs","./"],
            ["sphinx-build","-b","html","./docs","./docs/_build"] # cmd_doc
        ]
 
    for cmd in commands:
        subprocess.run(cmd)
 
if __name__ == '__main__':
    run()
```

## Exclude files
[Reference](http://www.sphinx-doc.org/en/master/usage/configuration.html#confval-exclude_patterns)
```py
exclude_patterns = ["run.rst"] # If you want to exclude run.py
```
It seems it does not work if we use `sphinx-apidoc`, and we need to set excluded files saparately ([link](https://stackoverflow.com/a/43868129/4357279)).

## Grammar
Make sure you include
```py
if __name__ == "__main__":
   pass # could be anything
```

### function
```py
def example(name, state=None):
    """Example code

    :param name: The name to use.
    :type name: str.
    :param state: Current state to be in.
    :type state: bool.
    :returns:  int -- the return code.
    :raises: AttributeError, KeyError
    
    We can use it as follows:
    
    >> example("Your name")
    """
    return 0
```
