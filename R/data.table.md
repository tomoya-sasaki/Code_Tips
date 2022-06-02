# data.table
[Reference](http://kohske.github.io/ESTRELA/201410/index.html)

## Table of Contents

* [Basics](#basics)
  * [data.frameとの違い](#data.frameとの違い)
  * [Setting Key](#setting-key)
  * [行と列の抽出と検索](#行と列の抽出と検索)
  * [追加と削除](#追加と削除)
  * [グループ化と集約](#グループ化と集約)
  * [オブジェクトのコピー](#オブジェクトのコピー)
  * [Sort](#sort)


## Basics
### data.frameとの違い
data.tableには行名という概念がないので、data.frameの行名を保つ場合には、`data.table(mtcars, keep.rownames=TRUE)`とすることで、`rn`列が作られる。

### Setting Key
予めキーを設定することで、キー列に対する高速な検索やデータ集約が可能になる。
```r
> setkey(dt, x) # キー列の設定
> setkeyv(dt, "x") # 文字列によるキー列の指定
```

### 行と列の抽出と検索
通常のdata.frameのものに加えて、こういったものもある
```r
> dt[, x]  # return as a vector (all rows in `x`)
> dt[, list(x)]  # return as a data.table
> dt[, .(x)]  # same as above, `.()` is an alias to `list()`
> dt[, list(x, y)] # 列名による列の選択
> dt[, .(x1 = x, y1 = y)]  # select and rename

> dt[, 1:2, with = FALSE] # インデクスによる列の選択
> dt[, c("x", "y"), with = FALSE] # 列名(文字列)による選択

> dt[col_month %chin% c('Jan', 'Feb'),]  # 文字列の場合は`%chin%`を
> dt[col_month %like% "^(Mar|Apr)',]  # regular expression
> dt[col %between% c(3, 5),] # same as `dt[col %in% 3:5,]`
```

### 追加と削除
```r
> dt[, z:=v*2] # 列を追加
> dt[, z:=NULL] # 列を削除
> dt[, v:=-v] # 要素を更新
> dt["a", y:=-y] # 特定の列の要素を変更
```

### グループ化と集約
```r
> dt <- data.table(x = rep(c("a", "b", "c"),　each = 3), y = c(1, 3, 6), v = 1:9)
> dt
   x y v
1: a 1 1
2: a 3 2
3: a 6 3
4: b 1 4
5: b 3 5
6: b 6 6
7: c 1 7
8: c 3 8
9: c 6 9

> dt[, mean(v), by = x] # 水準による集約
   x V1
1: a  2
2: b  5
3: c  8

> dt[, mean(v), by = y == 1] # 条件による集約
       y  V1
1:  TRUE 4.0
2: FALSE 5.5

> f <- function(l, m) l + m
> dt[, list(x, z = f(y, v))] # 自作関数による集約
   x  z
1: a  2
2: a  5
3: a  9
4: b  5
5: b  8
6: b 12
7: c  8
8: c 11
9: c 15

> flights[carrier == "AA", .(.N), by = .(origin, dest)]  # special symbol `.N`
> flights[, .N, by = origin]  # if there's only one column or expression to refer to in j and by, we can drop the `.()` notation
```

### オブジェクトのコピー
data.tableのオブジェクトを関数などに渡した時、関数内で変更が行われると元のオブジェクトも更新される。 これを防ぐには`copy()`により明示的にコピーを作成して関数に渡さねばならない。

### sort
```r
# Sort flights first by column origin in ascending order, and then by dest in descending order
flights[order(origin, -dest)]
```
