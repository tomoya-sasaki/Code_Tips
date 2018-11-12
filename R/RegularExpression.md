# Regular Expression in R

## Table of Contents
1. [Patternm match](#pattern-match)

## Pattern Match
```r
rcv %>%
   filter(grepl("Archer", name, ignore.case=T))
```
If you use `grep` it retuns index.
