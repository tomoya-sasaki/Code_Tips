# MacVim Kaoriya Version
* 自作関数の先頭は大文字のようなので注意
* Combine commands and move: `nnoremap <Leader>tc :TemplateChunk<CR>i`
    * [Use self-defined tempalte](https://stackoverflow.com/questions/690386/writing-a-vim-function-to-insert-a-block-of-static-text)
* Get line num: `line(".")`
* If you update `.vimrc`, `:source ~/.vimrc`

## Key Bidings
* Replace: `ciw`, `cf[char]`
* Delete: `caw`, `ciw`
* Repeat command: `@:`
* Math related tips: [How I'm able to take notes in mathematics lectures using LaTeX and Vim](https://castel.dev/post/lecture-notes-1/)

## dein
Update:
```
:call dein#update(['Nvim-R'])
```

# Shortcuts
## Nvim-R
* `\rf`: Start
* `\rq`: End
* `Cmd+Enter`: Send a line and down
* `\pp`: Send a paragraph
* `\ss`: Send a selection
* `\cc`: Send a chunk
* `\cn`: Next chunk
* `\cN`: Previous chunk
* `\kp`: Knit PDF (Errorが出たらフォント絡みのことがあるので、`mainfont: Meiryo`とだけする。この場合図の日本語は表示できない)
* `\aa`: Send a file

* [Referene 1](https://sakura-education.com/myblog/archives/913)

## foldmethod
* `{{{`と`}}}`で囲う、コメントアウトされていてもOK
* `zm`: 折りたたみ全てを一段階閉じる
* `zr`: 折りたたみ全てを一段階開く
* `zM`: 折りたたみ全てを閉じる
* `zR`: 折りたたみ全てを開く
* `zo`: カーソル下の折りたたみを一段階開く
* `zO`: カーソル下の折りたたみを全て開く
* `zc`: カーソル下の折りたたみを一段階閉じる
* `zC`: カーソル下の折りたたみを全て閉じる

## Vimtex
* `<localleader>lt`: アウトラインの表示
* `<C-x><C-o>`: Citeeeの補完
* [Reference](http://mmi.hatenablog.com/entry/2015/01/02/003517)



## slimv
* For SCIP: `brew install mit-scheme`
* `\rf`: 接続
* `Cmd+Enter`: カーソルがあるS式を評価
* `\cc`: バッファーを評価
* Error
  * `\a`: Abort
  * `\n`: Continue

## vim-slime
* Get an absolute path
  * `lsof -U | grep '^tmux'`
* Target pane: usually `0`, `1`,...
* In `.vimrc`, you can set above two as: `let g:slime_default_config = {"socket_name": "/private/tmp/tmux-502/default", "target_pane": "0"}`
* Close tmux: `<C-b>` and `:kill-session`
  


# Settings
## Latex
You need to know how to write in `.latexmkrc` and command options. ([Reference](https://texwiki.texjp.org/?Latexmk))
```
$latex = 'uplatex %O -synctex=1 %S'; #-pdfdvi
$pdflatex = 'pdflatex %O -synctex=1 %S';
$lualatex = 'lualatex %O -synctex=1 %S';
$xelatex = 'xelatex %O -synctex=1 %S';
```

# Session
## Save
```
:mks session.vim
:mks!
```

## Open

```
:souce session.vim
```
