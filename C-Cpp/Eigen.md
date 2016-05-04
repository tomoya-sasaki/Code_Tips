# Eigen
a template library for linear algebra

## Table of Contents
1. [Install](#install)
2. [Examples](#examples)
3. [Read Files](#read-files)

* [Links](#links)
* [Sample Code](#sample-code)

### Install
1. Expand zip file and put a folder named `Eigen` into `/usr/include`
2. If you want to use Eigne in a specific folder, change `#include <Eigen/Dense>` to `#include "Eigen/Dense"`.

### Examples
* 行列のconstant [参考](http://eigen.tuxfamily.org/dox/GettingStarted.html)
```cpp
MatrixXd::Constant(3,3,1.2)
Matrix3d::Constant(1.2) // matrices of a fixed size
```
3×3行列で要素が1.2

* 要素の選択
```cpp
Vector3d mu(-0.8, 0.0, 2.0); //
cout << "Output: " << mu(1) << endl;
> Output: 0
```

### Read Files
こちらの[Gist](https://gist.github.com/Shusei-E/f632c9a7b7e197cf50709915d210f7c8)を参考に。

## Links
* [シリアライズ](http://qiita.com/Soramichi/items/611db0551d7df28d5233)

## Sample Code
* [Data Generation with fixed variance](https://gist.github.com/Shusei-E/adbfd85aa67d9ac9ef6e122142c4239d)
