# devtools
* [R packages](https://r-pkgs.org/) by Hadley Wickham and Jennifer Bryan

## Table of Contents
1. [Setup Packages](#setup-packages)
2. [Workflow](#workflow)
3. [Install Packages](#install-packages)
4. [Document](#document)
5. [DESCRIPTION](#description)
6. [C++](#c)
7. [Vignette](#vignette)
8. [roxygen](#roxygen)
9. [data](#data)
10. [Submission](#submission)
11. [Travis](#travis)

## Errors
1. [Install error](#install-error)
2. [DLL error](#dll-error)
3. [Function error](#function-error)

## Setup Packages
### Create
It seems we need to use [`usethis`](https://usethis.r-lib.org/)..

```r
# New
usethis::create_package("path/to/package/testpackage")
usethis::use_roxygen_md()

# Old
devtools::create("path/to/package/testpackage")
```

### Add a first function
Add R function in `R/` folder, then `devtools::load_all()` to load the function.

## Workflow
Recommended workflow ([Reference](http://r-pkgs.had.co.nz/namespace.html#namespace-workflow)):
1. Add roxygen comments to your .R files.
2. Run `devtools::document()` (or press Ctrl/Cmd + Shift + D in RStudio) to convert roxygen comments to .Rd files.
3. Look at NAMESPACE and run tests to check that the specification is correct.
4. Rinse and repeat until the correct functions are exported.

### When you edit code
```r
# Option 1
devtools::load_all() # fine but not recommended (maybe fine for checking)

# Option 2 (probably you need to restart R anyway)
devtools::build()
devtools::install()
devtools::document()
library(mypackage)

# Option 3 (better?)
setwd(package_folder)
devtools::document() ; devtools::install() ; library(mypackage)

# You might want to check
devtools::check()
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

## Install Packages
[Reference](http://r-pkgs.had.co.nz/package.html#package)
```r
setwd("") # change directory to the package folder
devtools::build() ; devtools::install() # same as install from source
devtools::load_all() # In memory packages / use this for reloading
```

Another way might be:
```r
setwd(package_folder)
devtools::document() ; devtools::install() ; library(mypackage)
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
> It’s common for packages to be listed in Imports in DESCRIPTION, but not in NAMESPACE. In fact, this is what I recommend: list the package in DESCRIPTION so that it’s installed, then always refer to it explicitly with pkg::fun(). Unless there is a strong reason not to, it’s better to be explicit. It’s a little more work to write, but a lot easier to read when you come back to the code in the future. ([Reference](http://r-pkgs.had.co.nz/namespace.html#imports))

### Add dependencies
```r
devtools::use_package("tidyverse")
```

### Use external package
```r
external_package::fun()
```

### Easy way to write
Use S4 instead of writing `library` ([reference](http://r-pkgs.had.co.nz/namespace.html#imports))
```r
#' @import tidyverse readr
NULL
```

## C++
[Reference](http://r-pkgs.had.co.nz/src.html)

```r
# New
usethis::use_rcpp()

# Old
devtools::use_rcpp()
```
In `DESCRIPTION`,
```txt
LinkingTo: Rcpp, BH, RcppEigen
SystemRequirements: C++11
```

## Vignette
[Reference](http://r-pkgs.had.co.nz/vignettes.html)
```r
devtools::use_vignette("Test_EstimateAlpha") # Initialize vignette
devtools::build_vignettes()
```

## roxygen

To compile `.Rd` files locally, use `R CMD Rd2pdf main.Rd`.

### Function
```r
#' Initialize a model
#'
#' This function creates a list of word indexes \code{W}.
#'
#' @param dict a quanteda dictionary
#'
#' @return A list containing \describe{
#'         \item{W}{a list of vectors of word}
#'         }.
#' @import ggplot2
#' @importFrom hashmap hashmap
#' @export
model <- function(dict){
 [...]
}
```
`#' @return ggplot2 object ` would suffice in some cases.

### Class
```r
#' A Reference Class to ClassA
#'
#' @name ClassA
#' @docType class
#'
#' @section Fields:
#'  \describe{
#'    \item{\code{data}}{ data in tidytext format}
#'    \item{\code{words}}{ a vector}
#'  }
#'
#' @section Contains:
#' NULL
#'
#' @section Methods:
#'  \describe{
#'    \item{\code{initialize}}{ Constructor}
#'    \item{\code{top_words(n_show=10)}}{ show top words}
#'  }
#'
#' @importFrom tidytext tidy 
#' @import ggplot2 
#' @export ClassA
#' @exportClass ClassA
ClassA <- setRefClass(
  Class = "ClassA",
  [...]
)
```
If you want to use the class in other functions of the package, you need to add `#' @import methods` in the roxygen of the functions.

### namespace
[Reference](https://cran.r-project.org/web/packages/roxygen2/vignettes/namespace.html)


## data
```r
usethis::use_data(data_to_store, internal = F)
```

## Submission

### Checks
It's better to submit the package to winbuild.
```
devtools::check()
devtools::build_win()
```

### Passing CRAN checks

#### tidyverse is tricky
Add `@importFrom rlang .data` and write `.data` specifically, e.g., `dplyr::group_by(.data$Topic)`.


#### remove pkgdown files
Minimally, we need `data`, `man`, `R`, `src`, `DESCRIPTION`, and `NAMESPACE`. Probably we can remove `.so`, and `.o` as well. Write `.Rbuildignore` appropriately.

#### DESCRIPTION
Remove `VignetteBuilder: knitr` if you don't have vignettes.

#### Checking on your computer
```
$ R CMD build PackageName
$ R CMD check --as-cran PackageName_0.1.0.tar.gz
```


## Travis
If you encounter an error, running it again or deleting cache might help.

# Errors

## Install error
### Issue
When you are installing your package with `devtools::install()`,
```
Error: package or namespace load failed for 'topicdict' in dyn.load(file, DLLpath = DLLpath, ...):
 unable to load shared object '/usr/local/lib/R/3.5/site-library/topicdict/libs/topicdict.so':
  dlopen(/usr/local/lib/R/3.5/site-library/topicdict/libs/topicdict.so, 6): Symbol not found: __topicdict_topicdict_train_cov
  Referenced from: /usr/local/lib/R/3.5/site-library/topicdict/libs/topicdict.so
  Expected in: flat namespace
 in /usr/local/lib/R/3.5/site-library/topicdict/libs/topicdict.so
Error: loading failed
Execution halted
ERROR: loading failed
* removing '/usr/local/lib/R/3.5/site-library/topicdict'
Error: Command failed (1)
```

### Solution
1. Remove `RcppExports.cpp` and `RcppExports.R`, then run `Rcpp::compileAttributes()` before `devtools::install()`.
2. Check you did not define `inline` functions in a header file. (not 100% sure we need this)
3. After the all process and reinstalling, you might need to restart R session.
4. Make sure you write all virtual functions both in `.h` and `.cpp` when you use inheritance (継承を使うとき、`virtual`で定義している関数はヘッダーと本体に書かないと上のエラーになる)

## DLL Error
### Issue
```
Error in getDLLRegisteredRoutines.DLLInfo(dll, addNames = FALSE) : 
  must specify DLL via a “DLLInfo” object. See getLoadedDLLs()
```

### Solution
```
pkgbuild::compile_dll()
devtools::document()
```

## Function error
### Issue
Can't call Rcpp functions.
```
"FUNCTION" not available for .Call() for package “MYPACKAGE”
```

### Solution
Update `MYPACKAGE-package.R` ([Reference](https://stackoverflow.com/a/30469135/4357279)).
```
#' @useDynLib MYPACKAGE
#' @importFrom Rcpp sourceCpp
NULL

.onUnload <- function(libpath) {
  library.dynam.unload("MYPACKAGE", libpath)
}
```
