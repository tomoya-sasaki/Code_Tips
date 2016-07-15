# Tesseract

## Table of Contents
1. [Install](#install)
2. [Use in Python](#use-in-python)

### Install
`homebrew` can be used.

### Use in Python
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

        txt = tool.image_to_string(
            PI.open(io.BytesIO(img_page.make_blob("jpeg"))),
            lang="eng",
            builder=pyocr.builders.TextBuilder()
        )
        final_text.append(txt)
        
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
