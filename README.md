# Code_Tips
Efficient ways to write codes in `Python`, `R`, and `C/C++`.<br>
How to use `ArcGIS/ArcPy` is also added.

## How to write Markdown
* Please use following syntax.

```README.md
# Table of Contents
1. [例1](#例1)
2. [Example2](#example2)
3. [Third Example](#third-example)

### 例1
### Example2
### Third Example
When spaces are used in the header, remember to use "-".

# Insert images
<img src="figures/ggplot2_xlab_change.png" width="550">
```
* To open links in a new tab (window)<br>
`<a href="http://www.sampleurl.com" target="_blank">こちら</a>`

### Use Mardown on ...
* **on computer**: <a href="http://marked2app.com/"  target="_blank">Markded 2</a> with Vim
  * CSS template is <a href="https://gist.github.com/Shusei-E/d4e58dd6fc7f320fa7b3" target="_blank">here</a>.
* **on Evernote**: <a href="https://marxi.co"  target="_blank">Marxico</a>

### Create Table of Contents Automatically
* [summarizeMD](https://github.com/Shusei-E/summarizeMD)


## Write Codes with Vim
To change settings, use `:edit ~/.vimrc` and `:edit ~/.gvimrc`.<br>
For more details, read <a href="https://gist.github.com/Shusei-E/db4ed25ce011a5b31993" target="_blank">this</a>.

### Spell Check in Vim
`:set spell`	スペルチェック機能を ON<br>
`:set nospell`	スペルチェック機能を OFF<br>
`]s`	次のスペルミスの箇所へ移動<br>
`[s`	前のスペルミスの箇所へ移動<br>
`z=`	正しいスペルの候補を表示し、選択した単語でスペルミスを修正<br>
`zg`	カーソル下の単語を正しいスペルとして辞書登録<br>
`zw`	カーソル下の単語を誤ったスペルとして辞書登録<br>

### Keybord shortcuts 
#### 挿入と変更
* `dd`: 行全体の削除
* `u`: undo
* `CTRL-R`: redo
* `x`: 一文字削除
* `dw`: 単語の削除 cf. `d4w`は4単語削除
 * 発展系として:
 * `d$`: カーソル位置から行末まで削除 (Dも同じ)
* `o`: カーソルの下に行を挿入する
* `O`: カーソルの上に行を挿入する。これでは必ず挿入モードになるので注意
 * 挿入モードを避けるには、`~/.vimrc`に以下の一行を
 * `nnoremap O :<C-u>call append(expand('.'), '')<Cr>j`
* `A`: 行末にカーソルを動かして挿入モードを開始
* `cc` = `S`: 行全体の変更 (chap. 4)
* `cw`: その単語の変更 (dwiと同じ意味かな)
* `c$` = `C`: 行末まで変更
