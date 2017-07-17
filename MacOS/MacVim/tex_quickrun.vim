" ~/.vim/ftplugin/tex_quickrun.vim に保存。なければフォルダを自分で作る。 / Texのコンパイルに必要
" 指定した範囲でF5をすると、tmptex.pdfというファイルができ、そこにプレビューされる。
" どこも指定せずにF5をすると、そのファイル全体がコンパイルされる。
"http://qiita.com/ssh0/items/4aea2d3849667717b36dを参考にした。自分の保存用。

" Change to current directory
:cd %:p:h

" LaTeX Quickrun
" Moved to Dein


" 部分的に選択してコンパイル
" http://auewe.hatenablog.com/entry/2013/12/25/033416 を参考に
let g:quickrun_config.tmptex = {
\   'exec': [
\           'mv %s %a/tmptex.latex',
\           'latexmk -pdfdvi -pv -output-directory=%a %a/tmptex.latex',
\           ],
\   'args' : expand("%:p:h:gs?\\\\?/?"),
\   'outputter' : 'error',
\   'outputter/error/error' : 'quickfix',
\
\   'hook/eval/enable' : 1,
\   'hook/eval/cd' : "%s:r",
\
\   'hook/eval/template' : '\documentclass{jsarticle}'
\                         .'\usepackage[dvipdfmx]{graphicx, hyperref}'
\                         .'\usepackage{float}'
\                         .'\usepackage{amsmath,amssymb,amsthm,ascmac,mathrsfs}'
\                         .'\allowdisplaybreaks[1]'
\                         .'\theoremstyle{definition}'
\                         .'\newtheorem{theorem}{定理}'
\                         .'\newtheorem*{theorem*}{定理}'
\                         .'\newtheorem{definition}[theorem]{定義}'
\                         .'\newtheorem*{definition*}{定義}'
\                         .'\renewcommand\vector[1]{\mbox{\boldmath{\$#1\$}}}'
\                         .'\begin{document}'
\                         .'%s'
\                         .'\end{document}',
\
\   'hook/sweep/files' : [
\                        '%a/tmptex.latex',
\                        '%a/tmptex.out',
\                        '%a/tmptex.fdb_latexmk',
\                        '%a/tmptex.log',
\                        '%a/tmptex.aux',
\                        '%a/tmptex.dvi'
\                        ],
\}

"vnoremap <silent><buffer> <F4> :QuickRun -mode v -type tmptex<CR>
vnoremap <silent><buffer> <F5> :QuickRun -mode v -type tmptex<CR>

" QuickRun and view compile result quickly (but don't preview pdf file)
"nnoremap <silent><F4> :QuickRun<CR>
nnoremap <silent><F5> :QuickRun<CR>

" 自動で生成したい場合
"autocmd BufWritePost,FileWritePost *.tex QuickRun tex
