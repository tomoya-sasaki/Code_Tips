# Apply Family

## Table of Contents
1. [データフレームの一列だけにapply](#データフレームの一列だけにapply)
2. [lapply](#lapply)

## データフレームの一列だけにapply
`enrollment`という列の各要素に対して、別のところで定義した`function(x)`を適用している
```r
apply(data_b["enrollment"], 1, function)
```
`data_b[c("enrollment", "age")]`とした場合、`x`には`data`の j 行ベクトルが代入される

## lapply
If you want to apply a function to a each elment of list, consider [`map`](https://github.com/Shusei-E/Code_Tips/blob/master/R/purrr.md#apply-a-function-to-a-list).

