" Old Version: https://gist.github.com/Shusei-E/db4ed25ce011a5b31993

" Reset Key mapping
mapclear

" セッションの保存(終了時にVimのセッション情報を自動で保存)と復元(Control-sで復元)
au Vimleave * mks! ~/.vim_session
nnoremap <C-s> :source ~/.vim_session <cr> :nohl <cr>

" Cmd-1を押して行頭に、Cmd-0を押して行末に
noremap <D-1> 0
noremap <D-0> $

"Chrome的なタブの切り替え
nnoremap <D-A-Left> gT
nnoremap <D-A-Right> gt

"行番号を表示する
set number

"タブ幅の設定、Tabではなくスペース2つにする
set tabstop=2
set shiftwidth=2
set noexpandtab
set softtabstop=0
autocmd Filetype tex setlocal expandtab

"新しい行のインデントを現在行と同じにする
set autoindent
autocmd BufNewFile,BufRead *.c set cindent
autocmd BufNewFile,BufRead *.cpp set cindent

"バックアップをとらない
set nobackup

"ビープ音を出さない
set visualbell t_vb=

"括弧ハイライトの調整 cf. http://goo.gl/acS2xh http://goo.gl/4caCgN
autocmd ColorScheme * highlight MatchParen gui=bold,underline guibg=white guifg=orange

"勝手に括弧のハイライトでカーソルを動かさない
set noshowmatch

"括弧の補完
inoremap { {}<Left>
inoremap [ []<Left>
inoremap ( ()<Left>
inoremap " ""<Left>
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap [<Enter> []<Left><CR><ESC><S-o>
inoremap (<Enter> ()<Left><CR><ESC><S-o>

"ビジュアルモードでは勝手にヤンクしないようにする cf. http://goo.gl/7jq1Th
vnoremap d "_d
noremap D "_D
"noremap  p "0p

"Undoの情報はセッションを超えて保存しない
set noundofile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Dein用
"if &compatible
"  set nocompatible               " Be iMproved
"endif
 
" dein.vimのディレクトリ
let s:dein_dir = expand('~/.cache/dein')
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
call dein#begin(s:dein_dir)
 
" Let dein manage dein
" Required:
call dein#add('Shougo/dein.vim')
 
" Add or remove your plugins here:
let s:toml      = '~/.vim/rc/dein.toml'
let s:lazy_toml = '~/.vim/rc/dein_lazy.toml'

" TOML を読み込み、キャッシュしておく
if dein#load_cache([expand('<sfile>'), s:toml, s:lazy_toml])
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})
  call dein#save_cache()
endif

" Required:
call dein#end()
 
" Required:
filetype plugin indent on
 
" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
