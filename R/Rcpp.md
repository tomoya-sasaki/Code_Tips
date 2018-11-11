# Rcpp

* [Rcpp for everyone](https://teuder.github.io/rcpp4everyone_en/), [ja](https://teuder.github.io/rcpp4everyone_ja/)
* [Rcpp Gallery](http://gallery.rcpp.org/)
* It's better not to use `push_back()` for R-type vector in C++.

## Table of Contents
1. [Basics](#basics)
2. [Matrix](#matrix)
3. [RcppEigen](#rcppeigen)
4. [Debug](#debug)
5. [Class](#class)

## Errors
Check [devtools erros](https://github.com/Shusei-E/Code_Tips/blob/master/R/devtools.md#errors-1) as well!

1. [gfortran](#gfortran)
2. [could not find function error](#could-not-find-function-error)
3. [Error occurs even if you fixed bugs](#error-occurs-even-if-you-fixed-bugs)

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


## RcppEigen
### Convert between R and Cpp
```cpp
// Rcpp::NumericMatrix RMatrix to Eigen::MatrixXd EigenMatrix
Eigen::Map<Eigen::MatrixXd> EigenMatrix(Rcpp::as<Eigen::Map<Eigen::MatrixXd> >(RMatrix));

// This also works (difference from the above?)
NumericMatrix RMatrix = model["RMatrix"]; // model is a List object
MatrixXd CppMAtrix = Rcpp::as<Eigen::MatrixXd>(RMatrix);

// Eigen::MatrixXd and std::vector to Rcpp object
Rcpp::NumericMatrix A = Rcpp::wrap(AA);

// A column `x` in DataFrame A to std::vector xx
std::vector<double> xx = Rcpp::as<std::vector<double> >(A["x"]);
```

## Debug
### with lldb
[Reference](http://kevinushey.github.io/blog/2015/04/13/debugging-with-lldb/)

```terminal
$ R -d lldb
< ... >
(lldb) run
```

### with valgrind
```terminal
$ R -d valgrind
```

## Class
[Check here](https://github.com/Shusei-E/Code_Tips/blob/master/C-Cpp/class.md)

# Errors

## gfortran
### Work
1:
```terminal
$ which gfortran
/usr/local/bin/gfortran
```
2: Edit the file `Makevars` (check below section to see how to make `Makevars`
```txt
FLIBS = -L/usr/local/bin/gfortran
```

### Does not work
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

## could not find function error
After `remove.packages()`, try `devtools::install() ; devtools::document()` again. It seems `NAMESPACE` does not contain the function you want to use. I am not sure what would be the best solution (probably run `devtools::build()` first? It seems there is no need to fully run `build`).

## Error occurs even if you fixed bugs
Try delete `*.o` and `*.so` files and recomplie all.
