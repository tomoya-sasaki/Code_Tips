# Struct

## Table of Contents
1. [Simple Examples](#simple-examples)
2. [With Eigen](#with-eigen)

## Simple Examples
### Data for LDA
```cpp
#include <iostream>
#include <vector>

using namespace std;

typedef struct{
	vector<int> words;
}DATA_STRUCT;

void add(DATA_STRUCT *data, int M){
	for(int i=0; i<M; i++){
		for(int s=0;s<3; s++){
			data[i].words.push_back(s);
			cout << i << s << endl;
		}
	}
}

int main(){
	int M=5;
	DATA_STRUCT *data = new DATA_STRUCT[M];
	add(data, M);
	cout << data[0].words[0] << endl;
	delete[] data;
}
```
`DATA_STRUCT *data`において、`data[i]`と `*(data+i)`は等価ゆえ、`(data+i) -> words.push_back(s);`としてもOK。`data`という基準点（それがポインタ）からみて`i`番目（ゼロ番目から数える）の位置にある内容が、二通りで表せる。

実は、以下は皆同じ:
```cpp
(data+i)->words.push_back(s);
data[i].words.push_back(s);
(&data[i])->words.push_back(s);
(*(&data[i])).words.push_back(s);
(&(*(&data[i])))->words.push_back(s);
```
```cpp
void show(int *a){
	cout << a[2] << endl;
	cout << *(a+2) << endl;
}

int main() {
	int a[3] = {1,2,3};	
	show(a);

	return 0;
} 
```

## With Eigen
[Check this note](https://github.com/Shusei-E/Code_Tips/blob/master/C-Cpp/Eigen.md#passing-values)
