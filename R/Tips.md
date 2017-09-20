# Tips

## Table of Contents
1. [Easy psudo global variable](#easy-psudo-global-variable)


## Easy psudo global variable
```py
# a.py
import opt
opt.a = 2
```

```py
# b.py
import a
import opt
print(opt.a)
```
```py
# opt.py
a = None
```

Execute:
```terminal
$ python b.py
2
```
