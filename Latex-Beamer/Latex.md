# Latex
uplatexを使うと良いのかも。jsarticleのオプションとしてuplatexを指定。

## Table of Contents
1. <a href="https://gist.github.com/Shusei-E/8c56c276875ec798ab49" target="_blank">レポートテンプレ</a>と<a href="https://gist.github.com/Shusei-E/18389f19f278a2b6e965" target="_blank">卒論テンプレ</a>
2. [写真の挿入](#写真の挿入)
3. [文字サイズ変更](#文字サイズ変更)
4. [Tikzでゲームツリー](#Tikzでゲームツリー)
5. [数式で、式と式の間を広げる](#数式で式と式の間を広げる)
6. [ダブルスペース](#ダブルスペース)
7. [itemizeでbulletを変える](#itemizeでbulletを変える)
8. [横長の表を回転する](#横長の表を回転する)
9. [コードを挿入](#コードを挿入)

### 写真の挿入
```tex
\begin{figure}[!htb]
\centering
\includegraphics[clip,width=15.0cm]{.eps}
\caption{ }
\label{ }
\end{figure}
```
他の例としては、
```tex
\includegraphics[width=1.2 \linewidth]{fig1.eps}
```
ここで`width=1.2`は、図の幅を元の1.2倍に拡大することを意味する。  
`\linewidth`は縦幅のスケールは横幅に合わせることを意味する。

### 文字サイズ変更
`{\fontsize{9.5pt}{8pt}\selectfont   }`

### Tikzでゲームツリー
`\documentclass[report, 10.5pt, a4paper, oneside, openany, dvipdfmx]{jsbook}`<br>
のように、始めにdivipdfmxを指定して、テンプレにある
`\usepackage[dvipdfmx]{graphicx}`<br>
はコメントアウトしておかないと表示ができなかった。

### 数式で、式と式の間を広げる
`\\[12pt]`のように改行するところで記述
```tex
\begin{eqnarray*} 
\sigma_E &=& \beta, \\[7pt] \sigma_B &=& \pi (1- \beta), \\[7pt]
\sigma_M &=& (1-\pi) (1- \beta).  
\end{eqnarray*}
```

### ダブルスペース
```tex
%--行間の設定
\usepackage{setspace}
\doublespacing
```
### itemizeでbulletを変える
`\item[$\Rightarrow$] Item 1`でOK。Beamer全体に適用するには[こちら](http://tex.stackexchange.com/questions/294067/beamer-change-only-several-bullets-in-the-list)。

### 横長の表を回転する
プリアンブルに<br>
`\usepackage{lscape}`<br>
を記載する。<br>
<br>
次に、横にしたいところで、<br>
```
\begin{landscape}
\end{landscape}
```

### コードを挿入
以下をプリアンブルに:
```tex
\usepackage{listings}
\usepackage{color}
\definecolor{dkgreen}{rgb}{0,0.6,0}
\definecolor{mygray}{rgb}{0.5,0.5,0.5}
\definecolor{mauve}{rgb}{0.58,0,0.82}

\definecolor{codegreen}{rgb}{0,0.6,0}
\definecolor{codegray}{rgb}{0.5,0.5,0.5}
\definecolor{codepurple}{rgb}{0.58,0,0.82}
\definecolor{backcolour}{rgb}{0.95,0.95,0.92}

\lstset{ %
  language= Python, %個別に設定することも可能
  aboveskip=0.1mm, %ここでコードの上の隙間を調整
  belowskip=0.1mm,
  showstringspaces=false,
  columns=flexible,
  keepspaces=true,
  numbers=left,                    
  numbersep=5pt,    
  basicstyle={\small\ttfamily},
  commentstyle={\small\ttfamily},
  breaklines=true,
  breakatwhitespace=true
  tabsize=3
  backgroundcolor=\color{lightgray},   
  commentstyle=\color{codegreen},
  keywordstyle=\color{magenta},
  numberstyle=\tiny\color{codegray},
  stringstyle=\color{codepurple},
  xleftmargin = 1cm,
  framexleftmargin = 1em
}
\usepackage{xcolor}
\usepackage{framed}
\colorlet{shadecolor}{green!8}
```
本文中では次のようにする:
```tex
\begin{lstlisting}[language=Python, caption=Python example]
\end{lstlisting}
```
[こちら](https://www.sharelatex.com/learn/Code_listing)も参考になる。
