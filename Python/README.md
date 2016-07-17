#Python Tips

## Basics

### Delecte an object on memory
```python
del OBJECT
```

### File input/output
Input:
```python
with open("filename", "r") as file:
  whole_str = file.read()
```
* `file.read([size])`で指定したバイト数を読み込み。size未指定の場合は全て読み込み。  
* `file.readline()`で1行読み込み。文字列に改行文字は残る。最後の行を読み込んだ後には`””`（空文字）が返る。  
* `file.readlines()`で全行を読み込んでリストとして返す。  

Output:
```python
with open("filename", "w") as file:
    file.write("some string")
```
