# Speed up

1. [Avoid declaration multiple times](#avoid-declaration-multiple-times)

## Avoid declaration multiple times
```cpp
// Good
int temp = 0;
int sum = 0;
int size = doc.size();
for(int i=0; i < size; i++){
    temp = i*3;
    sum += temp;
}

// Bad
int sum = 0;
for(int i=0; i < doc.size().; i++){
    int temp = i*3;  // should declare outside the for loop!
    sum += temp;
}
```
