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

## CUDA
```
$ module load python/3.8.5-fasrc01  # python/3.6.3-fasrc01
$ module load cuda/11.1.0-fasrc01  # cuda/9.0-fasrc02
$ module load cudnn/8.1.0.77_cuda11.2-fasrc01  # cudnn/7.0_cuda9.0-fasrc01
```
Check [combination](https://www.tensorflow.org/install/source?hl=ja#linux).
