# Tikz

## Table of Contents
1. [設定](#設定)
2. [モデルを書く](#モデルを書く)


## 設定
### New
[こちら](https://github.com/Shusei-E/Code_Tips/blob/master/Latex-Beamer/Latex.md#tikzでゲームツリー)を参考にすること。

### Old
```tex
\documentclass[a4paper,10.5pt,dvipdfmx]{jarticle}
```
としないと、コンパイル時にエラーになる。`\usepackage[dvipdfmx]{graphicx}`は使わない。

## モデルを書く
[tikz-bayesnet](https://github.com/jluttine/tikz-bayesnet)が便利。
```tex
%tikz
\usepackage{tikz}
\usetikzlibrary{bayesnet}
%-----------------
\begin{document}
\begin{figure}[H]
\centering
\begin{tikzpicture}
  % Nodes

  \node[obs]                   (w)      {$w$} ; %
  \node[latent, left=of w]    (z)      {$z$} ; %
  \node[latent, above left=1.2 of z]    (theta)  {$\theta$}; %
  \node[latent, left=of theta] (alpha) {$\alpha$};
  \node[latent, above=1.2 of z, xshift=-0.5cm] (beta) {$\beta$};

	% Edges
	\edge{alpha}{theta}; \edge{theta}{z}; \edge{theta}{z}; \edge{z}{w}; 
	\edge{beta}{w};

	% Plates
  \plate {plateN} { %
    (w)(z) %
  }{$N$}; %
	\plate[inner sep=0.2cm, xshift=-0.05cm, yshift=0.15cm]{plateM}{
		(plateN)(theta)
	}{$M$};
\end{tikzpicture}
\caption{LDA Model}
\end{figure}
```
