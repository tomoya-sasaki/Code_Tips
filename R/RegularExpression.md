# Regular Expression in R

## Table of Contents
1. [Patternm match](#pattern-match)
2. [digit](#digit)

## Pattern Match
```r
rcv %>%
   filter(grepl("Archer", name, ignore.case=T))
```
If you use `grep` it retuns index.

## digit
```r
grep(pattern="[[:digit:]]", x=vec)
```
[Reference](https://stackoverflow.com/a/11525461/4357279)
