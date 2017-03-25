# List

## Table of Contents
1. [複数のリスト型オブジェクトの間の計算](#複数のリスト型オブジェクトの間の計算)
2. [リスト内包表記](#リスト内包表記)
   * [if elseを用いる](#if-elseを用いる)
   * [二重ループ](#二重ループ)
3. [別のリストの要素を追加](#別のリストの要素を追加)

## 複数のリスト型オブジェクトの間の計算
[参考](http://qiita.com/HirofumiYashima/items/7f82620f42dae5b7c9ca) <br>
```python
>>> a = [1, 2, 3]
>>> b = [4, 5, 6]
>>> [str(a) + str(b) for (a, b) in zip(a, b)]
['14', '25', '36']
```

## リスト内包表記
### if elseを用いる
以下の例では、`ku_num_list`に番号が入っていて、それが1桁なら先頭にゼロを付けたものを返す。もともと2桁なら何もしない。
```python
["0"+ str(item) if len(str(item))==1 else str(item) for item in ku_num_list]
```
ifだけ使うなら、以下のようになる
```python
[word for word in word_list if word not in stopset]
```

次の例では、elif的な用法。全てのものを3桁に統一する。
```python
["00"+ str(item) if len(str(item))==1 else "0"+str(item) if len(str(item))==2 else str(item) for item in ku_num_list]
```

`""`なら`continue`(リストに要素を追加しない)をする:
```python
paragraphs = [preprocessing(paragraph) for paragraph in paragraphs if paragraph is not ""]
```


### 二重ループ
```python
[wordID for item in dictionary.doc2bow(document.split()) for x in range(count)]
```

## 別のリストの要素を追加
`list.extend(["New", "List"])`のようにする

