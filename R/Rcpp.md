# Rcpp

## Table of Contents
1. [Basics](#basics)

## Basics
test.cpp
```cpp
#include <Rcpp.h>
#include <Eigen/Dense>
using namespace Rcpp;
using namespace Eigen;

// Use c++11 and link functions to R
// [[Rcpp::plugins("cpp11")]]
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
