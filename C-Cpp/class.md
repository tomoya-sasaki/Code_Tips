# Class

1. [General](#general)
2. [Rcpp](#rcpp)

## General
It is related to [headfer files](https://github.com/Shusei-E/Code_Tips/blob/master/C-Cpp/HeaderFiles.md)

## Rcpp
### Example 1
```cpp
// main.cpp
#include <Rcpp.h>
#include <RcppEigen.h>
#include <iostream>
#include "lda_cov.h"

// [[Rcpp::plugins(cpp11)]]
// [[Rcpp::depends(RcppEigen)]]

using namespace Eigen;
using namespace Rcpp;
using namespace std;

//' Run the model
//'
//' @param model
//' @param iter Required number of iterations
//' @param output_per
//'
//' @export
// [[Rcpp::export]]
List lda_cov(List model, int iter=0, int output_iter=10)
{
  LDACOV ldacov(model, iter, output_iter);
  return model;
}
```

```cpp
// lda_cov.h
#ifndef __LDA_COV__INCLUDED__
#define __LDA_COV__INCLUDED__

#include <Rcpp.h>
#include <RcppEigen.h>

class LDACOV
{
  private:
    int test;
  
  public:
    Rcpp::List W, Z; // R objects should be public (maybe)
    LDACOV(Rcpp::List model, const int iter, const int output_per);
    void initialize();
};
#endif
```

```cpp
// lda_cov.cpp
#include "lda_cov.h"

using namespace Eigen;
using namespace Rcpp;
using namespace std;

LDACOV::LDACOV(List model, const int iter, const int output_iter)
{
  cout << "test" << endl;
  initialize();
}

void LDACOV::initialize()
{
  cout << "Initialize" << endl;
}
```
