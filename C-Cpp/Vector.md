# Vector

## Table of Contents
1. [push_back](#push_back)
2. [Fill with ordered numbers](#fill-with-ordered-numbers)

## push_back
```cpp
int main(int argc, char const* argv[]){
  std::vector<int> v;
  v.push_back (1);
  v.push_back (2);
  v.push_back (3);
  for (auto x: v) {
    cout << x << endl;
  }
return 0;
}
```
## Fill with ordered numbers
```cpp
#include <iostream>
#include <vector>
#include <numeric>

int main(){
	vector<int> data(10);
	iota(begin(data), end(data), 0);

	for(int i=0; i<10; i++)
		cout << data[i];
	cout << endl;
}
```
