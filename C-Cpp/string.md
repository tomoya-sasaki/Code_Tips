# String

## Table of Contents
1. [Lexical comparison](#lecixal-comparison)

## Lexical Comparison
```cpp
#include <iostream>  
#include <string>
using namespace std;

int main () {
  string a = "0101";
  string b = "0102";

  if(a < b){
    cout << "a is short" << endl;
  }else if(b < a){
    cout << "a is long" << endl;
  }

  return 0;
}
```
