# Latexでフォントを変更する

## Pxchfon
[こちら](http://zrbabbler.sp.land.to/pxchfon.html#ssec-environ)のPxchfonが一番簡単そうだった

## 日本語
### 一番簡単な方法
`pxchfon.sty`と使いたいフォントを`.tex`と同じフォルダに入れる。  
プリアンブルで以下のように記す。
```tex
%日本語フォント
\usepackage[noalphabet]{pxchfon}
\setminchofont[0]{TsukushiAMaruGothic.ttc} 
\setgothicfont[0]{TsukushiAMaruGothic.ttc}  
```

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
