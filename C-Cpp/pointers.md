# Pointers

## Table of Contents
1. [Basics](#basics)
2. [Structs](#structs)
3. [Arrays](#arrays)


## Basics
### Explanation 1
[Reference](http://www-watt.mech.eng.osaka-u.ac.jp/~tasai/ptrdoc/node5.html)

> `&` は変数が割り当てられているメモリのアドレスを得る演算子で「アドレス演算子」と呼ばれています． 
> 例えば，変数 x が 1000 番地に割り当てられていたとすると `&x` の値は 1000 になります．
> このとき， `&x` を「変数 `x` への『ポインタ』」あるいは「変数 `x` を指す『ポインタ』」と呼びます．
> ポインタは「ポイント（point）するもの」つまり「指し示すもの」という意味です．

> `*` はポインタが指すメモリをＣ言語の変数として扱うための演算子

> `&x` は `x` のアドレスをあらわします． さらに， `&x` に `*` を用いると， そのアドレス `&x` が指すメモリを変数とみなすので， `*(&x)` は `x` と同じ変数

ポインタを介在して、違う変数の変数にアクセスすることができる。

### Explanation 2
[Reference](http://www.cplusplus.com/doc/tutorial/pointers/)

* `&` is the address-of operator, and can be read simply as "address of"
* `*` is the dereference operator, and can be read as "value pointed to by"

> the declaration of a pointer needs to include the data type the pointer is going to point to: `type *name;`

> Note that the asterisk (`*`) used when declaring a pointer only means that it is a pointer (it is part of its type compound specifier), and should not be confused with the dereference operator seen a bit earlier, but which is also written with an asterisk (`*`). They are simply two different things represented with the same sign.

## Structs
構造体のポインタは1つのデータ群の先頭アドレスを指していて、メンバ変数を指しているわけじゃない

## Arrays
```
void num_docs(int *a){
  cout << a[2] << endl;
  cout << *(a+2) << endl;
}

int main() {
  int a[3] = {1,2,3};	
  num_docs(a);
  num_docs(&a[0]); // 上と同じ
  return 0;
} 
```
`&a[0]`のことを`a`と書いても良いという規則。先頭要素のアドレスと配列本体のアドレスは別（場所は同じでも型が異なる）ので、`&a`とするとエラーになる。
