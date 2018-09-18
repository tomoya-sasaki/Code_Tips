# Header Files
Related topic: [class](https://github.com/Shusei-E/Code_Tips/blob/master/C-Cpp/class.md)

1. [C++](#c==)
2. [Rcpp](#rcpp)


## C++
### Principles
[Reference](http://www7b.biglobe.ne.jp/~robe/cpphtml/html02/cpp02007.html)

1. Define a class in a header file (`.h`)
2. Implement the class in a source file (`.cpp`)
3. Include the header file if you want to use the class

* Do not write `using` or `using namespace` in header files.

### Minimum Example
[Reference](http://www7b.biglobe.ne.jp/~robe/cpphtml/html02/cpp02007.html)

```cpp
// my_head.h
#ifndef __MY_HEAD_INCLUDED__
#define __MY_HEAD_INCLUDED__

class MYHEAD
{
public:
    int value;

    void myFunc();
};

#endif
```

```cpp
// my_imp.cpp
#include "my_head.h"

void MYHEAD::myFunc()
{
   value = 0;
}
```

```cpp
// main.cpp
#include "my_head.h"

int main()
{
    MYHEAD my_class;
    my_class.myFunc();
}
```

## Rcpp
[Reference 1](https://knausb.github.io/2017/08/header-files-in-rcpp/)





