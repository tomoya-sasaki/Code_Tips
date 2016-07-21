# Apply Family

## Table of Contents
1. [データフレームの一列だけにapply](#データフレームの一列だけにapply)

##　データフレームの一列だけにapply
`enrollment`という列の各要素に対して、別のところで定義した`function(x)`を適用している
```r
apply(data_b["enrollment"], 1, function)
```
