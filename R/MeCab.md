# RMeCab

## Install
Try [this](https://github.com/IshidaMotohiro/RMeCab/issues/21#issuecomment-1113888363) on Terminal (not on iTerm). Do not use homebrew.

## neogold

```
$ git clone --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git
$ cd mecab-ipadic-neologd
$ ./bin/install-mecab-ipadic-neologd -n
$ mecab -d /usr/local/lib/mecab/dic/mecab-ipadic-neologd/
```

Edit `/usr/local/etc/mecabrc` (with a `sudo` option)
```
;dicdir =  /usr/local/lib/mecab/dic/ipadic
dicdir = /usr/local/lib/mecab/dic/mecab-ipadic-neologd
```

## Analyze
`data_use` has row texts in the column `Speech`.

```r
library(RMeCab)
library(furrr)
nworkers <- 3
plan(multisession, workers = nworkers)
nspeech <- nrow(data_use)

batch_size <- ceiling(nspeech / nworkers)
split_index <- split(sample(1:nspeech), ceiling(seq_along(1:nspeech)/batch_size))

mecab <- future_map_dfr(split_index, function(indexes) {

  map_dfr(indexes, function(i) {
    raw <- data_use[["Speech"]][i]
    res <- unlist(RMeCabC(raw, mypref = 1))
    pos <- names(res)
    res <- paste(res[pos %in% c("名詞", "動詞")], collapse = " ")
    return(tibble(rowid = i, res = res))
  }) -> res

  return(res)
}) %>% arrange(rowid)
```
