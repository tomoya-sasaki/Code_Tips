# BeautifulSoup
`from bs4 import BeautifulSoup`

## Table of Contents
1. [soupを作る](#soupを作る)
2. [探す](#探す)
3. [タグの中身を取り出す](#タグの中身を取り出す)
4. [少し待つ](#少し待つ)
5. [リンクの取り出し](#リンクの取り出し)
6. [PhantomJS](#phantomjs)


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

### 少し待つ
```python
import random
import time
time.sleep(random.uniform(1, 2))
```

### リンクの取り出し
```python
links = soup.find_all("a")
list_xls_files = []
for link in links:
  link_url = link.get("href")
  try:
    if ".xls" in link_url:
     list_xls_files.append(link_url[5:])
  except TypeError:
    pass
```

### PhantomJS
##### インストール
