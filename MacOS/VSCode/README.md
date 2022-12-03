# VS Code


* Visual modeは`editorHasSelection`を組み合わせることで表現できた。
* [ここ](https://code.visualstudio.com/docs/getstarted/settings)の下の方に言語別の設定の方法の例がある
* `multi-command`のextensionが必要になる

# memo

## keyを押しっぱなしにできるように
[Reference](https://stackoverflow.com/questions/39972335/how-do-i-press-and-hold-a-key-and-have-it-repeat-in-vscode)
```terminal
$ defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
```

## R
* You will need `R` and `R LSP Client`
* R側でも`languageserver`と`lintr`を入れておく
* Python3のenvironmentを使って、`radian`を入れた場合は、environmentの大元の場所を探す、`/usr/local/var/pyenv/versions/3.8.5/envs/py38/bin/radian`
* radian color scheme: `$HOME/.radian_profile`に`options(radian.color_scheme = "manni")`

## TeX
* `latexmkrc`は[これ](https://github.com/Shusei-E/Code_Tips/blob/master/MacOS/VSCode/.latexmkrc)と同じ
* [参考](https://gist.github.com/schnell18/2758ac54990540b10359f1c58b599db0)
* [Skim](https://github.com/James-Yu/LaTeX-Workshop/wiki/View#macos)


## Snippet
```json
{
    "key": "cmd+K cmd+L",
    "command": "editor.action.insertSnippet",
    "when": "editorTextFocus && editorLangId == php",
    "args": {
        "snippet": "echo '<pre>';\nvar_dump(${TM_SELECTED_TEXT}$1)$0;\necho '</pre>';"
    }
}
```

## Color theme
* `Brackets Light Pro-color-theme.json`: edited for High Contrast mode (`fehey.brackets-light-pro-0.4.5`), check `~/.vscode/extensions`

## Add a context
https://github.com/VSCodeVim/Vim/issues/4765

# Multiple cursor
* `gb`を繰り返すことで追加できる
  * `Option`を押しながらクリックでも追加できる
* `v`でビジュアルモードに戻れる
