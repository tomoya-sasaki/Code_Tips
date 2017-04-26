# MacVim Kaoriya Version
* 自作関数の先頭は大文字のようなので注意

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


## slimv
* `\rf`: 接続
* `Cmd+Enter`: カーソルがあるS式を評価
* `\cc`: バッファーを評価
