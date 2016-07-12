# Selenium
```python
from selenium import webdriver
driver = webdriver.Firefox() # If you want to download something, PhantomJS cannot be used
driver.get(url) 
```

## Table of Content
1. [クリック](#クリック)
2. 

## クリック
```python
driver.find_element_by_id("ctl00_ContentPlaceHolder1_showRelAggreement_imgExport").click()
```
