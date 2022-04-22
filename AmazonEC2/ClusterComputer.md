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

You need to load `cuda` and `cudnn` for tf.

## Git

### Personal Access Token
It's the easiest to use [a personal access token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token).
```terminal
$ git clone https://github.com/username/repo.git
Username: your_username
Password: your_token
```

### fetching remote branches
```terminal
$ git fetch
$ git branch -a
  * main
  remotes/origin/branchA
  remotes/origin/branchB
$ git checkout branchA  # switch to the remote branch
```
