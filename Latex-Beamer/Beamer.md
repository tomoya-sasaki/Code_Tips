#Beamer

# Table of Contents
1. <a href="https://gist.github.com/Shusei-E/12caa6d176d7b07d393e" target="_blank">全体のテンプレ</a>
2. [Beamer Slide](#beamer-slide)
3. [ボックス](#ボックス)
4. [2段組](#2段組)
5. [このセクションの内容](#このセクションの内容)
6. [脚注のサイズの調整](#脚注のサイズの調整)
7. [図の挿入](#図の挿入)
8. [少し空白を入れる](#少し空白を入れる)
9. [使いやすそうなスタイル](#使いやすそうなスタイル) 
10. [右下のナビゲーションバーを消す](#右下のナビゲーションバーを消す)
11. [スライド番号を右下に入れる](#スライド番号を右下に入れる)
12. [画像を2枚並べて表示](#画像を2枚並べて表示) 
13. [Citation and Reference](#citation-and-reference)
14. [Hide Appendix and References](#hide-appendix-and-references)
15. [上部のナビゲーションバーを消す](#上部のナビゲーションバーを消す)
16. [箇条書きを左にずらす](#箇条書きを左にずらす)

### Beamer Slide
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


### ボックス
```tex
\begin{block}{} %blue

\end{block}

\begin{alertblock}{} %red

\end{alertblock}

\begin{exampleblock}{} %green

\end{exampleblock}
```

### 2段組
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

## 上部のナビゲーションバーを消す
`\usetheme{Frankfurt}`の場合は、
```tex
\setbeamertemplate{headline}{}
```
を`\begin{document}`の前に入れる

## 箇条書きを左にずらす
```tex
\usepackage{enumitem} %latexならこの行だけでOK
\setitemize{label=\usebeamerfont*{itemize item}%
  \usebeamercolor[fg]{itemize item}
  \usebeamertemplate{itemize item}}
```
