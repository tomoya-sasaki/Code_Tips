# Images

## Table of Contents
1. [PDF to PNG](#pdf-to-png)


## PDF to PNG
```py
from pdf2image import convert_from_path, convert_from_bytes
import tempfile

with tempfile.TemporaryDirectory() as path:
    images = convert_from_path(file, output_folder=path, dpi=700)
    img = images[0]
    img.save(new_filename, 'png')
```
