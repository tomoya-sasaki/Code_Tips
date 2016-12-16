# xtable

## Table of Contents
1. [Basics](#basics)

## Basics
```r
write(as.character(print(xtable(table1, caption="Title"), 
  include.rownames = FALSE, caption.placement = "top", table.placement="H")), 
  file="LatexOutput/table.tex")
```
