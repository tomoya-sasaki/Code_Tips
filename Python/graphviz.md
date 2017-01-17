# graphviz
`from graphviz import Digraph`

## Table of Contents
1. [Template](#template)

## Template
### Basic
```python
dot = Digraph(comment='The Round Table', format='pdf')

dot.node('A', '王政')
dot.node('B', '軍事政権')
dot.node('L', '民主制')

dot.edges(['AB', 'AL'])
dot.edge('B', 'L', constraint='false')  # constraint argumentがtrueで良いなら、上のedgesにまとめてOK

print(dot.source) # これを保存すればDOT言語のファイルが保存できるはず
dot.render('test-output/round-table.gv')
dot
```
<img src="figures/graphviz_basic.png" width="300">

### Use for loop
```python
def kakari_graphic(sentence):
    kakari_g = Digraph(comment='係り受け図', format='pdf')
    
    for index, phrase in enumerate(sentence.sentence):
        phrase = re.sub(r"。|、", "", phrase) # 句読点の除去
        kakari_g.node(str(index), phrase) # どういったオブジェクトがあるかをまず定義する
        
    for index, kakari_saki in enumerate(sentence.dst):
        if kakari_saki != "-1": # "-1"は係り先がないことを示す
            kakari_g.edge(str(index), kakari_saki) # edgeを追加
    
    return kakari_g
```
