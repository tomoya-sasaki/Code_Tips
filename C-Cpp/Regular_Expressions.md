# Regular Expresions

## Table of Contents
1. []()

### Find
#### Use in if function
```cpp
#include <regex>
regex re("(.*)(CCText)(.*)");
if(regex_match(*iter, re)) // found = True, not found = False
```
