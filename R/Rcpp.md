# Rcpp

## Table of Contents
1. [Basics](#basics)
2. [RcppEigen](#rcppeigen)

## Basics
test.cpp
```cpp
#include <Rcpp.h>
#include <RcppEigen.h>
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

## RcppEigen
Read `matrix` in R for Rcpp:
```cpp
void cossim_vec(Map<MatrixXd> dtm){
}
```
