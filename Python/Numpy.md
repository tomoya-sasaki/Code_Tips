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
10. [特定の列または行で並び替え](#特定の列または行で並び替え)
11. [行列をindexで並び替え](#行列をindexで並び替え)
12. [vectorを繰り返してmatrixにする](#vectorを繰り返してmatrixにする)
13. [Sparse matrix](#sparse-matrix)
14. [Save](#save)
15. [reshape](#reshape)
16. [einsum](#einsum)


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
np.seterr(all='warn')
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

## 特定の列または行で並び替え
```python
>>> x = np.array(([4,2,3], [3,2,4]))
>>> x
array([[4, 2, 3],
       [3, 2, 4]])
>>> (x[ x[:, 0].argsort()]) # 0列目でsort
array([[3, 2, 4],
       [4, 2, 3]])
>>> x[:,  x[0, :].argsort()] # 0行目でsort
array([[2, 3, 4],
       [2, 4, 3]])
```

## 行列をindexで並び替え
```python
>>> a = np.array(([1,2,3,4], [5,6,7,8], [9,10,11,12]))
>>> b = np.array(([0,1,3,2], [1,3,2,0], [2,1,3,0]))
>>> a
array([[ 1,  2,  3,  4],
       [ 5,  6,  7,  8],
       [ 9, 10, 11, 12]])
>>> b
array([[0, 1, 3, 2],
       [1, 3, 2, 0],
       [2, 1, 3, 0]])
```
`a`の行列を、`b`に従って並べ替えたい。手で書くなら、
```python
>>> a[ np.array(([0, 1, 2]))[:, np.newaxis], np.array(([0,1,3,2], [1,3,2,0], [2,1,3,0]))]
array([[ 1,  2,  4,  3],
       [ 6,  8,  7,  5],
       [11, 10, 12,  9]])
```
これは、
```python
>>> a[ np.arange(a.shape[0])[:, np.newaxis], b]
array([[ 1,  2,  4,  3],
       [ 6,  8,  7,  5],
       [11, 10, 12,  9]])
```
 
## vectorを繰り返してmatrixにする
```python
>>> test = np.array([1,2,3,4,5])
>>> np.tile(test, 3).reshape(3,5)
array([[1, 2, 3, 4, 5],
       [1, 2, 3, 4, 5],
       [1, 2, 3, 4, 5]])
```

## Sparse matrix
```python
from scipy import sparse
sparse.csr_matrix(np.array(A))
sparse.csc_matrix(np.array(A))
```
* `csr_matrix`は行を取り出す操作、`csc_matrix`は列を取り出す操作が高速である
* 同じ型同士の和・積は高速である。つまり`csr_matrix`同士 or `csc_matrix`同士の和・積にすべき
* `csr_matrix`, `csc_matrix`は転置行列を取ると型が移り合う。Ex. `csr_matrix`の転置をとると`csc_matrix`

## Save
### Save to text
```python
header = ",".join([ "Dim"+str(i) for i in range(self.ndim)])
np.savetxt(file_path, np_object, header=header, fmt="%0.9f", delimiter=',', comments='')
```

## reshape
### Change Dimension
```
> train_set_x_orig.shape
(209, 64, 64, 3)
> train_set_x_orig.shape[0]
209
> (train_set_x_orig.reshape(train_set_x_orig.shape[0], -1)).shape
(209, 12288)
> (train_set_x_orig.reshape(train_set_x_orig.shape[0], -1).T).shape
(12288, 209)
```

## einsum
### Basic
```
np.einsum('今ある足'->'残したい足')
```

```
> a = np.arange(9).reshape(3,3)
array(
[[0, 1, 2],
[3, 4, 5],
[6, 7, 8]])

> np.einsum("ii",a)  # add diagonal elements
12
> np.einsum("ii->i",a)  # leave diagonal elements
array([0, 4, 8])
> np.einsum("ij->j",a)  # add column wise
array([ 9, 12, 15])

> np.einsum('ij, ij->i', a, b)  # row-wise product of two matrices
```
