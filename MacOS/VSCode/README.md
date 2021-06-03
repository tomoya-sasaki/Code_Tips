# VS Code


* Visual modeは`editorHasSelection`を組み合わせることで表現できた。
* [ここ](https://code.visualstudio.com/docs/getstarted/settings)の下の方に言語別の設定の方法の例がある
* `<leader>`はvim側で使っているので、VS Codeのkey mappingには含めないようにする
* `multi-command`のextensionが必要になる

# memo

## R
* You will need `R` and `R LSP Client`
* R側でも`languageserver`と`lintr`を入れておく
* Python3のenvironmentを使って、`radian`を入れた場合は、environmentの大元の場所を探す、`/usr/local/var/pyenv/versions/3.8.5/envs/py38/bin/radian`

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

## Add a context
https://github.com/VSCodeVim/Vim/issues/4765

