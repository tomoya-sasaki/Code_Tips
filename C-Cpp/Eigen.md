# Eigen
a template library for linear algebra

## Table of Contents
Usage:

1. [Install](#install)
2. [Examples](#examples)
3. [Read Files](#read-files)
4. [Matrix](#matrix)
5. [Count Elements](#count-elements)
6. [行列要素へのアクセス](#行列要素へのアクセス)
7. [行列の要素ごとの演算](#行列の要素ごとの演算)
8. [数値を毎回ランダムに](#数値を毎回ランダムに)


Other Material: 
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

* constant以外
K次元ベクトルを作る
```cpp
VectorXd n_k = VectorXd::Zero(K);

VectorXd n_k = VectorXd::Identity(K);  // 単位ベクトル(1, 0, 0)
VectorXd n_k = VectorXd::Ones(K);

// ランダムな値
// FIXME:std::rand()を使っている
VectorXd n_k = VectorXd::Random(K);
```

* 要素の選択
```cpp
Vector3d mu(-0.8, 0.0, 2.0); //
cout << "Output: " << mu(1) << endl;
> Output: 0
```

### Read Files
こちらの[Gist](https://gist.github.com/Shusei-E/f632c9a7b7e197cf50709915d210f7c8)を参考に。

### Matrix
* Select specific row and column ([Reference](https://eigen.tuxfamily.org/dox/group__TutorialBlockOperations.html))
```cpp
// ith row	
matrix.row(i);
// jth column
matrix.col(j);
```

### Count Elements
`.count()`

### 行列要素へのアクセス
```cpp
// http://goo.gl/eEk5sJ から取得したExample //
void Matrix_Element_Access_Test()
{
    /* 行列成分は [] でなく () 演算子でアクセス可能
     * これらの演算子は「配列添字の妥当性チェック」を行う
     * coeff(i,j) や coeffRef(i,j) で「添字チェックなし」の
     * アクセスが可能になる！
     */
    PRINT_FNC;
 
    MatrixXd A = MatrixXd::Identity(3,3);
    cout << "A(0,0) = " << A(0,0) << endl;;
    cout << "A.coeff(1,2) = " << A.coeff(1,2) << endl;
    cout << "A.coeffRef(1,2) = " << A.coeff(1,2) << endl;
 
    A.coeffRef(2,2) = 100;  // OK
    //A.coeff(2,2) = 100;  // NG
 
    cout << endl;
}
```
使用例:
```cpp
// count n_k
VectorXd n_k = VectorXd::Zero(K);
int c;
for(int ob=0; ob<num_observations; ob++){
	c = auxZ.row(ob).coeffRef(0);
	n_k[c] = n_k[c] + 1;
}
```

### 行列の要素ごとの演算
`.array()`
```cpp
x_bar.array() = x_bar.array() / n_k.array();
```

### 数値を毎回ランダムに
```cpp
double rnorm(double mean, double sd){
	// random generation for the normal distribution
	random_device seed_gen; // http://cpprefjp.github.io/reference/random.html
	mt19937 engine(seed_gen());
	normal_distribution<double> distribution(mean, sd);

	return distribution(engine);
}
```


## Links
* [シリアライズ](http://qiita.com/Soramichi/items/611db0551d7df28d5233)

## Sample Code
* [Data Generation with fixed variance](https://gist.github.com/Shusei-E/adbfd85aa67d9ac9ef6e122142c4239d)