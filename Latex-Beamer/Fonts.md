# Latexでフォントを変更する

## Pxchfon
[こちら](http://zrbabbler.sp.land.to/pxchfon.html#ssec-environ)のPxchfonが一番簡単そうだった

## 日本語
### 一番簡単な方法
`pxchfon.sty`と使いたいフォントを`.tex`と同じフォルダに入れる。  
プリアンブルで以下のように記す。
```tex
\usepackage[noalphabet]{pxchfon}
\setminchofont[0]{TsukushiAMaruGothic.ttc} 
\setgothicfont[0]{TsukushiAMaruGothic.ttc}  
```

## 欧文
