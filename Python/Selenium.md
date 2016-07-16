# Selenium
```python
from selenium import webdriver
driver = webdriver.Firefox() # If you want to download something, PhantomJS cannot be used
driver.get(url) 
```
PhantomJSを使う場合は、homebrewでインストール可能。[ここ](https://github.com/Shusei-E/Code_Tips/blob/master/Python/BeautifulSoup.md#phantomjs)にも情報あり。

## Table of Content
1. [クリック](#クリック)
2. [埋め込みPDFへの対処](#埋め込みPDFへの対処)

## クリック
```python
driver.find_element_by_id("ctl00_ContentPlaceHolder1_showRelAggreement_imgExport").click()
driver.find_element_by_link_text("Click This").click() 
```

## 埋め込みPDFへの対処
[この](http://www.un.org/ga/search/view_doc.asp?symbol=A/65/PV.22)サイトのように、フレームの一つにPDFが埋め込まれている。Chromeでソースをみると、frameのアドレスらしきものがあるが、これを読み込んでも何も表示されない。
```html
<frameset rows="30,*">
  <frame src="doc_top.asp?symbol=A/65/PV.22&amp;Lang=E&amp;referer=/english/" name="topFrame" scrolling="NO" noresize title="Language versions">
  <frame src="http://daccess-ods.un.org/access.nsf/Get?Open&amp;DS=A/65/PV.22&amp;Lang=E" name="mainFrame" title="PDF Document">
```
そこで、Chromeの「検証」(フレームの上で右クリック)を使うと、以下のようになっていることがわかる。どうやら、これがPDFを表示させているフレーム部分に対応するようである。
```python
<frame src="http://daccess-ods.un.org/access.nsf/Get?Open&amp;DS=A/65/PV.22&amp;Lang=E" name="mainFrame" title="PDF Document">
<html>
  <body style="background-color: rgb(38,38,38); height: 100%; width: 100%; overflow: hidden; margin: 0"><embed width="100%" height="100%" name="plugin" id="plugin" src="https://documents-dds-ny.un.org/doc/UNDOC/GEN/N10/552/76/PDF/N1055276.pdf?OpenElement" type="application/pdf" internalinstanceid="221" title="">
  </body>
</html>
```
そこで、driverを使って移動させる。そのうえで、soupを表示させる。
```python
driver.switch_to.frame("mainFrame")
data = driver.page_source.encode('utf-8')
soup = BeautifulSoup(data, "html.parser")
```
すると、
```html
<html><head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type">
<meta content="1; URL=https://documents-dds-ny.un.org/doc/UNDOC/GEN/N96/862/83/PDF/N9686283.pdf?OpenElement" http-equiv="refresh">
(...省略...)
</html>
```
となって、PDFのリンク先がわかる。

しかし、これを以下のようにしても保存できない。
```python
pdf_url = "https://documents-dds-ny.un.org/doc/UNDOC/GEN/N96/862/83/PDF/N9686283.pdf?OpenElement"
urllib.request.urlretrieve(pdf_url, "test.pdf")
```
