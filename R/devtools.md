# devtools
[Official Reference](http://r-pkgs.had.co.nz/)

## Table of Contents
1. [Setup Packages](#setup-packages)
2. [Install Packages](#install-packages)
3. [Document](#document)
4. [DESCRIPTION](#description)
5. [C++](#c++)
6. [Vignette](#vignette)


## Setup Packages
### Create
```r
devtools::create("path/to/package/testpackage")
```

### Add a first function
Add R function in `R/` folder, then `devtools::load_all()` to load the function.

## Install Packages
[Reference](http://r-pkgs.had.co.nz/package.html#package)
```r
setwd("") # change directory to the package folder
devtools::install() # same as install from source
devtools::load_all() # In memory packages / use this for reloading
```

## Document
Stored in `man` folder. Write following a documentation format and run `devtools::document()`.
```r
#' Multiply two numbers.
#' 
#' @param x A number.
#' @param y A number.
#' @return The multiplication of \code{x} and \code{y}.
#' @examples
#' multiply(1, 1)
#' multiply(10, 1)
#'
#' @export
multiply <- function(x, y) {
  res <- x * y
  return(res)
}
```

## DESCRIPTION
### Add dependencies
```r
devtools::use_package("tidyverse")
```

### Use external package
```r
devtools::external_package::fun()
```

### Easy way to write
Use S4 instead of writing `library` ([reference](http://r-pkgs.had.co.nz/namespace.html#imports))
```r
#' @import tidyverse readr
NULL
```

## C++
[Reference](http://r-pkgs.had.co.nz/src.html)

## Setup
```r
devtools::use_rcpp()
```
In `DESCRIPTION`,
```txt
LinkingTo: Rcpp, BH, RcppEigen
SystemRequirements: C++11
```

### When you edit code
```r
# Option 1
devtools::load_all() # fine but not recommended

# Option 2 (probably you need to restart R anyway)
devtools::build()
devtools::install()
devtools::document()
library(mypackage)
```

### Create Document
```cpp
//' My function
//' 
//' @param x A single integer.
//' @examples
//' myfunc(1, 1)
//' myfunc(10, 1)
//' @export
// [[Rcpp::export]]
int myfunc(int x){
  return 0;
}
```

## Vignette
[Reference](http://r-pkgs.had.co.nz/vignettes.html)
```r
devtools::use_vignette("Test_EstimateAlpha") # Initialize vignette
devtools::build_vignettes()
```
