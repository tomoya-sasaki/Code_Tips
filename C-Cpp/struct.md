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

void dadd(DATA_STRUCT *data){
	for(int i=0; i<5; i++){
		(&data)[0] -> words.push_back(3);
	}
}

int main(){

	DATA_STRUCT *data = new DATA_STRUCT[5];
	dadd(data);
	cout << (&data)[0] -> words[0] << endl;
}
```
