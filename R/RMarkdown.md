# R Markdown
Run from Terminal: `Rscript -e "rmarkdown::render('File.Rmd')"`

## Table of Contents
1. [日本語を使用する際の設定](#日本語を使用する際の設定)
2. [Chunk Options](#chunk-options)

## 日本語を使用する際の設定
この部分のインデントは、タブではなくスペースで行わないといけないことに注意。Vimでは改行した時に自動にタブでインデントが入ってしまう。
```rmd
---
title: 'Title'
author: "名前"
date: "`r format(Sys.time(), '%d %B, %Y')`"
output:
 pdf_document:
  latex_engine: xelatex
  fig_width: 5
  fig_height: 4
  number_sections: true
  toc: true
  toc_depth: 2
graphics: yes
mainfont: YuMincho
monofont: Ricty Discord
---
\fontsize{9}{12}
\hrulefill
```
`\fontsize{文字サイズ}{行間}`なのかな？
`monofont: Ricty Discord`といった行を追加して等幅日本語フォントの指定をしておかないと、コードブロックの日本語が表示されない。


### ggplot2



## Chunk Options
[Reference](http://d.hatena.ne.jp/teramonagi/20130615/1371303616)   
Chunk optionsにはRの関数や評価結果の値を代入することが可能。



| オプション       | デフォルト値 | 型              | 意味                                                                                                                      |
|------------------|--------------|-----------------|---------------------------------------------------------------------------------------------------------------------------|
| eval             | TRUE         | logical         | chunkを実際にRのコードとして評価するか                                                                                    |
| echo             | TRUE         | logical/numeric | chunkを出力として表示するか否か。echo=2:3等ともかけてこの場合2・3番目のコードのみ出力。echo=-3だと3番目のコード以外出力。 |
| warning          | TRUE         | logical         | chunkに対する警告を表示させるか否か                                                                                       |
| error            | TRUE         | logical         | chunkに対するエラーを表示させるか否か                                                                                     |
| prompt           | FALSE        | logical         | プロンプトの文字(例：>)を実行したコードの結果として追加するか否か                                                         |
| include          | TRUE         | logical         | chunk・実行結果を出力(通常、RStudio使ってるならHTML）に入れるか否か。これをFALSEにしてもRのコードは実行される点に注意。   |
| fig.width/height | 7            | numeric         | 図のプロットのサイズ、"出力"画像のサイズであり、貼り付けのサイズではない点に注意（単位：インチ）                          |
| fig.cap          | -            | character       | 図のキャプション    |
| fig.align        |              | character       | `fig.align = 'center'` |
