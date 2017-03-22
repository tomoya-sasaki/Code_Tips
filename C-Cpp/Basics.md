# Basics of C/C++

## Random Notes
1. [小数の計算](#小数の計算)
2. [引数の型変換(キャスト)](#引数の型変換)
3. [変数で宣言できない場合](#変数で宣言できない場合)
4. [ファイルリストの作成](#ファイルリストの作成)
5. [ファイルの読み込み](#ファイルの読み込み)
	* [タブ区切り](#タブ区切り)
	* [空白区切り](#空白区切り)
6. [ファイルの書き込み](#ファイルの書き込み)
7. [prinfでの出力](#prinfでの出力)
8. [Single quote and double quote](#single-quote-and-double-quote)
9. [Switch with character](#switch-with-character)
10. [Vector](#vector)
11. [Dynamic array](#dynamic-array)

## 小数の計算
`double`で宣言していても、`2.0`とかとしない限り、整数扱いみたい。`2/4`では`0`が返ってくるが、`2.0/4.0`なら`0.5`にちゃんとなる。

## 引数の型変換
`(int)K`のようにして引数とする。

## 変数で宣言できない場合
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

## ファイルリストの作成
[こちらのgist](https://gist.github.com/Shusei-E/b91e7e3419103036059455100464c1cb)


## ファイルの読み込み
[こちらのサイト](http://fa11enprince.hatenablog.com/entry/2014/04/03/233500)  
[その2](http://mementoo.info/archives/611#A_getline)

### タブ区切り
```cpp
#include <sstream>
#include <fstream>
/* Read File */
	ifstream ifs(full_path);
   	string str, temp;
   	if (ifs.fail())
   	{
   	    std::cerr << "Reading file failed" << std::endl;
   	    return -1;
   	}
   	while (getline(ifs, str)){ // read file line by line
			istringstream stream(str);
			while(getline(stream,temp,'\t')){ // analyze each line
				std::cout<< temp << std::endl;
			}
	}
```

### 空白区切り
```cpp
#include <iostream>
#include <vector>
using namespace std;

int main(){
  int n;
  cin >> n; // number of elements in one line

  vector<int> numbers(n);
  for (int i=0; i<n; i++) {
    cin >> numbers[i];
  }

  return 0;
}
```

## ファイルの書き込み

### 追記モード
`sigma[k]`の値を順々に書き込んでいく
```cpp
#include <cstdlib> // EXIT_FAILURE のため
// Save Results
for(int k=0; k<K; ++k){
	fstream fs;
	fs.open("em-output.txt", ios::out|ios::app); // Can write (append mode)
	if(!fs.is_open()){
		return EXIT_FAILURE;
	}
	fs << sigma[k] << endl;
	fs.close();
}//for(k)
```

## prinfでの出力
```cpp
printf("%d %d %f", d, r, f);
```
| %i or %d |               int               |
|:--------:|:-------------------------------:|
|    %c    |               char              |
|    %f    | float (see also the note below) |
|    %s    |              string             |
There are other Format Specifiers as well.

## Single quote and double quote
In C and in C++ single quotes identify a single character, while double quotes create a string literal. 

## Switch with character
```cpp
switch(op){
 case '+': 
 	cout << a + b << endl;
 	break;
 case '-':
 	cout << a - b << endl;
 	break;
 case '/':
 	cout << a / b << endl;
 	break;
 case '*':
 	cout << a * b << endl;
 	break;
}
```

## Vector
[Reference](http://vivi.dyndns.org/tech/cpp/vector.html#init)
```cpp
#include <vector>

vector<int> numbers(n);
vector<int> numbers2; 
  // オブジェクトの要素数は0。データを追加するには次の章で説明する push_back() などを使う
```

## Dynamic array
[Reference](http://stackoverflow.com/questions/3904304/3d-array-c-using-int-operator)  
最後に`()`をつけることで`0`にinitializeできる。     
1D
```
const int MAX_SIZE=128;
int *arr1D = new int[MAX_SIZE];
```

2D (Row×Column)
```cpp
const int Row=20; // 1st Dimension
const int Column=20; // 2nd Dimension

int **arr2D = new int*[Row];  //create an array of int pointers (int*), that will point to 
                                //data as described in 1D array.
for(int i = 0;i < Row; i++){
  arr2D[i] = new int[Column]; 
}
// ... some codes ...
for(int i=0; i<Row; i++)
   delete [] arr2D[];
delete [] arr2D;
```

3D
```cpp
const int X=20;
const int Y=20;
const int Z=20;

int ***arr3D = new int**[X];
for(int i =0; i<X; i++){
  arr3D[i] = new int*[Y];
  for(int j =0; j<Y; j++){
    arr3D[i][j] = new int[Z];
    for(int k = 0; k<Z;k++){
      arr3D[i][j][k] = 0;
    }
  }
}
```

関数に読み込ませてやるときは、`vecsum(int n, int Data[n+1])`のように長さに関わるものを先にすることで上手くいった。


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

 
