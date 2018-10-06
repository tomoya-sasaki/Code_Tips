# OS

## Table of Contents
1. [Check folder and make](#check-folder-and-make)


## Check folder and make
```python
def folder_check(str path):
    if os.path.isdir(path) is False:
        os.makedirs(path)
```
