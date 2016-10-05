# Python Tips

## Basics

### Delecte an object on memory
```python
del OBJECT
```

### File input/output
Input:
```python
# Read Entile File
with open("filename", "r") as file:
  whole_str = file.read()
  
# Read Line by Line
with open("filename", encoding='utf-8') as a_file:  
    for a_line in a_file:                                               
        print(a_line)
```
* `file.read([size])`で指定したバイト数を読み込み。size未指定の場合は全て読み込み。  
* `file.readline()`で1行読み込み。文字列に改行文字は残る。最後の行を読み込んだ後には`””`（空文字）が返る。  
* `file.readlines()`で全行を読み込んでリストとして返す。  

Output:
```python
with open("filename", "w") as file:
    file.write("some string")
```

### Show figures on jupyter
`%matplotlib inline`
If you want to change the size of figures,
```python
import matplotlib.pylab as pylab
pylab.rcParams['figure.figsize'] = 16, 12 # default image size
```

### Get File List
```python
# Return the list of Text Files
glob.glob(directory+"/*.txt")

# Return the list of Subdirectory
glob.glob(root_directory + "/*/")
```
