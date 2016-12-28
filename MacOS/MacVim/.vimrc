" Reset Key mapping
mapclear

" セッションの保存(終了時にVimのセッション情報を自動で保存)と復元(Control-sで復元)
au Vimleave * mks! ~/.vim_session
nnoremap <C-s> :source ~/.vim_session <cr> :nohl <cr>
