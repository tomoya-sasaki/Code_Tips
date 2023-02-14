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
