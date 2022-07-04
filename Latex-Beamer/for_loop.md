# For loop

Use `pgffor`.
```tex
\foreach \n in {0,...,10}{do something}
\foreach \n in {Japan,UK,US}{\n.\par}
```

```tex
\foreach \n/\c in {1/Japan,2/Germany}{
  \begin{frame}{GDP: \c}
    \begin{figure}[!htb]
    \centering
      \includegraphics[width=0.73 \linewidth]{GDP_\n.png}
    \end{figure}
  \end{frame}
}
```
