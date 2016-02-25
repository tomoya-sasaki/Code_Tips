#Beamer

# Table of Contents
1. [脚注のサイズの調整](#脚注のサイズの調整)
2. [図の挿入](#図の挿入)
3. [少し空白を入れる](#少し空白を入れる)
4. [使いやすそうなスタイル](#使いやすそうなスタイル) 
5. [右下のナビゲーションバーを消す](#右下のナビゲーションバーを消す)
6. [画像を2枚並べて表示](#画像を2枚並べて表示) 

### 脚注のサイズの調整 
([参考](http://tex.stackexchange.com/questions/21741/how-do-i-change-footnote-font-size-in-beamer-presentation))
```tex
\let\oldfootnotesize\footnotesize
\renewcommand*{\footnotesize}{\oldfootnotesize\tiny}
```
これを、`\begin{document}`の前に挿入する。

### 図の挿入
`\includegraphics[width=6cm]{Fig1.pdf}`<br>
だけで良さそう。

### 少し空白を入れる
`\vspace{5mm}`

### 使いやすそうなスタイル 
([参考](https://www.hartwork.org/beamer-theme-matrix/))
```tex
\usetheme{Frankfurt}
\usepackage{beamerthemeshadow}
```

### 右下のナビゲーションバーを消す
`\usenavigationsymbolstemplate{}`

### 画像を2枚並べて表示
[こちら](https://gist.github.com/m-note/b319d0f643d28233d152)を参考にすること
