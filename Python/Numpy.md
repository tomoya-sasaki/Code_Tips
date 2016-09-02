# Numpy

## Table of Contents
1. [行列の掛け算](#行列の掛け算)

## 行列の掛け算
`array`と`matrix`で異なるので注意
```python
A = numpy.array([[1,2,3],[4,5,6]])
B = numpy.array([[2,3],[4,5],[6,7]])
A.dot(B)
```
```python
A = numpy.matrix([[1,2,3],[4,5,6]])
B = numpy.matrix([[2,3],[4,5],[6,7]])
A * B
```
