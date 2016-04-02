# Beamer-Poster
Make poster with [latex-beamerposter](https://github.com/deselaers/latex-beamerposter) package.  
Modified style files are:
1. [Original with slight modification](https://gist.github.com/Shusei-E/0c13b64ac31d8fc2cce395e2f892325e)
2. [Left aligned title](https://gist.github.com/Shusei-E/39d6d5bc86f46acf2b1b6fc06193aa91)


# Table of Contents
1. [Graphics related error such as BoundingBox](#graphics-related-error-such-as-boundingbox)
2. [Manually insert a subtitle](#manually-insert-a-subtitle)

### Graphics related error such as BoundingBox
Set `dvipdfmx` option in document class. `\documentclass[dvipdfmx, final,hyperref={pdfpagelabels=false}]{beamer}`  
[Reference](http://qiita.com/zr_tex8r/items/442b75b452b11bee8049)

### Manually insert a subtitle
Comment out `\usebeamercolor{title in headline}{\color{fg}\textbf{\Large{YOUR SUBTITLE}}\\[1ex]}` in the stylefile.  
The sample stylefile is [here](https://gist.github.com/Shusei-E/39d6d5bc86f46acf2b1b6fc06193aa91)
