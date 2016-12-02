#R

### 虹色
```r
cols <- rainbow(length(job_freq))
```

### 図の保存
With ggplot2
```r
ggsave(file = "fig.pdf", plot = p, dpi = 600, width = 6.4, height = 4.8)
```
```r
pdf("NonNormal1.pdf", width=10 , height=6)
par(mfrow=c(1,2))
hist(residuals(model1), main="Residual Plot (Model 1)")
qqPlot(model1)
dev.off()
```

### オブジェクトの保存
```r
write(x, file="variavle1.txt")
```


### エラーの言語切り替え
```r
Sys.getenv("LANGUAGE") #初めは空
Sys.setenv(LANGUAGE="en")
Sys.setenv(LANGUAGE="ja") # 戻す
```
