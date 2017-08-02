# std::array
`#include <array>`

## Table of Contents
1. [Initialization](#initialization)

## Initialization
### 1D
```cpp
std::array<int, 3> a1 = { { 1, 2, 3 } };
```

### 2D
```cpp
std::array<std::array<int,3>,2> a2 {{
  {{1,2,3}},
  {{4,5,6}}
}};
```
