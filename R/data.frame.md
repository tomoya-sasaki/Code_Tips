# DataFrame

### rbindの注意
そのまますると、column名に沿って結合されてしまうので注意。<br>
回避するには、
```r
rbind( df , setNames(rev(df) ,names(df)))
```
`rev()`で逆順になる
