# List

### 複数のリスト型オブジェクトの間の計算
[参考](http://qiita.com/HirofumiYashima/items/7f82620f42dae5b7c9ca) <br>
```python
>>> a = [1, 2, 3]
>>> b = [4, 5, 6]
>>> [str(a) + str(b) for (a, b) in zip(a, b)]
['14', '25', '36']
```
