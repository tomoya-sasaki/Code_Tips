# 文字絡みの処理

## Table of Contents
1. [Shift-JisからUnicodeへ](#shift-jisからunicodeへ)
2. [Format](#format)


### Shift-JisからUnicodeへ
エンコーディングを指定して読み込んだ段階で、utf-8になっているようなので、後は保存するときに適切に指定すれば良い

### Format
```python
>>> "My Name is {0}.".format("Smith")   #インデックスを指定して埋め込み
'My Name is Smith.'
>>> "My Name is {0}. Hello {1}".format("Smith", "Taro")
'My Name is Smith. Hello Taro'

# キーワード引数で指定
>>> "My Name is {person1}. Hello {person2}".format(person1="Smith", person2="Taro")
'My Name is Smith. Hello Taro'

# ディクショナリで指定する場合はアンパックすればよい
>>> d = {"name": "Smith", "age": 20}
>>> "My name is {name}. I'm {age} years old.".format(**d) #アンパックしてキーワード引数に
"My name is Smith. I'm 20 years old."
```
