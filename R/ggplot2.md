# ggplot2
References:
* [ggplot2 — きれいなグラフを簡単に合理的に](https://heavywatal.github.io/rstats/ggplot2.html)
* [Top 50 ggplot2 Visualizations](http://r-statistics.co/Top50-Ggplot2-Visualizations-MasterList-R-Code.html): 大体何でも載っているサイト

## Table of Contents
1. [xラベルの変更](#xラベルの変更)
2. [エラーバーの追加](#エラーバーの追加)
3. [線の種類](#線の種類)
4. [図を並べる](#図を並べる)
5. [データの確認](#データの確認)
6. [histogramと確率密度関数を同時に描く](#histogramと確率密度関数を同時に描く)
7. [関数の曲線を描く](#関数の曲線を描く)
8. [タイトルの位置調整](#タイトルの位置調整)
9. [文字列でaesを使う](#文字列でaesを使う)
10. [軸関連](#軸関連)
   * [軸のorderを変える](#軸のorderを変える)
   * [orderとlabelを変える](#orderとlabelを変える)
11. [Legend関連](#legend関連)
   * [順番を変える](#順番を変える)
   * [ラベルを変える](#ラベルを変える)
12. [theme関連](#theme関連)
   * [一括でサイズ](#一括でサイズ)
13. [position関連](#position関連)
   * [線分の位置](#線分の位置)
14. [Theme](#theme)
15. [日本語関連](#日本語関連) 
   
## xラベルの変更
```r
xlabels <- rep("", 120)
xlabels[c(seq(from = 1, to = 120, by = 10))] <- c(seq(from = 120, to = 1, by = -10))

g <- ggplot(data.frame(predicted=predicted, Date=date_vec, true_index=true_index), aes(x=reorder(Date, true_index), y=predicted)) + 
        geom_point() + xlab("Days to Election") + ylab("Prediction") +
        scale_x_discrete(labels = xlabels) +  # ここで変更を行なっている！
        theme_bw() 
options(repr.plot.width=6, repr.plot.height=2.8)
g
```
<img src="figures/ggplot2_xlab_changed.png" width="550">

## エラーバーの追加
#### その1
データ
```r
> res_mean <- apply(result_df, 2, mean)
> res_025 <- apply(result_df, 2, quantile, prob=.025)
> res_975 <- apply(result_df, 2, quantile, prob=.975)
> result <- data.frame(mean=res_mean, top=res_975, bottom=res_025)
> result$Date <- 1:120
> print(head(result))
       mean    top bottom Date
X1 341.3333 359.65 313.10    1
X2 350.3333 366.00 337.50    2
X3 343.3333 349.50 340.00    3
X4 366.3333 372.75 358.50    4
X5 341.3333 352.25 333.25    5
X6 347.6667 350.85 344.20    6
```
コード
```r
true_index <- 120:1  # 軸ラベルの調整用 (これをしないと、0スタートにソートされてしまう)

xlabels <- rep("", 120) # 適度に間隔の開いたラベルを作る
xlabels[c(seq(from = 1, to = 120, by = 10))] <- c(seq(from = 120, to = 1, by = -10))

g <- ggplot(result, aes(x=reorder(Date, true_index), y=mean, group=1)) + # reorderで指定した順序にする
        geom_line(size=0.8, color="blue") + xlab("Days to Election") + ylab("Prediction") +
        geom_errorbar(size=0.2, aes(ymin=bottom, ymax=top)) +
        geom_point(size=0.9, aes(x=reorder(Date, true_index), y=mean)) + # meanだけはpointを付ける
        geom_line(aes(x=reorder(Date, true_index), y=top), size=0.4, color="gray") + # 上を結ぶ
        geom_line(aes(x=reorder(Date, true_index), y=bottom), size=0.4, color="gray") + # 下を結ぶ
        scale_x_discrete(labels = xlabels) + # 軸ラベルを調整
        theme_bw() 
options(repr.plot.width=7, repr.plot.height=2.8)
g
```
<img src="figures/ggplot2_error_bars.png" width="580">


## 線の種類
```r
g <- ggplot(res1, aes(x=EnrollmentCount, y=ClassSize)) +
  geom_line(aes(colour = type, linetype=type), size = 0.87)
```

Manualで変える ([Reference](http://www.sthda.com/english/wiki/ggplot2-line-types-how-to-change-line-types-of-a-graph-in-r-software))
```r
# Set line types manually
g <- ggplot(df2, aes(x=grade, y=score, group=gender)) +
  geom_line(aes(linetype=gender))+
  geom_point()+
  scale_linetype_manual(values=c("dotdash", "dotted"))+
  theme(legend.position="top")
  
# Change line colors and sizes
g <- ggplot(df2, aes(x=grade, y=score, group=gender)) +
  geom_line(aes(linetype=gender, color=gender, size=gender))+
  geom_point()+
  scale_linetype_manual(values=c("solid", "dotted"))+
  scale_color_manual(values=c('#999999','#E69F00'))+
  scale_size_manual(values=c(1, 1.5))+
  theme(legend.position="top")
```

## 図を並べる
[Reference](http://notchained.hatenablog.com/entry/2015/12/17/010904)
```r
library(gridExtra)

g1 <- ggplotGrob(p1)
id.legend <- grep("guide", g1$layout$name)
legend <- g1[["grobs"]][[id.legend]]
lwidth <- sum(legend$width)

gA <- grid.arrange(p1 + theme(legend.position="none"), 
          p2 + theme(legend.position="none"), 
          legend, 
          layout_matrix = rbind(c(1,1,1,2,2,2,3))
          )
```
<img src="figures/ggplot_2figs.png" width="780">


## データの確認
`GGally`の`ggpairs`を使うと良いかも。カスタマイズ方法は「StanとR」のp.55に対応するコードを参照のこと。


## histogramと確率密度関数を同時に描く
[Reference](http://qiita.com/hoxo_b/items/13d034ab0ed60b4dca88)

y-axsis is density:
```r
dens <- density(faithful$waiting)
bw <- diff(range(faithful$waiting))/20

ggplot(faithful, aes(x=waiting)) +
  geom_histogram(aes(y=..density..), binwidth=bw, fill='white', color='black') +
  geom_density(fill='black', alpha=0.3) +
  xlim(range(dens$x))
```

y-axis is count:
```r
dens <- density(faithful$waiting)
bw <- diff(range(faithful$waiting))/20

ggplot(faithful, aes(x=waiting)) +
  geom_histogram(binwidth=bw, fill='white', color='black') +
  geom_density(eval(bquote(aes(y=..count..*.(bw)))), fill='black', alpha=0.3)+
  xlim(range(dens$x))
```


## 関数の曲線を描く
[Reference](http://qiita.com/hoxo_b/items/a6522a6e6561f8ca7b96)  
`stat_function` or `geom_path`


## タイトルの位置調整
Add `theme(plot.title = element_text(hjust = 0.5))` last does centering.

## 文字列でaesを使う
```r
var = 'a'
ggplot(data=d, aes_string(x=var))
```

## 軸関連
### 軸のorderを変える
```r
scale_x_discrete(limits = c('a3', 'a2', 'a1'))
```
が一番簡単そう。

### orderとlabelを変える
```r
p + scale_x_discrete(limits = c("I1", "SI2", "SI1"), # order
                     labels = c("Ione","SItwo","SIone")) # new label
```
`coord_flip()`をするときは、逆順で書かないといけないので注意

## Legend関連
### 順番を変える
```r
guides(fill = guide_legend(reverse = TRUE)) # factor with `aes(fill = )`
guides(colour = guide_legend(reverse = TRUE)) # factor with `aes(colour = )`
```
### ラベルを変える
```r
data %>% select_("Group", "Finished") %>% slice(3:n()) %>% 
   ggplot(aes(Group, fill=Finished)) + geom_bar() + scale_fill_hue(name = "Finished", labels = c("0"="Not Finished", "1"="Finished")) 
```
`aes`のところが`color`なら、`scale_fill_hue`になる。<br>
<img src="figures/ggplot2_legend_label.png" width="300">


## theme関連
### 一括でサイズ
```r
theme_gray(base_size=12)
theme_bw(base_size=12)
```

## position関連
### 線分の位置
[ここ](https://github.com/Shusei-E/Code_Tips/blob/master/R/dplyr.md#regression-simulation)にも書いた通り、`position_dodge`を負の値にすることで線分の並びを逆にすることができる ([Reference](http://stackoverflow.com/questions/42303960/ggplot2-change-the-order-of-color))。
<img src="figures/dplyr_simulation.png" width="300">

## Theme
[ggthemes](https://www.karada-good.net/analyticsr/r-566)


## 日本語関連
```r
theme_gray(base_family="YuGo-Medium")
```
