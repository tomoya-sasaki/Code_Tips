# Vector

## Table of Contents
1. [push_back](#push_back)
2. [Fill with ordered numbers and shuffle](#fill-with-ordered-numbers-and-shuffle)

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
## Fill with ordered numbers and shuffle
```cpp
#include <iostream>
#include <vector>
#include <algorithm>
#include <random>
using namespace std;
random_device rd;
mt19937 rng(rd());

int main(){
	vector<int> data(10);
	iota(begin(data), end(data), 0); // 0: starting number

	for(int i=0; i<10; i++)
		cout << data[i] << " ";
	cout << endl;

	shuffle(begin(data), end(data), rng);
	for(int i=0; i<10; i++)
		cout << data[i] << " ";
	cout << endl;
}
```
