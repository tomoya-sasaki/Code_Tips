# Tikz
[Use style file](https://github.com/Shusei-E/tikz-bayesnet)

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
Better LDA:
```tex
\begin{figure}[H]
\centering
\begin{tikzpicture}
  % Nodes
  % parameters and data
  \node[latent]           (alpha)    {$\alpha$}; %
  \node[latent, right= of alpha]  (theta) {$\theta_d$};
  \node[latent, right= of theta]  (z) {$z_{d,i}$};
  \node[obs, right = of z]  (w) {$w_{d,i}$};
  \node[latent, right = of w]  (phi) {$\phi_k$};
  \node[latent, right = of phi]  (beta) {$\beta$};
  % edges
   \edge{alpha}{theta};
   \edge{theta}{z};
   \edge{z}{w};
   \edge{phi}{w};
   \edge{beta}{phi};
 % Plates
  {
   \tikzset{plate caption/.append style={below=20pt of #1.south east}}
   \plate[inner ysep=7pt, inner xsep=10pt, xshift=-1pt, yshift=2pt] {plate1} {(theta)(z)(w)} {$D$};
  }

  \plate[]{plate2}{
    (z)(w)
  }{$N_d$};

  \plate[]{plate3}{
    (phi)
  }{$K$};
\end{tikzpicture}
\caption{Graphical Representation of Latent Dirichlet Allocation}
\end{figure}
```
