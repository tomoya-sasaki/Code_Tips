# Chapter 4

## Stanの文法について
* 値の決まっていない確率変数と看做せるものは全てparameter扱い
* 変数の宣言は「{」の直後なら各ブロックどこでもできる
* 本書p.33に `lp__` and `target` についても説明あり
* `generated quantities` の中では `~` を使用することができない。このような状況での乱数の発生方法は、p.51を参照のこと
