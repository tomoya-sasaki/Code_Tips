# 文字絡みの処理

## Table of Contents
1. [Shift-JisからUnicodeへ](#shift-jisからunicodeへ)
2. [Format](#format)


### Shift-JisからUnicodeへ
エンコーディングを指定して読み込んだ段階で、utf-8になっているようなので、後は保存するときに適切に指定すれば良い

### Format
Example 1:
```python
print('Hello, %s!' % 'World')
```
Example 2:
```python
"My Name is {0}.".format("Kenta")
"My Name is {0}. Hello {1}".format("Ken", "Taro")
```
Example 3:
```python
"My Name is {person1}. Hello {person2}".format(person1="John", person2="Ken")
```
If you want to use `{` itself, change it to `{{` (doubled).

# ディクショナリで指定する場合はアンパックすればよい
>>> d = {"name": "Smith", "age": 20}
>>> "My name is {name}. I'm {age} years old.".format(**d) #アンパックしてキーワード引数に
"My name is Smith. I'm 20 years old."
```
