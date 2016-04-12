# Wolfram Mathematica

## Basics
* `%`は直前の結果
* 近似的な値が知りたい場合には関数`N`

## 式の操作
* 式の展開 `Expand`
* 因子分解 `Factor`
* 方程式を解く `Solve`
  * `Solve[x^3 + x^2 - 3x + 1 == 0, x]`
  * 解が代数的に求まらないような方程式に対しては、`FindRoot`を用いて数値的な近似解を求めることができる
* 微分
 * 関数 `D`
