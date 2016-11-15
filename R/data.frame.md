# DataFrame

## Table of Contents
1. [rbindの注意](#rbindの注意)
2. [足りない行を追加する](#足りない行を追加する)

## rbindの注意
そのまますると、column名に沿って結合されてしまうので注意。<br>
回避するには、
```r
rbind( df , setNames(rev(df) ,names(df)))
```
`rev()`で逆順になる

## 足りない行を追加する
[Reference](http://stackoverflow.com/questions/9996452/r-find-and-add-missing-non-existing-rows-in-time-related-data-frame)
```r
vals <- expand.grid(a = unique(data$a), id= unique(data$id))
data <- merge(data,vals,all = TRUE)
```
