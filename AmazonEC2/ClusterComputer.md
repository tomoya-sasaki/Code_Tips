# Cluster Computer

## Tensorflow
* 管理画面からのterminalで、condaのenvironmentを作ってTensorflowを入れる
```
$ module load python/3.8.5-fasrc01  # python/3.6.3-fasrc01
$ conda create -n tf python=3.8 pip numpy six wheel scipy pandas
$ source activate tf
$ pip install tensorflow==2.5 
```
* jobを作ったら、`source activate tf`で大丈夫
