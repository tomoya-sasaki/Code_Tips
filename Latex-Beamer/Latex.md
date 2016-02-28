# Latex

## Table of Contents
1. <a href="https://gist.github.com/Shusei-E/8c56c276875ec798ab49" target="_blank">レポートテンプレ</a>と<a href="https://gist.github.com/Shusei-E/18389f19f278a2b6e965" target="_blank">卒論テンプレ</a>
2. [写真の挿入](#写真の挿入)
3. [文字サイズ変更](#文字サイズ変更)
4. [Tikzでゲームツリー](#Tikzでゲームツリー)
5. [数式で、式と式の間を広げる](#数式で式と式の間を広げる)
6. [ダブルスペース](#ダブルスペース)
7. [itemizeでbulletを変える](#itemizeでbulletを変える)

### 写真の挿入
```tex
\begin{figure}[!htb]
\centering
\includegraphics[clip,width=15.0cm]{.eps}
\caption{ }
\label{ }
\end{figure}
```

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
