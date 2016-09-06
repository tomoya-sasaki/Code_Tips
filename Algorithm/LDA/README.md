# LDA
Python 3 modified code of [PythonでLDAを実装してみる](http://satomacoto.blogspot.jp/2009/12/pythonlda.html)  
[Beli, Ng, and Jordan (2003)](http://www.jmlr.org/papers/volume3/blei03a/blei03a.pdf) Figure 1  
Useful derivation [note](http://chasen.org/~daiti-m/paper/lda-fullvb.pdf)


## 仕組み
[PythonでLDAを実装してみる](http://satomacoto.blogspot.jp/2009/12/pythonlda.html)から引用
> トピックzの数をk個、単語wの種類をV個とすると、パラメータαはk次元のベクトル、βはk x V次元の行列でβij=p(wj|zi)  
> ここで、ドキュメントにおけるαとβの値がわかれば、トピックがどんな割合であって（α）、そのトピックに関する語がどんな割合で存在するか（β）がわかる。つまり、ドキュメントが上のようなプロセスで生成されているとしてαとβの値はいくつかということを推定するのがLDAの目的。

<img src="model.png" width="300"> 今回はgraphvizだったけど、["tikz lda"](https://www.google.co.jp/webhp?sourceid=chrome-instant&ion=1&espv=2&ie=UTF-8#safe=off&q=tikz+lda)とか検索してもできそうだった  
Mはコーパス内のドキュメントの数。Nは各ドキュメントの語の数
```dot
 digraph G {
  rankdir = LR;
  node [style=solid, shape=circle];
  w [style = filled, fillcolor = "gray"]

  subgraph clusterA {
  θ -> z 
  labelloc="b";
  label = "M";
    subgraph clusterB {
      z -> w;
      labelloc="b";
      label = "N"
    }
  }

  α -> θ
  β -> w
  
}
```

## Memo
* コード中の`gamma`は`theta`のこと？
 
## Data Structure
`<feature_id>:<count>`. Here, `feature_id`is an integer starting from 1 (same as SVMlight).
```txt
1:1 2:4 5:2
1:2 3:3 5:1 6:1 7:1
2:4 5:1 7:1
```
Pythonでデータセットを作る場合は、`sklearn.datasets.dump_svmlight_file()`が使える??
