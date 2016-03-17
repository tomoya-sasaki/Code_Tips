# ggplot2

## Table of Contents
1. [xラベルの変更](#xラベルの変更)

### xラベルの変更
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
