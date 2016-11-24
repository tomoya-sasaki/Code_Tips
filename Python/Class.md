# Class
[Basic reference 1](http://www.yoheim.net/blog.php?q=20160405)

## Table of Contents
1. [Basics](#basics)


## Basics
```python
class Test:
    def __init__(self, path):
        self.path = path
        
    def read_file(self):
        self.bill_list = [] ; self.speech_list = []
        
        with open(self.path, encoding="utf-8") as self.file:
            for self.line in self.file:
                pass
            
        print("Yes")
        
data_2004 = Weights("2004_1.txt")
data_2004.read_file()
```
