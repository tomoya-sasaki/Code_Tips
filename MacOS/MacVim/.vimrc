" Old Version: https://gist.github.com/Shusei-E/db4ed25ce011a5b31993

" Reset Key mapping
mapclear

" セッションの保存(終了時にVimのセッション情報を自動で保存)と復元(Control-sで復元)
au Vimleave * mks! ~/.vim_session
nnoremap <C-s> :source ~/.vim_session <cr> :nohl <cr>

" Cmd-1を押して行頭に、Cmd-0を押して行末に
noremap <D-1> 0
noremap <D-0> $

" Chrome的なタブの切り替え
nnoremap <D-A-Left> gT
nnoremap <D-A-Right> gt

" 行番号を表示する
set number

" Use python filetype when open .pyx
autocmd BufRead,BufNewFile *.pxd,*.pxi,*.pyx set filetype=pyrex

" Use julia filetype for jl
autocmd BufRead,BufNewFile *.jl set filetype=julia


" タブ幅の設定、Tabではなくスペース2つにする
set tabstop=2
set shiftwidth=2
set noexpandtab
set softtabstop=0
autocmd Filetype tex setlocal expandtab

" 新しい行のインデントを現在行と同じにする
set autoindent
autocmd BufNewFile,BufRead *.c set cindent
autocmd BufNewFile,BufRead *.cpp set cindent


" バックアップをとらない
set nobackup

" ビープ音を出さない
set visualbell t_vb=

" 括弧ハイライトの調整 cf. http://goo.gl/acS2xh http://goo.gl/4caCgN
autocmd ColorScheme * highlight MatchParen gui=bold,underline guibg=white guifg=orange

" 勝手に括弧のハイライトでカーソルを動かさない
set noshowmatch

" 括弧の補完 (easybracket-vimを直に読み込む)
source ~/.vim/ftplugin/easybracket.vim
" inoremap { {}<Left>
" inoremap [ []<Left>
" inoremap ( ()<Left>
" inoremap " ""<Left>
" inoremap {<Enter> {}<Left><CR><ESC><S-o>
" inoremap [<Enter> []<Left><CR><ESC><S-o>
" inoremap (<Enter> ()<Left><CR><ESC><S-o>

" ビジュアルモードでは勝手にヤンクしないようにする cf. http://goo.gl/7jq1Th
vnoremap d "_d
noremap D "_D
"noremap  p "0p

" Undoの情報はセッションを超えて保存しない
set noundofile

" ノーマルモード時だけ ; と : を入れ替える
nnoremap ; :
nnoremap : ;

" インサートモードで - と _ を入れ替える
" Code Mode
" Now in ~/.vim/ftplugin/easybracket.vim


" 開いているファイルのあるフォルダにカレントディレクトリを設定
nnoremap <Leader>d :ChangeDir<CR>
command! ChangeDir call s:ChangeDir()
function! s:ChangeDir()
  :cd %:h
  :pwd
endfunction


" \wでwordcount (LatexならTeXcountを利用して純粋に単語数だけ)
vnoremap <Leader>w g<C-g>
nnoremap <Leader>w :MyWordCount<CR>
command! MyWordCount call s:MyWordCount()
function! s:MyWordCount()
  let e = expand("%:e")
  if e == "tex" 
    :w !detex %:r.tex | wc -w
    :w !perl /Users/Shusei/.vim/texcount.pl %:r.tex
  else
    " g<C-g>のキーマッピングの実行
    :execute "normal g\<C-g>"
  endif
endfunction

"テキストでは勝手に改行しない
autocmd FileType text setlocal textwidth=0 

"Spell Checkのときに日本語を除外
set spelllang=en,cjk

" インサートモードでは、Shift-Escで括弧を抜ける
inoremap <S-ESC> <ESC>la


" Fold method (起動時には全てunfold)
set foldmethod=marker
autocmd BufNewFile,BufRead *.cpp set foldmethod=syntax
au BufNewFile,BufRead * normal zR

" Window Size
command! Window call s:WindowSetting()
function! s:WindowSetting()
  " ウィンドウ間の移動 (Command)
    noremap <D-Left> <C-w>h
    noremap <D-Right> <C-w>l
    noremap <D-Down> <C-w>j
    noremap <D-Up> <C-w>k
  " ウィンドウの移動 (Shift+Command)
    noremap <S-D-Left> <C-w><S-h>
    noremap <S-D-Right> <C-w><S-l>
    noremap <S-D-Down> <C-w><S-j>
    noremap <S-D-Up> <C-w><S-k>
  " ウィンドウサイズの調整 (Control+option)
    noremap <A-C-Left> <C-w><
    noremap <A-C-Right> <C-w>>
    noremap <A-C-Down> <C-w>-
    noremap <A-C-Up> <C-w>+
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Dein用
if &compatible
  set nocompatible   " Be improved
endif
 
" dein.vimのディレクトリ
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" なければgit clone
if !isdirectory(s:dein_repo_dir)
  execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
endif
execute 'set runtimepath^=' . s:dein_repo_dir

" dein.vim settings
let g:dein#install_max_processes = 16
let g:dein#install_progress_type = 'title'
let g:dein#install_message_type = 'none'
let g:dein#enable_notification = 1
 
" Required:
let s:toml      = '~/.dein.toml'
let s:lazy_toml = '~/.dein_lazy.toml'

 
" Let dein manage dein
" Required:
call dein#add('Shougo/dein.vim')
 
" Add or remove your plugins here:
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir, [$MYVIMRC, s:toml])
  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})
  call dein#end()
  call dein#save_state()
endif
 
" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

" Required
filetype plugin indent on


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set commands for colorscheme
" User-defined commands must start with a capital letter
function! SkinDefault()
  Skinhybrid
  colorscheme macvim
  highlight Normal guifg=MacTextColor  guibg=gray90
  highlight Cursor guifg=NONE guibg=#57fc00
  highlight StatusLineNC guibg=#a8a6a6 guifg=#606060
  highlight Cursor guifg=NONE guibg=Green
  highlight CursorIM guifg=NONE guibg=Purple
endfunction
command! Skindefault call SkinDefault()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Programming and QuickRun Commands
command! Crun call s:Runcode()
noremap <F5> :Crun<CR>
function! s:Runcode()
  let e = expand("%:e")
  if e == "c"
    :Gcc1
  endif
  if e == "py"
    :Python3Do
  endif
    if e == "cpp"
    :CPP1
  endif
    if e == "tex"
    :lcd %:p:h
    :QuickRun
  endif
    if e == "R"
    :QuickRun
  endif
    if e == "Rmd"
    :RmdRun
  endif  
endfunction

command! Python3Do call s:Python1()
function! s:Python1()
  :!source activate py36 ; python %
endfunction

command! Gcc1 call s:Gcc1()
function! s:Gcc1()
  if has("win32") || has("win64")
    :!gcc % -o %:r.exe
    :!%:r.exe
  else
    :!sudo gcc % -o %:r.out
    ":!%:p:h/%:r.out
    :!./%:r.out 
  endif
endfunction

command! CPP1 call s:CPP1()
function! s:CPP1()
    :cd %:p:h
    :!clang++ -std=c++11 -stdlib=libc++ -O1 % -o %:r.out
    ":!%:p:h/%:r.out
    :!./%:r.out   
endfunction

command! RmdRun call s:RmdRun()
function! s:RmdRun()
    :cd %:p:h
    :!Rscript -e "rmarkdown::render('%')" > rmd.log 2>&1
endfunction


" QuickRunで実行
command! Run call s:Run()
nmap <F6> :Run<CR>
function! s:Run()
  let e = expand("%:e")
  if e == "c"
    :Gcc
  endif
  if e == "py"
    :Python3
  endif
    if e == "cpp"
    :CPP
  endif
endfunction

command! Gcc call s:Gcc()
function! s:Gcc()
  if has("win32") || has("win64")
    :!gcc % -o %:r.exe
    :!%:r.exe
  else
    :QuickRun c -hook/time/enable 1
  endif
endfunction

command! Python3 call s:Python()
function! s:Python()
    :QuickRun python3 
endfunction

command! CPP call s:CPP()
function! s:CPP()
    :QuickRun cpp 
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key mapping

" Vimfiler
nnoremap <Leader>v :VimFilerBufferDir -split -simple -winwidth=35 -force-quit<CR>
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_edit_action = 'tabopen'

augroup vimfiler
  autocmd!
  autocmd FileType vimfiler call s:vimfiler_settings()
augroup END
function! s:vimfiler_settings()
  " tree での制御は，<Space>
  map <silent><buffer> <Space> <NOP>
  nmap <silent><buffer> <Space> <Plug>(vimfiler_expand_tree)
  nmap <silent><buffer> <S-Space> <Plug>(vimfiler_expand_tree_recursive)

  " マークは，<C-Space>(control-space)
  nmap <silent><buffer> <C-Space> <Plug>(vimfiler_toggle_mark_current_line)
  vmap <silent><buffer> <C-Space> <Plug>(vimfiler_toggle_mark_selected_lines)

  " ウィンドウを分割して開く
  nnoremap <silent><buffer><expr> <C-h> vimfiler#do_switch_action('split')
  nnoremap <silent><buffer><expr> <C-v> vimfiler#do_switch_action('vsplit')

  " 移動，<Tab> だけでなく <C-l> も
  nmap <buffer> <C-l> <plug>(vimfiler_switch_to_other_window)

  " 閉じる，<Esc> 2 回叩き
  nmap <buffer> <Esc><Esc> <Plug>(vimfiler_exit)
endfunction


" uniteを開いている間のキーマッピング
augroup vimrc
  autocmd FileType unite call s:unite_my_settings()
augroup END
function! s:unite_my_settings()
  " ESCでuniteを終了
  nmap <buffer> <ESC><ESC> <Plug>(unite_exit)
  " 入力モードのときjjでノーマルモードに移動
  imap <buffer> jj <Plug>(unite_insert_leave)
  " 入力モードのときctrl+wでバックスラッシュも削除
  imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
  " <C-s>でsplit
  nnoremap <silent><buffer><expr> <C-s> unite#smart_map('<C-s>', unite#do_action('split'))
  inoremap <silent><buffer><expr> <C-s> unite#smart_map('<C-s>', unite#do_action('split'))
  " <C-v>でvsplit
  nnoremap <silent><buffer><expr> <C-v> unite#smart_map('<C-v>', unite#do_action('vsplit'))
  inoremap <silent><buffer><expr> <C-v>f unite#smart_map('<C-v>', unite#do_action('vsplit'))
  " vでvimfiler
  nnoremap <silent><buffer><expr> v unite#smart_map('v', unite#do_action('vimfiler'))
  inoremap <silent><buffer><expr> v unite#smart_map('v', unite#do_action('vimfiler'))
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File Open

" 今開いているファイルをMarked 2で表示
nnoremap <Leader>m :Marked2Run<CR>
command! Marked2Run call s:Marked2Run()
function! s:Marked2Run()
  let e = expand("%:e")
  if e == "md"
    :!open -a /Applications/Marked\ 2.app %
    echo "Open Marked 2"
  else
    echo "File is not Markdown"
  endif
endfunction

" Pandoc
nnoremap <Leader>p :PandocRun<CR>
command! PandocRun call s:PandocRun()
function! s:PandocRun()
  let e = expand("%:e")
  if e == "md"
    ":!pandoc %:r.md -f markdown -t latex -s -o %:r.tex
    :!pandoc %:r.md -o %:r.tex  --template="pandoc_latex_template.tex"
    echo "Converted to tex file"
  else
    if e == "tex"
      :!pandoc -s %:r.tex --bibliography=ref.bib -csl=chicago-author-date.csl -o %r.docx
    else
      echo "File is not supported"
    endif
  endif
endfunction
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
