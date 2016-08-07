# MeCab
MeCabそのもののインストールは行っておく。 `sudo` が使えない環境の場合、[こちら](http://ja.stackoverflow.com/questions/26683/sudo%E3%81%8C%E4%BD%BF%E3%81%88%E3%81%AA%E3%81%84%E7%92%B0%E5%A2%83%E4%B8%8B%E3%81%B8%E3%81%AEmecab%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB/26695#26695)を参照のこと。

Install [mecab-ipadic-NEologd](https://github.com/neologd/mecab-ipadic-neologd/blob/master/README.ja.md) for a better dictionary. If you don't want to use `sudo`, after finishing normal installation process but the last step, move to `build/mecab...../` and `make install`. ([reference](http://qiita.com/mnakajima/items/2218363a5a58bc542e70))

## Table of Contents
1. [Install](#install)

### Install
```python
pip install mecab-python3
```
