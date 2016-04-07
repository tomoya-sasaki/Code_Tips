# BeautifulSoup

## Table of Contents
1. [soupを作る](#soupを作る)


### soupを作る
```python
import httplib2

h = httplib2.Http('.cache') #by httplib2
response, content = h.request("http://lab.magicvox.net/proxy/")
content = content.decode("utf-8")
soup = BeautifulSoup(content, "lxml")
```
