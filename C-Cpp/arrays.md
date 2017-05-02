# Arrays

## Table of Contents
1. [Arrays and brackets](#arrays-and-brackets]

## Arrays and brackets
まず、`int a[10];`に対して`a`と記述すると`&a[0]`と同じに解釈 (arrayの先頭要素へのポインタ)

配列の宣言時、`int a[10];`とにおける、`[]`は配列の宣言の為の記号。

一方、`a[3]=0;`とすると、`a`は先の規則によって`a`の先頭要素へのポインタと解釈されて、これに`[]`をつけることでそこから4つ目の場所へのアクセスとなる(C++ではindexが0スタート)。だから`a[3]`と`*(a+3)`は等価
