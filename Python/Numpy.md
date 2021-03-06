# Numpy
* [100 numpy exercises](https://github.com/rougier/numpy-100)
* [Scipy Lecture Notes](http://www.scipy-lectures.org/index.html)

## Table of Contents
1. [arrayとmatrixの違い](#arrayとmatrixの違い)
2. [行列の掛け算](#行列の掛け算)
3. [size](#size)
4. [縦ベクトル](#縦ベクトル)
5. [object too deep for desired array](#object-too-deep-for-desired-array)
6. [配列への追加](#配列への追加)
7. [要素の数を数える](#要素の数を数える)
8. [警告・エラー表示の変更](#警告エラー表示の変更)
9. [配列の要素とindexのsort](#配列の要素とindexのsort)

## arrayとmatrixの違い
[Reference](http://stackoverflow.com/questions/4151128/what-are-the-differences-between-numpy-arrays-and-matrices-which-one-should-i-u)

Numpy matrices are *strictly 2-dimensional*, while numpy arrays (ndarrays) are N-dimensional. Matrix objects are a subclass of ndarray, so they inherit all the attributes and methods of ndarrays.

The main advantage of numpy matrices is that they provide a convenient notation for matrix multiplication: if `a` and `b` are matrices, then `a*b` is their matrix product.

Both matrix objects and ndarrays have `.T` to return the transpose, but matrix objects also have `.H` for the conjugate transpose, and `.I` for the inverse.

In contrast, numpy arrays consistently abide by the rule that operations are applied *element-wise*. Thus, if a and b are numpy arrays, then `a*b` is the array formed by multiplying the components element-wise.

The `**` operator also behaves differently. `a` is a matrix, `a**2` returns the matrix product `a*a`. Since `c` is an ndarray, `c**2` returns an ndarray with each component squared element-wise.

`np.asmatrix` and `np.asarray` allow you to convert one to the other (as long as the array is 2-dimensional).

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

## size
```python
>> x = np.zeros((3, 5, 2), dtype=np.complex128)
>> size(x,0)
3
>> size(x,1)
5
>> size(x,2)
2
>> size(x)
30
```

## 縦ベクトル
```python
>> a = np.array([1, 2, 3, 2, 3, 4])
>> np.vstack(a)
array([[1],
       [2],
       [3],
       [2],
       [3],
       [4]])
>> a[:, np.newaxis]
array([[1],
       [2],
       [3],
       [2],
       [3],
       [4]])
```

## object too deep for desired array
`np.squeeze(np.asarray(OBJECT))`

## 配列への追加
`append` methodでOKみたい

## 要素の数を数える
```python
np.unique(Z, return_counts=True)
```
個数0でも出力:
```python
np.array(list(map(lambda k: np.sum(Z==k), range(K))))
# K: number of category
# Z: array you want to check
```

## 警告・エラー表示の変更
[numpy.seterr](https://docs.scipy.org/doc/numpy/reference/generated/numpy.seterr.html)
```python
old_settings = np.seterr(all='ignore')
np.seterr(over='raise')
np.seterr(**old_settings)  # reset to default
```

## 配列の要素とindexのsort
sort関数は昇順にソートした要素の配列、argsort関数は昇順にソートしたインデックスの配列を返すため、[::-1]というスライスの書き方を使って逆順、つまり、降順にする。
```python
x = np.array([19, 5, 58, 30])

for i in range(len(x)):
    print np.argsort(x)[::-1][i], np.sort(x)[::-1][i]
```
Output:
```txt
2 58
3 30
0 19
1 5
```
