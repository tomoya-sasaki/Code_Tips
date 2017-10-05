# devtools
[Official Reference](http://r-pkgs.had.co.nz/)

## Table of Contents
1. [Setup Packages](#setup-packages)
2. [Install Packages](#install-packages)
3. [Document](#document)


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
multiply <- function(x, y) {
  res <- x * y
  return(res)
}
```
