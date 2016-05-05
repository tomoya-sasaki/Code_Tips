# Basics of C/C++

## Random Notes
1. [小数の計算](#小数の計算)
2. [引数の型変換(キャスト)](#引数の型変換)
3. [変数で宣言できない場合](#変数で宣言できない場合)

#### 小数の計算
`double`で宣言していても、`2.0`とかとしない限り、整数扱いみたい。`2/4`では`0`が返ってくるが、`2.0/4.0`なら`0.5`にちゃんとなる。

### 引数の型変換
`(int)K`のようにして引数とする。

### 変数で宣言できない場合
```cpp
typedef struct{
		vector<double> KeepMu;
		vector<double> KeepZ;
}KEEP_RESULT;

int main(){
 KEEP_RESULT *Keep_Result = new KEEP_RESULT[S];
}
```
http://goo.gl/n1tTj4


## Sites
* [C++入門](http://www.asahi-net.or.jp/~yf8k-kbys/newcpp0.html)

## A Tour of C++
#### pp.3-4
`Elem* next_elem();` no argument; return a pointer to Elem (an Elem*)  
`void exit(int);` int argument, return nothing  
`double sqrt(double);` double argument; return a double  
return typeが名前の前に来ていることに注意。argumentのtypeは括弧の中。  

* 同じ名前の関数を2つの異なる引数型で使った場合、callした際に最適なものが選ばれる
 
#### p.5 変数の宣言
fundamental types:
  * bool
  * char
  * int
  * double
  * unsigned: non-negative integer
typeのサイズは、機械によって変わってくる。値を知りたい場合は、`sizeof`を使う  

初期化:
```cpp
double d1 = 2.3;
double d2 {2.3};
complex<double> z = 1; // a complex number with double-precision floating-point scalars
```
`auto`を使えば、初期化の値から自動的に型が判断される
```cpp
auto b = true; //bool
auto ch = 'x'; //char
```

計算の簡略化:
*`x+=y` equals to x = x+y
* `++x` equals to x = x+1 (increment)
* 他にもある (p.7)

変数の宣言によって、nameがscopeに入ってくる
* Local scope: declarationがなされたblockだけで
* Class scope:
* Namespace scope:
```cpp
vector<int> vec; // global (a global vector of intergers)

struct Test{
  sring name; // member
};

void funct(int arg){ // fct is global, funct is local integer argument
  string sentence {"Test sentence"}; // local
}
```

#### Pointers
`*` contents of / `&` address of として考えられる (p.10)  
[これ](http://goo.gl/BFdGE3)はかなりわかりやすい。

 
