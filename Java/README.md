# Java
* [Java入門](#http://www.asahi-net.or.jp/~yf8k-kbys/newjava0.html)

## Setup Vim
`.vimrc`の設定
```vim
NeoBundle 'thinca/vim-quickrun'
if neobundle#tap('vim-quickrun') "{{{
  \ 'java' : {
  \ 'hook/output_encode/enable' : 1,
  \ 'hook/output_encode/encoding' : 'sjis',
  \ }
endif "}}}
```
