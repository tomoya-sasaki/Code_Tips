# Rcpp
[Rcpp for everyone](https://teuder.github.io/rcpp4everyone_en/), [ja](https://teuder.github.io/rcpp4everyone_ja/)

## Table of Contents
1. [Basics](#basics)
2. [Matrix](#matrix)
3. [Errors](#errors)
4. [Debug](#debug)

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

## Errors

### gfortran

#### Work
1:
```terminal
$ which gfortran
/usr/local/bin/gfortran
```
2: Edit the file `Makevars` (check below section to see how to make `Makevars`
```txt
FLIBS = -L/usr/local/bin/gfortran
```


#### Does not work
1: Make a file
```terminal
$ mkdir ~/.R
$ cat << EOF >> ~/.R/Makevars
FLIBS=-L/usr/local/gfortran/lib/gcc/x86_64-apple-darwin16/6.3.0 -L/usr/local/gfortran/lib -lgfortran -lquadmath -lm
EOF
```

2: Edit the file `Makevars`
```txt
FLIBS = ‘gfortran -print-search-dirs | grep ^libraries: | sed 's|libraries: =||' | sed 's|:| -L|g' | sed 's|^|-L|’’
```

Official reference [2.16.2](http://dirk.eddelbuettel.com/code/rcpp/Rcpp-FAQ.pdf) and [this blog](http://thecoatlessprofessor.com/programming/rcpp-rcpparmadillo-and-os-x-mavericks-lgfortran-and-lquadmath-error/).

## Debug
### with LLDB
[Reference](http://kevinushey.github.io/blog/2015/04/13/debugging-with-lldb/)
