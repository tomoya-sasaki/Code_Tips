# DataFrame

## Table of Contents
1. [rbindの注意](#rbindの注意)
2. [足りない行を追加する](#足りない行を追加する)
3. [不要な列をdropする](#不要な列をdropする)
4. [wideとlongの変換](#wideとlongの変換)
5. [特定の文字列を含む列を取り出す](#特定の文字列を含む列を取り出す)

## rbindの注意
そのまますると、column名に沿って結合されてしまうので注意。  
回避するには、
```r
rbind(df, setNames(rev(df) ,names(df)))
```
`rev()`で逆順になる

## 足りない行を追加する
[Reference](http://stackoverflow.com/questions/9996452/r-find-and-add-missing-non-existing-rows-in-time-related-data-frame)
```r
vals <- expand.grid(year = unique(data$year), id= unique(data$id))
data <- merge(data,vals,all = TRUE)
```
## 不要な列をdropする
```r
df <- subset(df, select = -c(a,c))
```

### wideとlongの変換
`reshape`で、
```r
data <- reshape(temp, timevar="year", v.names=c("iv7","iv8","iv9"), idvar="id", direction="wide")
```
のようにすれば良いが、あるidに対して欠けているyearがあったりすると結果が得られないので、[足りない行を追加する](#足りない行を追加する)を参照。

### 特定の文字列を含む列を取り出す
```r
colnames(data[,grep("age_.",colnames(data))])
```
