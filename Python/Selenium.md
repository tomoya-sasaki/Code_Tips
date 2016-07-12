# Selenium
```python
from selenium import webdriver
driver = webdriver.Firefox() # If you want to download something, PhantomJS cannot be used
driver.get(url) 
```
PhantomJSを使う場合は、homebrewでインストール可能。[ここ](https://github.com/Shusei-E/Code_Tips/blob/master/Python/BeautifulSoup.md#phantomjs)にも情報あり。

## Table of Content
1. [クリック](#クリック)
2. 

## クリック
```python
driver.find_element_by_id("ctl00_ContentPlaceHolder1_showRelAggreement_imgExport").click()
```
