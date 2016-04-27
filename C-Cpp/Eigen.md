# Eigen
a template library for linear algebra

## Table of Contents
1. [Install](#install)
2. [Examples](#examples)


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

