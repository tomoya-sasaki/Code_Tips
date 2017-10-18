# Rcpp
[Rcpp for everyone](https://teuder.github.io/rcpp4everyone_en/), [ja](https://teuder.github.io/rcpp4everyone_ja/)

## Table of Contents
1. [Basics](#basics)
2. [Matrix](#matrix)

## Basics
test.cpp (You need add `// [[Rcpp::export]]` before the function you want to use in R)
```cpp
// [[Rcpp::depends(BH)]]
#include <Rcpp.h>
#include <RcppEigen.h>
using namespace std;
using namespace Rcpp;
using namespace Eigen;

// Use c++11 and link functions to R
// [[Rcpp::plugins("cpp11")]]
// [[Rcpp::depends("RcppEigen")]]

// [[Rcpp::export]]
double rcpp_sum(NumericVector v){
    double sum = 0;
    for(int i=0; i<v.length(); ++i){
        sum += v[i];
    }
    return(sum);
}
```
test.R
```r
library(Rcpp)
sourceCpp('test.cpp')
rcpp_sum(1:10)
```

### Boost
`install.packages("BH")`. You can use Boost functions that require header files only. In C++, you need to add `// [[Rcpp::depends("BH")]]`.

## Matrix
### Basic
Read `matrix` in R for Rcpp using Eigen:
```cpp
void cossim_vec(Map<MatrixXd> dtm,
      MappedSparseMatrix<double> dtm2)
{

}
```

### Reference and Copy
[Reference](https://sites.google.com/site/rcppintroduction/rcpp-shii-fang#TOC-Matrix-)
```cpp
NumericMatrix A;
NumericMatrix B(m,n);

A = B; // reference
A = clone(B); // copy
```
