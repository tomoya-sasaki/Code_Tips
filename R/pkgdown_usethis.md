# pkgdown and usethis

## Build Site
```
pkgdown::build_site("Path to the folder")
```

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

