# align
Writing equations using `align`.

## Show one equation number
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

## いい感じに揃える
* [Reference 1](https://tex.stackexchange.com/questions/203559/aligning-multiple-places-in-equations-using-align)
* [Reference 2](http://www.biwako.shiga-u.ac.jp/sensei/kumazawa/tex/form027.html)

```tex
\begin{alignat}{2}
\pi_7 &= \nu_7 \cdot \psi_7  & {\rm Stop\ at\ Node\ 7}\\
      &\ \ \times (1 - \psi_6)  & {\rm Pass\ Node\ 6}\\
      &\ \ \times (1 - \nu_3) \cdot \psi_3 \cdot (1 - \psi_2)   &{\rm Pass\ Node\ 3}\\
      &\ \ \times (1 - \nu_1) & {\rm Pass\ Node\ 1}
\end{alignat}
```
