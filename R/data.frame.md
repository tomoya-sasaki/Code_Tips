# DataFrame

## Table of Contents
1. [rbindの注意](#rbindの注意)
2. [足りない行を追加する](#足りない行を追加する)
3. [不要な列をdropする](#不要な列をdropする)
4. [wideとlongの変換](#wideとlongの変換)
5. [特定の文字列を含む列を取り出す](#特定の文字列を含む列を取り出す)
6. [特定の名前を含む列を除く](#特定の名前を含む列を除く)
7. [新しい列の追加](#新しい列の追加)
8. [list to df](#list-to-df)



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
Conditional drop:
```r
d<-d[!(d$A=="B" & d$E==0),]
```

## wideとlongの変換
`reshape`で、
```r
data <- reshape(temp, timevar="year", v.names=c("iv7","iv8","iv9"), idvar="id", direction="wide")
```
のようにすれば良いが、あるidに対して欠けているyearがあったりすると結果が得られないので、[足りない行を追加する](#足りない行を追加する)を参照。

## 特定の文字列を含む列を取り出す
```r
colnames(data[,grep("age_.",colnames(data))])
```
これを使って、regression用の変数を作る
```r
paste(colnames(data[,grep("age_.",colnames(data))]), collapse=" + ")
formula <- as.formula(paste("educ ~ ", paste(colnames(data[,grep("age_.",colnames(data))]), collapse=" + ")))
```

## 特定の名前を含む列を除く
```r
data <- data[,!(1:ncol(data) %in% grep('\\.y',names(data)))]
```

## 新しい列の追加
Use `transform()`. `transform(d, y=Value)`: データフレーム d に新たな列 y を追加する。
```r
N <- 40
s_Y <- 25

> head(d, 2)
   X KID        a        b
1 10   1 285.9306 9.499843
2 28   1 285.9306 9.499843
> nrow(d)
[1] 40

d <- transform(d, Y=rnorm(N, mean=a+b*X, sd=s_Y))
```

## List to df
```r
do.call(rbind.data.frame, your_list)

vote <- data.frame()
for (file in files){
  vote <- rbind(vote, read_csv(file))
}
```
