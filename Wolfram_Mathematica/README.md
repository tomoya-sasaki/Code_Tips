# Wolfram Mathematica

## Basics
* `%`は直前の結果
* 近似的な値が知りたい場合には関数`N`
* Mathematicaの組み込み関数は全て大文字で始まるので、定数・変数・関数などを定義する場合は 小文字で始まる名前をつける
* 特殊な意味を持つ文字の挿入
 * π: `\[Pi]`
* 入力の最後にセミコロンを加えておくと，Wolfram言語は，要求された計算はするが結果は表示しない

## 式の操作
* 式の展開 `Expand`
* 因子分解 `Factor`
* 方程式を解く `Solve`
  * `Solve[x^3 + x^2 - 3x + 1 == 0, x]`
  * 解が代数的に求まらないような方程式に対しては、`FindRoot`を用いて数値的な近似解を求めることができる
* 微分
 * 関数 `D`
* 積分
 * 関数 `Integrate`

## グラフィックス
* `Plot[Sin[x], {x, 0, 2 Pi}, PlotStyle -> {Dashed, Green}]`
 * 区間が0から2π
 * 
 
## リスト
* `{ }`で囲まれたのがリスト

## 行列
* 多次元のリストが行列
* `Table[a^i b^j, {i, 1, 3}, {j, 1, 2}]`
 * `MatrixForm[%]`
* 行列の積は`.`もしくは`Dot`という関数で行う
* Sample
```mathematica
> {{2, 3, 5}, {3.4, 6.4, 0}} 
{{2, 3, 5}, {3.4, 6.4, 0}}
> % % // MatrixForm
> %% // TableForm

> M = {{2, 3, 5}, {3.4, 6.4, 0}} 
> M[[1, 3]]
5

> M[[All, 3]]
{5, 0}
```

## 関数の定儀
* 基本の形
```mathematica
> Test[x_ , y_] := x + y;
> Test[2, 3]
5
```
```mathematica
> Test2 = [2 # + #] &;
> Test2[1]
3
> Test2@1
3
```

## Do
* Example 1
```mathematica
> Do[Print[n*2], {n, 4, 9}]
8
10
12
14
16
18
```

## For
```mathematica
> For[i = 1, i < 3, i++, Print[i*3]]
3
6
```



