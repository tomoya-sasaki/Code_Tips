# Cluster Computer

## Tensorflow
* 管理画面からのterminalで、condaのenvironmentを作ってTensorflowを入れる
```
$ module load python/3.9.12-fasrc01  # python/3.6.3-fasrc01
$ conda create -n tf python=3.9 pip cython numpy six wheel scipy pandas
$ conda activate tf
$ pip install tensorflow==2.5 
$ conda deactivate
```
* jobを作ったら、`source activate tf`で大丈夫
* `tensorflow==1.15`はPython 3.7以下じゃないとできない
* 環境を作ったら新しいターミナルで入り直さないとエラーが出ることがあった
* `conda info --envs`


## CUDA
```
$ module load python/3.8.5-fasrc01  # python/3.6.3-fasrc01
$ module load cuda/11.1.0-fasrc01  # cuda/9.0-fasrc02
$ module load cudnn/8.1.0.77_cuda11.2-fasrc01  # cudnn/7.0_cuda9.0-fasrc01
```
Check [combination](https://www.tensorflow.org/install/source?hl=ja#linux).

You need to load `cuda` and `cudnn` for tf.


