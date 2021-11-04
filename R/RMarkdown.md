# R Markdown
Run from Terminal: `Rscript -e "rmarkdown::render('File.Rmd')"`

## Table of Contents
1. [日本語を使用する際の設定](#日本語を使用する際の設定)
2. [Chunk Options](#chunk-options)
3. [Inline code](#inline-code)
4. [align](#align)
5. [Hide all code chunks](#hide-all-code-chunks)
6. [read_chunk](#read_chunk)
7. [kable](#kable): [Wrap line](#wrap-line)

## 日本語を使用する際の設定
この部分のインデントは、タブではなくスペースで行わないといけないことに注意。Vimでは改行した時に自動にタブでインデントが入ってしまう。
<pre lang="Rmd">
---
title: "Title"
author: "名前"
date: "`r format(Sys.time(), '%d %B, %Y')`"
output:
 pdf_document:
  latex_engine: xelatex
  number_sections: true
  toc: true
  toc_depth: 2
graphics: yes
mainfont: YuMincho
monofont: Ricty Discord
header-includes:
- \usepackage{booktabs}
- \usepackage{makecell}
---
\fontsize{9}{12}
\hrulefill

```{r, warning=FALSE, message=FALSE, fig.align='center'}
library(tidyverse)
my_theme <- function(legend.position = "right") {
  p <- theme_bw() +
        theme(plot.title = element_text(hjust = 0.5),
              panel.grid = element_blank(),
              text = element_text(size = 12),
              legend.position = legend.position)
}

make_table <- function(obj, caption = NULL, digit = 3) {
  knitr::kable(obj, format = "latex", caption = caption,
               digit = digit, booktabs = TRUE) %>% 
      kableExtra::kable_styling(position = "center", latex_options = "hold_position")
}
```
</pre>

`\fontsize{文字サイズ}{行間}`なのかな？
`monofont: Ricty Discord`といった行を追加して等幅日本語フォントの指定をしておかないと、コードブロックの日本語が表示されない。


Figure settings:
```rmd
knitr::opts_chunk$set(echo = TRUE, cache = FALSE, warning = FALSE, message = FALSE)
knitr::opts_chunk$set(fig.width = 6.5, fig.height = 4.8, out.width="88%")
```


### ggplot2
[Reference](http://ja.stackoverflow.com/questions/33375/rmarkdown-ggplot2%E3%81%A7%E6%97%A5%E6%9C%AC%E8%AA%9E%E3%82%92%E4%BD%BF%E7%94%A8%E3%81%99%E3%82%8B)
```r
``｀{r, dev="quartz_pdf", warning=FALSE}
ggplot(pressure, aes(temperature, pressure)) + geom_point() + 
  xlab("Temperature") + ylab("Pressure") +
  theme_gray(base_family = "YuGo-Medium")
``｀
```

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
| out.width = "90%" |             | numeric         | アウトプットする図のサイズ |

```r
knitr::opts_chunk$set(echo = TRUE, cache = FALSE, warning = FALSE, message = FALSE, 
                      fig.width = 6.5, fig.height = 4.8, out.width="92%")
```

## Inline code
```md
`r CODE`
```
When you use values, you might need to put `$`,
```md
$`r CODE RETUNS VALUE`$
```

## align
Do not have to use `$$`. Just start with `\begin{align}`.


## Hide all code chunks
```r
knitr::opts_chunk$set(echo=FALSE)
```
in the first code chunk.

## read_chunk
R file
```r
## @knitr test-a --------
1 + 1

## ---- test-b --------
if (TRUE) {
  plot(cars)
}
```

<pre><code>Read an external script:

```{r, include=FALSE, cache=FALSE}
knitr::read_chunk('test.R')
```

Now we can use the code, e.g.,

```{r, test-a, echo=FALSE}

```

```{r, test-b, fig.height=4}

```
</code></pre>


## kable
```r
library(kableExtra)
knitr::kable(res, format = "latex", digit = 3, booktabs = TRUE) %>% 
    kable_styling(position = "center")
```

### Wrap line
```r
kableExtra::column_spec(column = 1, latex_column_spec = "c|p{12cm}")
```
