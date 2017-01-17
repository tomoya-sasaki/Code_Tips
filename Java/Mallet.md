# Mallet
[Tutorial](http://programminghistorian.org/lessons/topic-modeling-and-mallet)

## Table of Contents
1. [Compile](#compile)
2. [Prepare Corpus](#prepare-corpus)
3. [Run Topic Model](#run-topic-model)
  * [HLDA](#hlda)

## Compile
Just run `$ ant`.

## Prepare Corpus
```terminal
$ /Users/S/Downloads/mallet-github/bin/mallet import-dir --input /Users/S/Downloads/mallet-github/sample-data/web/en --output data-input.mallet --keep-sequence --remove-stopwords
```

## Run Topic Model
### Train topic
```terminal
$ /Users/S/Downloads/mallet-github/bin/mallet run cc.mallet.topics.tui.HierarchicalLDATUI --input data-input.mallet
```

```terminal
$ /Users/S/Downloads/mallet-github/bin/mallet train-topics --input data-input.mallet --num-topics 100 --output-state topic-result.gz
```

### HLDA
#### Run
```terminal
/Users/S/Downloads/mallet-stable/bin/mallet run cc.mallet.topics.tui.HierarchicalLDATUI --input data-input.mallet --alpha 5.0 --eta 0.1 --gamma 1.0 --num-top-words 10 --num-levels 3  --output-state outputstate.txt 
```
If you want to modify something, it seems we need to change `~TUI` in `mallet/topics/tui`.

#### Understand output
[Reference](http://stackoverflow.com/questions/38088972/unable-to-understand-the-hlda-output-in-mallet)    
`cc/mallet/topics/HierarchicalLDA.java`を以下のように修正してから、`ant`して結果をみるとわかりやすいのではないか。
```java
// l.447~
for (level = numLevels - 1; level >= 0; level--) {
		path.append(node.nodeID + "/" + "");
		node = node.parent;
}
```
```java
// l.457
out.println("path: " + path + " " + "tokenID: " + type + "  Object: " + alphabet.lookupObject(type) + " level: " + level + " ");
```
