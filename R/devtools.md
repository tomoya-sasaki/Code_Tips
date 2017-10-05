# devtools
[Official Reference](http://r-pkgs.had.co.nz/)

## Table of Contents
1. [Setup Packages](#setup-packages)
2. [Install Packages](#install-packages)


## Setup Packages
### Create
```r
devtools::create("path/to/package/testpackage")
```

### Add a first function
Add R function in `R/` folder, then `load_all()` to load the function.

## Install Packages
[Reference](http://r-pkgs.had.co.nz/package.html#package)
```r
setwd("") # change directory to the package folder
devtools::install() # same as install from source
devtools::load_all() # In memory packages / use this for reload
```
