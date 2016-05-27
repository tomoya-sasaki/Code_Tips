# Latexでフォントを変更する

## Pxchfon
[こちら](http://zrbabbler.sp.land.to/pxchfon.html#ssec-environ)のPxchfonが一番簡単そうだった。スタイルファイルの置き方は、[こちら](http://oku.edu.mie-u.ac.jp/tex/mod/forum/discuss.php?d=1091)を参考にすること。

## フォントをLatexに認識させる
`Klee.ttc`を使いたい場合 ([参考](http://www.yo.rim.or.jp/~nohara/tex0.html)、Yosemiteの場合)
```terminal
$ sudo mkdir -p /usr/local/texlive/texmf-local/fonts/opentype/Klee/
$ cd /usr/local/texlive/texmf-local/fonts/opentype/Klee/
$ sudo ln -fs "/Users/S/Library/Fonts/Klee.ttc" ./Klee.ttc
$ sudo mktexlsr
```

## 日本語
### 一番簡単な方法
`pxchfon.sty`と使いたいフォントを`.tex`と同じフォルダに入れる(フォントをTexに認識させる場合は上を参照)。  
プリアンブルで以下のように記す。
```tex
%日本語フォント
\usepackage[noalphabet]{pxchfon}
\setminchofont[0]{TsukushiAMaruGothic.ttc} 
\setgothicfont[0]{TsukushiAMaruGothic.ttc}  
```
`Klee`も良い。その場合は`[1]`の方が見やすいかも。

## 欧文
### 一番簡単な方法
`pxchfon`を完全インストールするのは面倒なので、`jsarticle`を使用し、以下のように設定
```tex
%フォント
\usepackage[noalphabet]{pxchfon}
\setminchofont[0]{TsukushiAMaruGothic.ttc} 
\setgothicfont[0]{TsukushiAMaruGothic.ttc}  
\renewcommand{\familydefault}{lmss}
```

## 数式
上のスタイルに合いそうなものとしては、
```tex
%数学用のフォント
\usepackage{amsmath} 
\usepackage{amssymb}
\usepackage{amsfonts} 
\usepackage[math]{kurier}
```
