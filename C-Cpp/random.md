# Random

## Table of Contents
1. [Random integer from range](#random-integer-from-range)

## Random integer from range
```cpp
#include <random>

std::random_device rd;     // only used once to initialise (seed) engine
std::mt19937 rng(rd());    // random-number engine used (Mersenne-Twister in this case)
std::uniform_int_distribution<int> uni(min,max); // guaranteed unbiased

int random_integer = uni(rng);
```
