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
6. [Cython](#cython)

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
Output folder is different from manual execution.

### Manual
```terminal
$ sphinx-apidoc -f -o ./docs ./
$ sphinx-build -b html ./docs ./docs/_build
```
Output folder is different from easy execution.

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

If something goes wrong, try `make clean` in `docs` folder and rerun the code.

## Exclude files
[Reference](http://www.sphinx-doc.org/en/master/usage/configuration.html#confval-exclude_patterns)
```py
exclude_patterns = ["run.rst"] # If you want to exclude run.py
```
It seems it does not work if we use `sphinx-apidoc`, and we need to set excluded files saparately ([link](https://stackoverflow.com/a/43868129/4357279)).

## Grammar
[Full code example](https://pythonhosted.org/an_example_pypi_project/sphinx.html#full-code-example) is useful.

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

```py
def example(name):
    """Simpler example
    Args:
        name (str): name
    Returns:
        name_id (int): name ID
    """
```

## Cython
`setup.py` should be like this ([Reference](https://github.com/abingham/cython-sphinx-example)):

```py
# setup.py
"""Build Cython files
"""

from distutils.core import setup
from distutils.extension import Extension
from Cython.Distutils import build_ext


def main():
    """Compile Cython files
    """

    ext_modules = [
                Extension("test", sources=["test.pyx"])
            ]

    # This is the important part. By setting this compiler directive, cython will
    # embed signature information in docstrings. Sphinx then knows how to extract
    # and use those signatures.
    for e in ext_modules:
        e.compiler_directives = {"embedsignature": True}

    setup(
        name='Demonstrating Sphinx function signatures for Cython modules',
        cmdclass={'build_ext': build_ext},
        ext_modules=ext_modules
    )

if __name__ == "__main__":
    main()
```
`cpdef` and `def` are fine, but `cdef` is not included.
