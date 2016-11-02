# Java

## Setup Vim
`.vimrc`
```
NeoBundle 'thinca/vim-quickrun'
if neobundle#tap('vim-quickrun') "{{{
  \ 'java' : {
  \ 'hook/output_encode/enable' : 1,
  \ 'hook/output_encode/encoding' : 'sjis',
  \ }
endif "}}}

nmap <F6> :QuickRun<CR>
```
