# dirtree

## Table of Contents

## Sample
```tex
% Directory tree
\usepackage{dirtree}
%-----------------
\begin{document}
\dirtree{%
.1 /Shusei\_Replication.
.2 Data\DTcomment{Data for analysis}.
.2 LatexOutput\DTcomment{Results figures and tables}.
.3 fig2.pdf.
.3 fig3.pdf.
.3 table1.tex.
.3 table2.tex.
.3 table3.tex.
.3 table4.tex.
.3 table5.tex.
.3 table7.tex.
.3 table8.tex.
.2 rawdata.
.2 analysis.R\DTcomment{Main analysis}.
.2 Conveter\_Stata-R.py\DTcomment{Convert some Stata codes to R automatically (explain later)}.
.2 Replication\_DataSet.R\DTcomment{Create dataset}.
.2 report.pdf\DTcomment{This file}.
.2 report.tex\DTcomment{Latex source}.
}
\end{document}
```
