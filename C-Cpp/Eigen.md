# Eigen
a template library for linear algebra

Matrixのある列とVectorの足し算には注意！つねに縦横を意識すること --> [行列の要素ごとの演算](#行列の要素ごとの演算)
```cpp
MatrixXd n_dk;
VectorXd alpha;
VectorXd ndk_ak;
ndk_ak = n_dk.row(d) + alpha.transpose(); // We need .transpose()
```

## Table of Contents
Usage:

1. [Install](#install)
2. [Examples](#examples)
3. [Read Files](#read-files)
4. [Matrix](#matrix)
5. [Count Elements](#count-elements)
6. [行列要素へのアクセス](#行列要素へのアクセス)
	* [exp](#exp)
7. [行列の要素ごとの演算](#行列の要素ごとの演算)
8. [数値を毎回ランダムに](#数値を毎回ランダムに)
9. [行列でのvalueの使い方](#行列でのvalueの使い方)
10. [logdetの計算](#logdetの計算)
11. [大きな行列の逆行列](#大きな行列の逆行列)
12. [Matrixのある行をvectorで置き換え](#matrixのある行をvectorで置き換え)
13. [列ごとの計算](#列ごとの計算)
14. [行列の列ごとにvectorを足していく](#行列の列ごとにvectorを足していく)
15. [コンマ区切りで出力](#コンマ区切りで出力)
16. [Passing values](#passing-values)
17. [Map](#map)
18. [Get Index](#get-index)
19. [Sparse Matrix](#sparse-matrix)


Other Material: 
* [Links](#links)
* [Sample Code](#sample-code)

## Install
1. Expand zip file and put a folder named `Eigen` into `usr/local/include` (or `/usr/include` if you are using older Mac).
2. If you want to use Eigne in a specific folder, change `#include <Eigen/Dense>` to `#include "Eigen/Dense"`.

## Examples
* VectorとMatrixを作るいくつかの例
```cpp
VectorXd v = VectorXd::Random(5);
MatrixXd A2 = MatrixXd::Ones(n,n);
MatrixXd A = MatrixXd::Random(3,4);
```


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

## Read Files
こちらの[Gist](https://gist.github.com/Shusei-E/f632c9a7b7e197cf50709915d210f7c8)を参考に。

## Matrix
* Select specific row and column ([Reference](https://eigen.tuxfamily.org/dox/group__TutorialBlockOperations.html))
```cpp
// ith row
matrix.row(i); // seems to return a horizontal vector
// jth column
matrix.col(j);

// Get row and column number
std::cout << M.rows() << std::endl;
std::cout << M.rows() << std::endl;
```

## Count Elements
```cpp
x.size() // vector length
C.rows() // number of rows
C.cols() // number of columns
```

```cpp
MatrixXd A = MatrixXd::Identity(3,3);
cout << "Does A(i,j)<1.0 hold for all elements? : " << (A.array()<1.0).all() << endl;
cout << "Does A(i,j)<2.0 hold for all elements? : " << (A.array()<2.0).all() << endl;
cout << "Does A(i,j)<1.0 hold for any elements? : " << (A.array()<1.0).any() << endl;
cout << "How many elements do A(i,j)<1.0 hold?  : " << (A.array()<1.0).count() << endl;
```

## 行列要素へのアクセス
The simplest way is to specify row and colum, `Matrix(row, column)`. The way to access a single column is `.col(i)`, and similarly for row, its `.row(i)` (`.row()` seems to return a horizontal vector). Also of interest is `.block<>`.

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
    cout << "A(0,0) = " << A(0,0) << endl;; // cannot be used for sparse matrix
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

## 行列の要素ごとの演算

### array
`.array()`
```cpp
x_bar.array() = x_bar.array() / n_k.array();
```
同じ長さのvectorを足すとかだったら、`.array()`は要らないけど、+スカラーなら
```cpp
MatrixXd A = MatrixXd::Identity(3,3);
MatrixXd B = A.array() + 1.0;
```
とする。
細かな例は、[こちら](https://github.com/Shusei-E/Code_Tips/blob/master/C-Cpp/Examples/Eigen_calc1.cpp)を参考にすること。

#### exp
```cpp
MatrixXd exp_A = A.array().exp();
```

### MatrixとVectorの足し算
```cpp
MatrixXd n_dk;
VectorXd input_alpha;

ndk_ak = n_dk.row(d).transpose() + input_alpha;
```
ここでtransposeをしないと値がおかしくなるので注意！！行列の`.row()`は横ベクトルなのに、ベクトルが縦ベクトルだからみたい。transposeをしなくてもエラーは出ないので注意。(これは.row()と足し算を一緒にする場合？`n_dk.row(d)`を一旦別の変数に保管したらどうなるのか)。

## 数値を毎回ランダムに
```cpp
double rnorm(double mean, double sd){
	// random generation for the normal distribution
	random_device seed_gen; // http://cpprefjp.github.io/reference/random.html
	mt19937 engine(seed_gen());
	normal_distribution<double> distribution(mean, sd);

	return distribution(engine);
}
```
Eigenには、`VectorXd n_k = VectorXd::Random(K);`みたいなものも用意されている。`std::srand((unsigned int) time(0));`とかと一緒に使ってseedを変えないといつも結果が同じになる。


## 行列でのvalueの使い方
`double k = b.transpose()*Z.inverse()*b;`とするとエラーが出るので、`double k = (b.transpose()*Z.inverse()*b)(0);`とするか、`double k = (b.transpose()*Z.inverse()*b).value()`とする。([参考](http://stackoverflow.com/questions/25107120/cannot-convert-from-const-eigengeneralproductlhs-rhs-producttype-to-doubl))

## logdetの計算
```cpp
Matrix3d A4;
A4 << 1.0, 0.8, 0.2,
      4.0, 1.0, 0.0,
      0.0, 9.0, 1.0;
cout << log(A4.determinant()) << endl;
```

## 大きな行列の逆行列
```cpp
Matrix3d A;
A << 3.0, 1.0, 2.0,
     1.0, 1.0, 1.0,
     9.0, -1.0, 5.0;

cout << A.trace() << endl;

std::cout << "[[[[[inverse_matrix]]]]]" << std::endl;
FullPivLU< MatrixXd > lu(A);
 
MatrixXd B=lu.inverse(); // B is inverse
std::cout << "A^{-1}" << std::endl << B << std::endl << std::endl;
```

## Matrixのある行をvectorで置き換え
```cpp
Matrix2d a;
a << 1,2,
     3,4;
Vector2d b(10,10);
a.row(0) = b;

>> a
10, 10
 3,  4
```
場合によっては`.transpose()`しないと上手くいかないこともあった。

## 列ごとの計算
[Reference](https://eigen.tuxfamily.org/dox/group__TutorialReductionsVisitorsBroadcasting.html)
```cpp
matrix.colwise().sum()
matrix.colwise().mean()
```

## 行列の列ごとにvectorを足していく
```cpp
MatrixXd test = MatrixXd::Ones(2,2);
Vector2d test2(30,2)
for(int i=0; i<2; ++i) test.row(i) = test.row(i) + test2.transpose();
cout << test << endl;

>>> 31, 3
    31, 3
```

## コンマ区切りで出力
[Reference](https://eigen.tuxfamily.org/dox/structEigen_1_1IOFormat.html)
```cpp
IOFormat CommaInitFmt(StreamPrecision, DontAlignCols, ",", ",", "", "", "", "");
cout << normX_solver.samples(5).rowwise().mean().transpose().format(CommaInitFmt) << "\n" << endl;

// -0.0252315,-0.0310973
// と出力される
```

## Passing values
[Reference: Passing Eigen objects by value to functions](https://eigen.tuxfamily.org/dox/group__TopicPassingByValue.html)

```cpp
// to function
void my_function(const Eigen::Vector2d& v);

// If you have a class having a Eigen object as member
struct Foo
{
  Eigen::Vector2d v;
};
void my_function(const Foo& v);
```

## Map
You can use c++ array as a Eigen object by mapping.

### Array to Eigen matrix
```cpp
#include <iostream>
#include <Eigen/Dense>
#include <vector>
using namespace Eigen;
using namespace std;

// Original code on Stackoverflow
MatrixXd ConvertToEigenMatrix(std::vector<std::vector<double>> data)
{
    MatrixXd eMatrix(data.size(), data[0].size());
    for (int i = 0; i < data.size(); ++i)
      eMatrix.row(i) = VectorXd::Map(&data[i][0], data[0].size());
    return eMatrix;
}

// My function
MatrixXd Array2DToEigenMatrix(double **data, int row, int col)
{
  MatrixXd Emat(row, col);
  for(int r=0; r<row; r++){
    Emat.row(r) = VectorXd::Map(&(data[r][0]), col);
  }

  return Emat;
}

MatrixXd Array3DToEigenMatrix(double ***data, int row=0, int col=0, int axis=0)
{
  // axis: which dimension you slice the array
  // [axis][row][col]
  
  double **array;
  array = new double *[row];
  for(int r=0; r<row; r++){
    array[r] = new double[col];
    
    for(int c=0; c<col; c++){
      array[r][c] = data[axis][r][c];
    }

  }

  return Array2DToEigenMatrix(array, row, col);

}

int main()
{
  double **array;
  array = new double *[3];
  for(int r = 0; r<3; r++){
    array[r] = new double[3];
    for(int c=0; c<3; c++){
      array[r][c] = 1.5;
    }
  }

  cout << Array2DToEigenMatrix(array, 3, 3) << endl;

 double ***array2;
 array2 = new double**[3];
 for(int i=0; i<3; i++){
   array2[i] = new double*[4];

   for(int j=0; j < 4; j++){
     array2[i][j] = new double[2];

     for(int l=0; l<2; l++){
       array2[i][j][l] = (double)i + 0.1;
     }
   }
 }

  cout << Array3DToEigenMatrix(array2, 4, 2, 0) << endl;

  return 0;
}
```

## Get Index
Visitors:
```cpp
#include <iostream>
#include <Eigen/Dense>
using namespace Eigen;
using namespace std;

int main()
{

  VectorXd a(5);
  VectorXd::Index index;
  a<<1.1, 2.2, 0.8, 2.4, 1.3;

  cout << a.maxCoeff(&index) << endl;
  cout << index << endl;

  return 0;
}
```

## Sparse Matrix
We have `SparseVector` as well.

### Basic Usage
```cpp
#include <iostream>
#include <Eigen/dense>
#include <Eigen/Sparse>
using namespace std;
using namespace Eigen;


int main(){

  Eigen::SparseMatrix<double> spmat;

  MatrixXd mat;

  // Insert in spmat
  typedef Eigen::Triplet<double> T;
  vector<T> tripletList;

  for(int i=0; i<mat.rows(); i++){
    tripletList.push_back(T(i,i,i));  
  }
  spmat.resize(5,5);  // define size
  spmat.setFromTriplets(tripletList.begin(), tripletList.end());


  cout << spmat << endl;
  
  cout << spmat.coeffRef(3,3) << endl;
  spmat.coeffRef(3,3) = 6;
  cout << spmat.coeffRef(3,3) << endl;
  

  return 0;
}
```

### Use in class
[Reference](https://eigen.tuxfamily.org/dox/group__SparseQuickRefPage.html)

`insert()` assumes that the element does not already exist; otherwise, use `coeffRef()`.
```cpp
class Test{
public:
  SparseMatrix<size_t, RowMajor> sp1;
  
  Test(){
    sp1 = SparseMatrix<size_t, RowMajor> (10,10);
    // Insert a new element; 
    sp1.insert(i, j) = 1;  
    // Update the value v_ij
    sp1.coeffRef(i,j) = 2;
    
    cout << sp1(1,1) << endl;
  }
}
```


------------------------------------------------------------------------

## Links
* [シリアライズ](http://qiita.com/Soramichi/items/611db0551d7df28d5233)

## Sample Code
* [Data Generation with fixed variance](https://gist.github.com/Shusei-E/adbfd85aa67d9ac9ef6e122142c4239d)

