# Latex / Beamer
[LaTex Color Chart](http://latexcolor.com/)  
For converting figures, ToyViewer is the best option.

* Section Symbol: `\S`

## Compile from Terminal
If you have latexmk file,
```terminal
$ latexmk -pdfdvi main.tex ; rm *.aux *.bbl *.blg *.dvi *.fdb_latexmk *.lof *.lol *.log *.lot *.out *.gz *.toc
```
It's faster if you don't remove temporary files. You might use `$ texcount *.tex */*.tex` as well.

## jsarticleで目次の英字書体を変える
`\renewcommand{\headfont}{\bfseries}`

## .styの追加
`/usr/local/texlive/texmf-local/tex/latex/`して`sudo mktexlsr`

## .bstの追加
`/usr/local/texlive/texmf-local/bibtex/bst`に追加して`sudo mktexlsr`
