# 正規表現
`.`は、`\n`などとはmatchしないので注意。`|`を使えばorができる。


## Table of Contents
1. [繰り返しmatch](#繰り返しmatch)

### 繰り返しmatch
`finditer`を使う
```python
for matched in re.finditer(r"○<strong>(?P<Name>.+?)<\/strong>(?P<Speech>(.|\n)+?)(○|<\/span>)", str(soup)):
    name_list.append(matched.group("Name"))
    speech_list.append(clean_text(matched.group("Speech")))
```
