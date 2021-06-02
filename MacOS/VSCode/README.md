# VS Code


* Visual modeは`editorHasSelection`を組み合わせることで表現できた。
* [ここ](https://code.visualstudio.com/docs/getstarted/settings)の下の方に言語別の設定の方法の例がある
* `<leader>`はvim側で使っているので、VS Codeのkey mappingには含めないようにする
* `multi-command`のextensionが必要になる

# memo

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

