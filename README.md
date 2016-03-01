# Code_Tips
Efficient ways to write codes in `Python`, `R`, and `C/C++`.<br>
How to use `ArcGIS/ArcPy` is also added.

## How to write Markdown
* Please use following code.

```README.md
# Table of Contents
1. [例1](#例1)
2. [Example2](#example2)
3. [Third Example](#third-example)

### 例1
### Example2
### Third Example
When spaces are used in the header, remember to use "-".
```
* To open links in a new tab (window)
`<a href="http://www.sampleurl.com" target="_blank">こちら</a>`

## Write Codes with Vim
To change settings, use `:edit ~/.vimrc` and `:edit ~/.gvimrc`.<br>
For more details, read <a href="https://gist.github.com/Shusei-E/db4ed25ce011a5b31993" target="_blank">this</a>.

#### Spell Check in Vim
`:set spell`	スペルチェック機能を ON<br>
`:set nospell`	スペルチェック機能を OFF<br>
`]s`	次のスペルミスの箇所へ移動<br>
`[s`	前のスペルミスの箇所へ移動<br>
`z=`	正しいスペルの候補を表示し、選択した単語でスペルミスを修正<br>
`zg`	カーソル下の単語を正しいスペルとして辞書登録<br>
`zw`	カーソル下の単語を誤ったスペルとして辞書登録<br>
