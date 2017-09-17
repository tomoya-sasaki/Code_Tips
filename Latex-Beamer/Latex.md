# Latex
uplatexを使うと良いのかも。jsarticleのオプションとしてuplatexを指定。

## Table of Contents
1. <a href="https://github.com/Shusei-E/Code_Tips/blob/master/Latex-Beamer/Templates/essay.tex" target="_blank">レポートテンプレ</a>と<a href="https://github.com/Shusei-E/Code_Tips/blob/master/Latex-Beamer/Templates/thesis.tex" target="_blank">卒論テンプレ</a>
2. [写真の挿入](#写真の挿入)
   * [図を並べる](#図を並べる)
   * [図の回転](#図の回転)
3. [文字サイズ変更](#文字サイズ変更)
4. [Tikzでゲームツリー](#tikzでゲームツリー)
5. [数式関連](#数式関連)
   * [数式で、式と式の間を広げる](#数式で式と式の間を広げる)
   * [数式の改ページ](#数式の改ページ)
   * [frac色々](#frac色々)
   * [alignの行間](#alignの行間)
   * [記号をまたぐlinebreak](#記号をまたぐlinebreak)
6. [ダブルスペース](#ダブルスペース)
7. [itemizeでbulletを変える](#itemizeでbulletを変える)
8. [横長の表を回転する](#横長の表を回転する)
9. [コードを挿入](#コードを挿入)
10. [図のフォルダの指定](#図のフォルダの指定)
11. [名前を英語に統一](#名前を英語に統一)
12. [箇条書きを左にずらす](#箇条書きを左にずらす)
13. [余白の設定](#余白の設定)
   * [任意の空白](#任意の空白)
14. [2段組](#2段組)
15. [ページをまたぐ表](#ページをまたぐ表)
16. [条件分岐でテキストを変更](#条件分岐でテキストを変更)
17. [ヘッダーとフッター](#ヘッダーとフッター)
18. [箇条書きのスタイル変更](#箇条書きのスタイル変更)
19. [数式コマンドショートカット](#数式コマンドショートカット)
20. [Insert a table of contents](#insert-a-table-of-contents)
21. [引用](#引用)
22. [総ページ数の表示](#総ページ数の表示)

## 写真の挿入
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

pngを挿入するときは、`\documentclass[a4paper,10.5pt,dvipdfmx,uplatex]{jsarticle}`としないとダメだった。

### 図を並べる
```tex
\begin{figure}[htbp]
 \begin{minipage}{0.5\hsize}
  \begin{center}
   \includegraphics[width=0.7 \linewidth]{fig1.pdf}
  \end{center}
  \caption{Fig 1}
  \label{fig:one}
 \end{minipage}
 \begin{minipage}{0.5\hsize}
  \begin{center}
   \includegraphics[width=0.7 \linewidth]{fig2.pdf}
  \end{center}
  \caption{Fig 2}
  \label{fig:two}
 \end{minipage}
\end{figure}
```

### 図の回転
```tex
\includegraphics[width=100mm, angle=90]{fig1.pdf}
```

## 文字サイズ変更
`{\fontsize{9.5pt}{8pt}\selectfont   }`

## Tikzでゲームツリー
[Use style file](https://github.com/Shusei-E/tikz-bayesnet)

### upLatex
`\usepackage[dvipdfmx]{graphicx,xcolor}`として、`documentclass`は`\documentclass[a4paper,10.5pt,uplatex]{jsarticle}`でOK。

### old
`\documentclass[report, 10.5pt, a4paper, oneside, openany, dvipdfmx]{jsbook}`<br>
のように、始めにdivipdfmxを指定して、テンプレにある
`\usepackage[dvipdfmx]{graphicx}`<br>
はコメントアウトしておかないと表示ができなかった (逆にこれがないと`/figures`に入れた図が表示できないこともあったので注意)。

## 数式関連

### 数式で、式と式の間を広げる
`\\[12pt]`のように改行するところで記述
```tex
\begin{eqnarray*} 
\sigma_E &=& \beta, \\[7pt] \sigma_B &=& \pi (1- \beta), \\[7pt]
\sigma_M &=& (1-\pi) (1- \beta).  
\end{eqnarray*}
```

### 数式の改ページ
プリアンブル中に、
```tex
\allowdisplaybreaks[1]
```
数字は0~4まで指定できる。値が大きいほど規制が緩くなり、改ページしやすくなる。

### frac色々
|      Code      |               Style              |
|:--------------:|:--------------------------------:|
| `\frac{a}{b}`  | スタイルに合わせた出力           |
| `\tfrac{a}{b}` | テキストスタイルの分数を出力     |
| `\dfrac{a}{b}` | ディスプレイスタイルの分数を出力 |

### alignの行間
プリアンブルに以下を記述
```tex
\jot=3.5mm
```

### 記号をまたぐlinebreak
```tex
  \frac{\partial \cL}{\partial q(\bz)} &= \frac{\partial}{\partial q(\bz)} \left[ \iint q(\bz) q(\btheta) \ln p(\bx, \bz, \btheta) d\bz d\btheta - \iint q(\bz)q(\btheta) \ln q(\bz) d\bz d\btheta \right.\\
  &\qquad \qquad \quad \left. \iint q(\bz) q(\btheta) \ln q(\btheta) d\bz d\btheta \right] + \lambda \left( \int q(\bz) d\bz - 1 \right)
```

## ダブルスペース
```tex
%--行間の設定
\usepackage{setspace}
\doublespacing
```
## itemizeでbulletを変える
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

## コードを挿入
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
  breakatwhitespace=true,
  tabsize=3,
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
\begin{lstlisting}[language=Python, caption=Python example] % You can use `c++` or `r`
\end{lstlisting}
```
[こちら](https://www.sharelatex.com/learn/Code_listing)も参考になる。

Probably you need this:
```tex
\renewcommand{\textasteriskcentered}{\ensuremath{*}}
```

## 図のフォルダの指定
```latex
\graphicspath{{D:/LATEX/Reports@IIT/figures/}}
\graphicspath{{subdir1/}{subdir2/}{subdir3/}{subdirn/}}
```

## 名前を英語に統一
```tex
%名前を英語に統一
\renewcommand{\refname}{References}
\renewcommand{\contentsname}{Contents}
\renewcommand{\figurename}{Figure }
\renewcommand{\tablename}{Table }
\renewcommand{\listfigurename}{Figure List}
\renewcommand{\listtablename}{Table List}
\renewcommand{\appendixname}{Appendix }
\renewcommand{\prechaptername}{Chapter } 
\renewcommand{\postchaptername}{}  
```

## 箇条書きを左にずらす
```tex
\usepackage{enumitem}
\begin{itemize}[leftmargin=-9mm]
  \item[$\cdot$] There are $M$ documents. 
  \item The number of words in the $d$-th document is $n_d$
  \item Topic distribution $\theta_{d,k}$: Probability that topic $k$ appears in document $d$
\end{itemize}
```
beamerの、場合は
```tex
\usepackage{enumitem}
\setitemize{label=\usebeamerfont*{itemize item}%
  \usebeamercolor[fg]{itemize item}
  \usebeamertemplate{itemize item}}
```

## 数式の左寄せ
```tex
\usepackage{nccmath} 
\begin{fleqn}[20pt]
\begin{align*}
a&=b\\
b&=c
\end{align*} 
\end{fleqn}
```
## 余白の設定
```tex
\usepackage[truedimen,margin=15truemm]{geometry}
```
```tex
\usepackage[truedimen,top=25truemm,bottom=25truemm,left=25truemm,right=25truemm]{geometry}
```
別の例
```tex
\setlength{\topmargin}{20mm}
\addtolength{\topmargin}{-1in}
\setlength{\oddsidemargin}{20mm}
\addtolength{\oddsidemargin}{-1in}
\setlength{\evensidemargin}{15mm}
\addtolength{\evensidemargin}{-1in}
\setlength{\textwidth}{170mm}
\setlength{\textheight}{254mm}
\setlength{\headsep}{0mm}
\setlength{\headheight}{0mm}
\setlength{\topskip}{0mm}
```

### 任意の空白
```tex
\vspace{-4ex} % 減らす
\title{\vspace{-3ex}My Title} % これもできる
```

## 2段組
```tex
\usepackage{multicol}
\begin{multicols}{2}

\end{multicols}
```
## ページをまたぐ表
`\usepackage{ltablex}`を使うことで、tabluarx環境下で、longtable環境も使えるようになる。
```tex
\setlongtables %これでlongtable環境を使えるようになる。
\begin{tabularx}{\linewidth}{|X|X|} %表の中身はtabularx環境と同じ書き方。
\hline
項目 & 説明 \\
\hline
\endhead %longtable環境と同様にendheadやendfootも使える
%以下、表の中身。
A&B\\
C&D\\
D&B\\
……
V&X。\\
\hline
\end{tabularx}
```
## 条件分岐でテキストを変更
```tex
\usepackage{ifthen}
\newboolean{long}   

\begin{document}

\setboolean{long}{false}   
\ifthenelse{\boolean{long}}{long version}{short version} 

\setboolean{long}{true}
\ifthenelse{\boolean{long}}{long version}{short version}  
\end{document} 
```

## ヘッダーとフッター
```tex
% Header
\usepackage{fancyhdr}
\pagestyle{fancy}
\fancyhead[C]{center}
\fancyhead[L]{}
\fancyhead[R]{}
\begin{document}
```
`\maketitle`があるページはスタイルが`plain`になってしまうので、`\maketitle\thispagestyle{fancy}`のようにしないと意図通りにならないことも。
```tex
% Header
\usepackage{fancyhdr}
\pagestyle{fancy}{
  \chead{Center}
  \lhead{}
  \rhead{}
}
\fancypagestyle{firststyle}{\renewcommand{\headrulewidth}{0pt} \fancyhead[C]{}} % No line for the first page
\begin{document}
\title{Title}
\author{Author}
\date{\today}
\maketitle\thispagestyle{firststyle}
```

特定のページだけ:
```tex
\usepackage{fancyhdr}
\fancypagestyle{firststyle}
{
   \chead{\textbf{Your Header}}
}
\begin{document}
```
`\thispagestyle{firststyle}`を該当箇所で使う (`\maketitle`, `\chapter`の後じゃないとダメみたい)。


## 箇条書きのスタイル変更
```tex
% itemize
\usepackage{enumitem}
\setlistdepth{20}
\renewlist{itemize}{itemize}{20}
\setlist[itemize]{label=\textbullet}
\setlist[itemize,2]{label=\(\circ\)}
\setlist[itemize,3]{label=\(\diamond\)}
\setlist[itemize,4]{label=\(\triangledown\)}
\setlist[itemize,5]{label=\(\triangleright\)}
\setlist[itemize,6]{label=\(\vartriangle\)}
\setlist[itemize,8]{label=\(\circ\)}
\setlist[itemize,9]{label=\(\diamond\)}
\setlist[itemize,10]{label=\(\triangledown\)}
\setlist[itemize,11]{label=\(\triangleright\)}
\setlist[itemize,12]{label=\(\vartriangle\)}
\setlist[itemize,14]{label=\(\circ\)}
\setlist[itemize,15]{label=\(\diamond\)}
\setlist[itemize,16]{label=\(\triangledown\)}
\setlist[itemize,17]{label=\(\triangleright\)}
\setlist[itemize,18]{label=\(\vartriangle\)}
\setlist[itemize,20]{label=\(\circ\)}
```

## 数式コマンドショートカット
`\begin{document}`の後で定義

```tex
\newcommand{\E}{\mathbb{E}}
\newcommand\dist{\buildrel\rm d\over\sim}
\newcommand\ind{\stackrel{\rm indep.}{\sim}}
\newcommand\iid{\stackrel{\rm i.i.d.}{\sim}}
\newcommand\logit{{\rm logit}}
\renewcommand\r{\right}
\renewcommand\l{\left}

\newcommand{\cD}{\mathcal{D}}
\newcommand{\cN}{\mathcal{N}}
\newcommand{\cS}{\mathcal{S}}
\newcommand{\cY}{\mathcal{Y}}
\newcommand{\btheta}{\boldsymbol{\theta}}
\newcommand{\bbeta}{\boldsymbol{\beta}}
\newcommand{\boldeta}{\boldsymbol{\eta}}
\newcommand{\balpha}{\boldsymbol{\alpha}}
\newcommand{\bsigma}{\boldsymbol{\sigma}}
\newcommand{\bphi}{\boldsymbol{\phi}}
\newcommand{\bpsi}{\boldsymbol{\psi}}
\newcommand{\bh}{\mathbf{h}}
\newcommand{\bv}{\mathbf{v}}
\newcommand{\bA}{\mathbf{A}}
\newcommand{\bB}{\mathbf{B}}
\newcommand{\bZ}{\mathbf{Z}}
\newcommand{\bW}{\mathbf{W}}
\newcommand{\bX}{\mathbf{X}}
\newcommand{\bY}{\mathbf{Y}}
\newcommand{\rmDir}{{\rm Dir}}
\newcommand{\rmMulti}{{\rm Multi}}

\newcommand{\blurb}[1]{\footnotesize \flushleft #1}
\newcommand{\pre}[1]{\texttt{#1}}
\newcommand{\R}{\textbf{\textsf{R}}}

\newcommand{\argmax}{\operatornamewithlimits{argmax}}
\newcommand{\argmin}{\operatornamewithlimits{argmin}}
```

## Insert a table of contents
プリアンブル (間隔の調整):
```tex
%--Table of Contents
\usepackage{tocloft}
\cftsetindents{section}{0em}{2em}
\cftsetindents{subsection}{3em}{2em}
\cftsetindents{subsubsection}{5em}{3em}
```

```tex
\noindent\rule{17.5cm}{1.7pt}
\vspace{-1.3cm}
\tableofcontents
\noindent\rule{17.5cm}{1.7pt}
```
Modify depth:
```tex
\setcounter{tocdepth}{3}
```

## 引用
```tex
\citep{jon90} %⇒ (Jones et al. 1990)
\citep*{jon90} %⇒ (Jones, Baker, and Williams 1990)
\citep[pp.36-38]{Diamond11} %⇒ (Diamond 2011, pp.36-38)
\citep[see][p.220]{Andrews07} => (see Andrews 2007, p.220)
\citep[cf.][]{Andrews07} => (cf. Andrews 2007)

\citep{jon90,jon91} %⇒ (Jones et al. 1990, 1991)

\citetext{priv.\ comm.} %⇒ (priv. comm.)

\citet{jon90} %⇒ Jones et al. (1990)
\citeyearpar{jon90} %⇒ (1990)
\citeauthor{jon90} %⇒ Jones et al.
\citeauthor*{jon90} %⇒ Jones, Baker, and Williams

% Multiple citation:
\citet{jon90,jam91}
\citep{jon90,jam91}
```

## 総ページ数の表示
```tex
% Header
\usepackage{lastpage}
\usepackage{fancyhdr}
\pagestyle{fancy}{
  \chead{Center}
  \lhead{}
  \rhead{}
  \cfoot{\thepage/\pageref{LastPage}} % Pagenum / Total page
}
\fancypagestyle{firststyle}{\renewcommand{\headrulewidth}{0pt} \fancyhead[C]{}}
%-----------------
\begin{document}

\title{Title}
\author{Author}
\date{\today}
\maketitle\thispagestyle{firststyle}
```
