# R Markdown
Run from Terminal: `Rscript -e "rmarkdown::render('File.Rmd')"`

## Table of Contents
1. 日本語を使用する際の設定[#日本語を使用する際の設定]

## 日本語を使用する際の設定
この部分のインデントは、タブではなくスペースで行わないといけないことに注意。Vimでは改行した時に自動にタブでインデントが入ってしまう。
```rmd
---
title: 'Title'
author: "名前"
date: "2/14/2017"
output:
 pdf_document:
  latex_engine: xelatex
  fig_width: 5
  fig_height: 4
  number_sections: true
  toc: true
  toc_depth: 2
mainfont: Meiryo
---
```
