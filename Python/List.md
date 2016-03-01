# List

### 複数のリスト型オブジェクトの間の計算
[参考](http://qiita.com/HirofumiYashima/items/7f82620f42dae5b7c9ca) <br>
```python
>>> a = [1, 2, 3]
>>> b = [4, 5, 6]
>>> [str(a) + str(b) for (a, b) in zip(a, b)]
['14', '25', '36']
```

### リスト内包表記でif elseを用いる
以下の例では、`ku_num_list`に番号が入っていて、それが1桁なら先頭にゼロを付けたものを返す。もともと2桁なら何もしない。
```python
["0"+ str(item) if len(str(item))==1 else str(item) for item in ku_num_list]
```
次の例では、elif的な用法。全てのものを3桁に統一する。
```python
["00"+ str(item) if len(str(item))==1 else "0"+str(item) if len(str(item))==2 else str(item) for item in ku_num_list]
```
