#R

### 虹色
```r
cols <- rainbow(length(job_freq))
```

### 図の保存
```r
pdf("ファイル名", オプション色々)
  描画処理
dev.off()
```

### エラーの言語切り替え
```r
Sys.getenv("LANGUAGE") #初めは空
Sys.setenv(LANGUAGE="en")
Sys.setenv(LANGUAGE="ja") # 戻す
```
