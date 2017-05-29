# pyper

## Table of Contents

## Basic
```python
import pyper
R = pyper.R(use_pandas='True')
R.assign("data",  df)
print(R('summary(glm(Y ~ X2 + X3, data = data, family = "binomial"))'))
```
Print is useful to check an error in R.
