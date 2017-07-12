# minted

## Resources
* [Official](https://github.com/gpoore/minted)
* [Share Latex](https://ja.sharelatex.com/learn/Code_Highlighting_with_minted)
* [Blog](http://konoyonohana.blog.fc2.com/blog-entry-106.html)

## Usage
### Compile
```terminal
$ platex -shell-escape minted.tex ; platex -shell-escape minted.tex ; dvipdfmx minted.dvi
```

### Beamer
```tex
\documentclass[11pt, dvipdfmx]{beamer}
\usepackage[utf8]{inputenc}
%\usetheme{Frankfurt}
\usetheme{Darmstadt}
\useoutertheme[subsection=false]{miniframes}
\AtBeginSection[]{\subsection{}}

\setbeamersize{text margin left=11pt,text margin right=11pt}

\beamertemplatenavigationsymbolsempty

%\usepackage{courier} % if you need courier font

\usepackage{xcolor}
% Syntax Highlight
\usepackage{minted}
\definecolor{LightGray}{rgb}{0.95,0.95,0.95}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\begin{document}
\title{Minted} 
\subtitle{Be careful not to use with tabs} 
\author{}

\frame{\titlepage} 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\section{Minted Examples}

\begin{frame}[fragile]
\frametitle{Code in C++}

\begin{minted}[bgcolor=LightGray, fontsize=\tiny ]{cpp}
#include <iostream>
#include <vector>

using namespace std;

typedef struct{
  vector<int> words;
}DATA_STRUCT;

void add(DATA_STRUCT *data, int M){
  for(int i=0; i<M; i++){
    for(int s=0;s<3; s++){
      data[i].words.push_back(s);
      cout << i << s << endl;
    }
  }
}

int main(){
  int M=5;
  DATA_STRUCT *data = new DATA_STRUCT[M];
  add(data, M);
  cout << data[0].words[0] << endl;
  delete[] data;
}
\end{minted}
\end{frame}

\begin{frame}[fragile]
\frametitle{Code in R}

\begin{minted}[linenos, bgcolor=LightGray, fontsize=\tiny]{r}
dens <- density(faithful$waiting)
bw <- diff(range(faithful$waiting))/20

ggplot(faithful, aes(x=waiting)) +
  geom_histogram(binwidth=bw, fill='white', color='black') +
  geom_density(eval(bquote(aes(y=..count..*.(bw)))), fill='black', alpha=0.3)+
  xlim(range(dens$x))
\end{minted}
\end{frame}

\begin{frame}[fragile]
\frametitle{Code in Python}

\begin{minted}[linenos, framesep=2mm, bgcolor=LightGray, fontsize=\tiny, frame=lines]{Python}
links = soup.find_all("a")
list_xls_files = []
for link in links:
  link_url = link.get("href")
  try:
    if ".xls" in link_url:
     list_xls_files.append(link_url[5:])
  except TypeError:
    pass
\end{minted}
\end{frame}

\end{document}
```
