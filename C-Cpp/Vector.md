# Vector

## Table of Contents
1. [push_back](#push_back)
2. [Fill with ordered numbers and shuffle](#fill-with-ordered-numbers-and-shuffle)
3. [Sort](#sort)

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

## Sort

### Return index
[Reference](https://stackoverflow.com/questions/25921706/creating-a-vector-of-indices-of-a-sorted-vector)
```cpp
#include <iostream>
#include <vector>
#include <numeric>
using namespace std;

vector<size_t> sort_indexes(const vector<double> v, int ascending=1) {
  // default is ascending

  // initialize original index locations
  vector<size_t> idx(v.size());
  iota(idx.begin(), idx.end(), 0);

  // sort indexes based on comparing values in v
  if(ascending){
    sort(idx.begin(), idx.end(),
         [&v](size_t i1, size_t i2) {return v[i1] < v[i2];});
  }else{
    sort(idx.begin(), idx.end(),
         [&v](size_t i1, size_t i2) {return v[i1] > v[i2];});
  }

  return idx;
}

int main()
{
  vector<double> x = {1.5, 5.3, 0.1, 20.0};
  for(int i=0; i<4; i++)
    cout << sort_indexes(x, 0)[i] << endl;

  return 0;
}
```
