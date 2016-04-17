# BeautifulSoup
`from bs4 import BeautifulSoup`

## Table of Contents
1. [soupを作る](#soupを作る)
2. [探す](#探す)
3. [タグの中身を取り出す](#タグの中身を取り出す)


### soupを作る
```python
import httplib2

h = httplib2.Http('.cache') #by httplib2
response, content = h.request("http://lab.magicvox.net/proxy/")
content = content.decode("utf-8")
soup = BeautifulSoup(content, "lxml")
```

### 探す
```python
soup.find_all("td", class_="td2")
```

### タグの中身を取り出す
```python
>td_list[1].find_all("a")
[<a class="a1" href="**URL**">test</a>]

> td_list[1].find_all("a")[0].contents
['test']
```
