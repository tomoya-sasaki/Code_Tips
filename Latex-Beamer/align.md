# align
Writing equations using `align`.

### Show one equation number
[Reference](http://tex.stackexchange.com/questions/42726/align-but-show-one-equation-number-at-the-end)
```tex
\usepackage{amsmath}
\newcommand\numberthis{\addtocounter{equation}{1}\tag{\theequation}}
\begin{document}
\begin{align*}
a &=b \\
  &=c \numberthis \label{eqn}
\end{align*}
\end{document}
```
