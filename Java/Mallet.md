# Mallet
[Tutorial](http://programminghistorian.org/lessons/topic-modeling-and-mallet)

## Table of Contents
1. [Compile](#compile)
2. [Prepare Corpus](#prepare-corpus)
3. [Run Topic Model](#run-topic-model)

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
$ /Users/S/Downloads/mallet-github/bin/mallet train-topics --input data-input.mallet --num-topics 100 --output-state topic-result.gz　--inferencer cc.mallet.topics.HierarchicalLDA
```
