# Struct

1. [Simple Examples](#simple-examples)

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
`data[i]`と `*(data+i)`は等価ゆえ、`(data+i) -> words.push_back(s);`としてもOK。
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
