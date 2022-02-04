# Beamer
* `\pause`をしていても、`\documentclass[handout]{beamer}`とすれば作成時に快適

## Table of Contents
1. <a href="https://github.com/Shusei-E/Code_Tips/tree/master/Latex-Beamer/Templates" target="_blank">全体のテンプレ</a>
2. [Beamer Slide](#beamer-slide)
3. [ボックス](#ボックス)
4. [2段組](#2段組)
5. [このセクションの内容](#このセクションの内容)
6. [脚注のサイズの調整](#脚注のサイズの調整)
7. [図の挿入](#図の挿入)
    * [図の切り替え](#図の切り替え)
8. [少し空白を入れる](#少し空白を入れる)
9. [使いやすそうなスタイル](#使いやすそうなスタイル) 
10. [右下のナビゲーションバーを消す](#右下のナビゲーションバーを消す)
11. [スライド番号を右下に入れる](#スライド番号を右下に入れる)
12. [画像を2枚並べて表示](#画像を2枚並べて表示) 
13. [Citation and Reference](#citation-and-reference)
14. [Hide Appendix and References](#hide-appendix-and-references)
15. [上部のナビゲーションバーを消す](#上部のナビゲーションバーを消す)
16. [箇条書き](#箇条書き)
    * [箇条書きを左にずらす](#箇条書きを左にずらす)
    * [間隔の調整](#間隔の調整)
17. [図の左寄せ](#図の左寄せ)
18. [これまでの表示を消しつつ切り替え](#これまでの表示を消しつつ切り替え)
19. [Hyper link](#hyper-link)
20. [Code](#code)
21. [フレームの改ページ](#フレームの改ページ)
22. [アスペクト比](#アスペクト比)
23. [少しずつ表示](#少しずつ表示)


## Beamer Slide
```tex
\begin{frame}[fragile]
\frametitle{Title} 

\begin{itemize}
\item 
\end{itemize}

\begin{lstlisting}

\end{lstlisting}

\end{frame}
```
ちなみに、<br>
`\begin{frame}<オーバーレイ>[デフォルトオーバーレイ][オプション]{タイトル}{サブタイトル}`<br>
となっている。


## ボックス
```tex
\begin{block}{} %blue

\end{block}

\begin{alertblock}{} %red

\end{alertblock}

\begin{exampleblock}{} %green

\end{exampleblock}
```

## 2段組
```tex
\begin{columns}[T] % align columns
\begin{column}{.48\textwidth}
Left Part
\end{column}
\hfill
\begin{column}{.48\textwidth}
Right Part
\end{column}
\end{columns}
```
Vertical line: `\vrule{}` between `\end{column}` and `\begin{column}`.

## このセクションの内容
```tex
\begin{frame}<beamer>
\frametitle{この章の内容}
\tableofcontents[currentsection]
\end{frame}
```

## 脚注のサイズの調整 
([参考](http://tex.stackexchange.com/questions/21741/how-do-i-change-footnote-font-size-in-beamer-presentation))
```tex
\let\oldfootnotesize\footnotesize
\renewcommand*{\footnotesize}{\oldfootnotesize\tiny}
```
これを、`\begin{document}`の前に挿入する。

## 図の挿入
`\includegraphics[width=6cm]{Fig1.pdf}`<br>
だけで良さそう。

```tex
\begin{figure}
    \centering
    \includegraphics[width=0.8 \linewidth]{fig.png}
\end{figure}
```

### 図の切り替え
Simple:
```tex
\includegraphics<1>{A}
\includegraphics<2>{B}
\includegraphics<3>{C}
```

```tex
\begin{figure}
    \begin{overprint}
    \onslide<1>\includegraphics{./figure1.png}
    \onslide<2>\includegraphics{./figure2.png}
    \onslide<3>\includegraphics{./figure3.png}
    \onslide<4->\includegraphics{./figure4.png}
    \end{overprint}
\end{figure}
```

## 少し空白を入れる
`\vspace{5mm}`

## 使いやすそうなスタイル 
([参考](https://www.hartwork.org/beamer-theme-matrix/))
```tex
\usetheme{Frankfurt}
\usepackage{beamerthemeshadow}
```

## 右下のナビゲーションバーを消す
`\usenavigationsymbolstemplate{}`

## スライド番号を右下に入れる
プリアンブルに`\setbeamertemplate{footline}[frame number]`

## 画像を2枚並べて表示
[こちら](https://gist.github.com/Shusei-E/8536241e264b976acd6b)を参考にすること

## Citation and Reference
プリアンブルには、
```tex
\usepackage{silence,lmodern} % 警告を表示しない
\usepackage[style=authoryear,backend=biber]{biblatex}
\addbibresource{ref.bib}
\WarningFilter{biblatex}{Patching footnotes failed}
```
引用する際には、
```tex
Test\textcite{Alesina2002} % Alesina and Weder (2002)
Test\autocite{Acemoglu2001} % (Acemoglu and Robinson 2001)
```
引用文献一覧のスライドには、
```tex
\begin{frame}[allowframebreaks]
\frametitle{References}
\renewcommand*{\bibfont}{\scriptsize}
\printbibliography	
\end{frame}
```
エンコードっぽいエラーが発生する場合は、`\usepackage[utf8]{inputenc}`をプリアンブルに追加する。<br>
エラーが出ても、そのまま何回かコンパイルしないといけないのかも。

## Hide Appendix and References
`\appendix`を直前に追加するだけでOK

Page number counting ([Reference](https://tex.stackexchange.com/a/2559/95960)):
```
\begin{document}
\newcommand{\backupbegin}{
   \newcounter{framenumberappendix}
   \setcounter{framenumberappendix}{\value{framenumber}}
}
\newcommand{\backupend}{
   \addtocounter{framenumberappendix}{-\value{framenumber}}
   \addtocounter{framenumber}{\value{framenumberappendix}} 
}


\appendix
\backupbegin
\setbeamertemplate{footline}{} % No page number

\begin{frame}[fragile]
\begin{center}
  {\Huge Appendix}
\end{center}
\end{frame}

\backupend
```

## 上部のナビゲーションバーを消す
`\usetheme{Frankfurt}`の場合は、
```tex
\setbeamertemplate{headline}{}
```
を`\begin{document}`の前に入れる

## 箇条書き

### 箇条書きを左にずらす
```tex
\usepackage{enumitem} %latexならこの行だけでOK
\setitemize{label=\usebeamerfont*{itemize item}%
  \usebeamercolor[fg]{itemize item}
  \usebeamertemplate{itemize item}}
```

### 間隔の調整
プリアンブルに、
```tex
\usepackage{xpatch}
\xpatchcmd{\itemize}
  {\def\makelabel}
  {\setlength{\itemsep}{9pt}\def\makelabel}
```

## 図の左寄せ
```tex
\begin{figure}
  \hspace*{-20mm}
  \includegraphics[width=0.84 \linewidth]{Fig.pdf}\\
\end{figure}
```

## これまでの表示を消しつつ切り替え
```tex
\begin{overprint}
  \onslide<1> a
  \onslide<2> b
  \onslide<3> c
  \onslide<4> d
\end{overprint}
```

## Hyper link
[Reference](https://ja.sharelatex.com/blog/2013/08/16/beamer-series-pt3.html)
```tex
\hyperlink{contents}{\beamerbutton{contents page}}
\hyperlink{columns}{\beamergotobutton{columns page}}
\hyperlink{pictures}{\beamerskipbutton{pictures page}}
\hyperlink{pictures}{\beamerreturnbutton{pictures page}}

[...]

\begin{frame}
\label{contents}
[...]
\end{frame}
```

## Code
```tex
\begin{semiverbatim}
# pty  1   5  11  30  59  71  92 100
# num  1   1   1   2  33 169   1 286
\end{semiverbatim}
```

## フレームの改ページ
```tex
\setbeamertemplate{frametitle continuation}{}  % do not show numbers

\begin{document}
\begin{frame}[allowframebreaks]{Title}
\begin{itemize}
  \item Key points
  \vfill
  \item Theory
\end{itemize}
\end{frame}
```

## アスペクト比
```tex
\documentclass[11pt, dvipdfmx, aspectratio=169, handout]{beamer}
```

## 少しずつ表示
```tex
\only<3->{}
\uncover<3->{}
```
