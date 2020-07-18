# pkgdown and usethis

## Build Site
```
pkgdown::build_site("Path to the folder")
```
You also have `build_reference()`, `build_articles()`, `build_article("pkgdown_files/NAME_WITHOUT_EXTENSION")` and so on.

Note:
When you use Terminal, open R after you move to the folder that has the package you want to build.
```
$ cd PATH
$ R
> pkgdown::build_site()
```
If it takes time, try `pkgdown::build_site(install = F)`.

## Badge
Create `README.Rmd`. Run `use_cran_badge()` and copy & paste. Use `badgecreatr` package for more.

## Articles
If yoy do not want to include articles in a package, put the in a subfolder of `vignettes`.

```rmd
---
title: "keyATM Basic"
output: 
  html_document:
    toc: true
---
```

## References
```r
pkgdown::template_reference()
```
and add the output to `.yml`.

