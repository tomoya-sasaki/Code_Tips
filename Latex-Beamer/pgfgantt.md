# pgfgantt
良い感じのスケジュール表を作る

## 使用上の注意
`listings`と相性が悪いので、関連箇所をプリアンブルから消す。

## 年間スケジュール
```tex
\begin{ganttchart}[hgrid]{1}{31}
  \gantttitle{2016}{31}\\
  \gantttitle{4月}{2}\gantttitle{5月}{2}\gantttitle{6月}{2}\gantttitle{7月}{2}\gantttitle{8月}{2}\gantttitle{9月前半}{3}\gantttitle{9月後半}{3}\gantttitle{10月前半}{3}\gantttitle{10月後半}{3}\gantttitle{11月前半}{3}\gantttitle{11月後半}{3}\gantttitle{12月前半}{3}\\
  \ganttbar{GRE Verval}{1}{7}\ganttbar{}{13}{25} \\
  \ganttbar{GRE Writing}{15}{25} \\
  \ganttbar{GRE Quant}{6}{8}\ganttbar{}{14}{15}\ganttbar{}{17}{18}\ganttbar{}{22}{25}\\
  \ganttmilestone{GRE 受験}{15}\ganttmilestone{}{18}\ganttmilestone{}{25}\\
  \ganttbar{TOEFL}{9}{11}\\
  \ganttmilestone{TOEFL 受験}{9}\ganttmilestone{}{10}\ganttmilestone{}{11}\\
  \ganttbar{その他準備}{23}{31}
\end{ganttchart}
```
