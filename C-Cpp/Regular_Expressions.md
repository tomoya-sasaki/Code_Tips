# Regular Expresions
[Good Website](http://program.station.ez-net.jp/special/handbook/cpp/string/regex.asp)
But be careful, it seems to be quite SLOW!! Consider using [`std::string::find`](http://www.cplusplus.com/reference/string/string/find/), for example.

## Table of Contents
1. [Find](#find)
2. [OR](#or)

## Find
### Use in if function
```cpp
#include <regex>
regex re("(.*)(CCText)(.*)");
if(regex_match(*iter, re)) // found = True, not found = False
```

## OR
Use or:
```cpp
#include <iostream>
#include <regex>
#include <string>
using namespace std; 
int main(int argc, char **argv) {
    string test= "ニュースかその他のテーマ";
		regex pattern("[ニュース|話題].*");

		if(regex_match(test, pattern)){
			cout << "find" << endl;
		}
}
```
