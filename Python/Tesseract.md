# Tesseract

## Table of Contents
1. [Install](#install)
2. [Use in Python](#use-in-python)
3. [Caution](#caution)

## Install
`homebrew` can be used.
Training set: check [this](https://github.com/tesseract-ocr/tesseract/wiki#mac-os-x).

Reference:
* [しゃちの備忘録](http://teru0rc4.hatenablog.com/entry/2017/08/09/230046)

## Use in Python
```python
from wand.image import Image
from PIL import Image as PI
import pyocr
import pyocr.builders
import io

tool = pyocr.get_available_tools()[0]
lang = tool.get_available_languages()[24] # "eng"
```
Define function:
```python
def OCR_PDF(file_path):
    image_pdf = Image(filename=file_path, resolution=300)
    image_jpg = image_pdf.convert("jpeg")
    
    final_text = []
    for img in image_jpg.sequence:
        img_page = Image(image=img)
        open_img = PI.open(io.BytesIO(img_page.make_blob("jpeg")))
        
        txt = tool.image_to_string(
        	open_img,
        	lang="eng",
        	builder=pyocr.builders.TextBuilder()
        )
        final_text.append(txt)
        open_img.close()

        
    return(final_text)
```
Use it!
```python
file_path = "65_TJ_en.pdf"
text_list = OCR_PDF(file_path)

save_path = file_path[:-3] + "txt"
with open(save_path, mode='a', encoding='utf-8') as a_file:
    for text in text_list:
        a_file.write(text)
```

## Caution
Cash files (quite large!) are stored in `private/var/tmp`.  
Find `policy.xml`(for example, `/usr/local/etc/ImageMagick-6/policy.xml`), comment out the following part and change the size `<policy domain="resource" name="disk" value="10GB"/>`.  
You can check settings by typing `identify -list resource` in Terminal.  
[Reference](http://qiita.com/nt-uni/items/bb4cc3064a3af857a63e)
