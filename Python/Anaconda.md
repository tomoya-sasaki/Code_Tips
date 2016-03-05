# How to use Anaconda

### New Environment
It seems better to use Miniconda rather full Anaconda in university's computers. To install Miniconda, execute
```terminal
$ conda create -n py3k python=3.4.3 pandas
```
You have to specify libraries you want to use. If you don't use that option, all packages will be copied. <br>

### Launch
```terminal
$ source /home/xxxxxxxxx/.conda/envs/py3k/bin/activate py3k
```
Some websites say it's fine to use `source activate py3k`, but in my environment, it crashes. <br>
If you want to use Anaconda Launcher, type `$ launcher` in Terminal.

### Install Packages
In the environment you've made,
```terminal
$ conda install beautifulsoup4
```

If you want to use `pip`, the simplest way is `pip install PACKAGE` (no need to use `pip3`).
```terminal
$ conda skeleton pypi PACKAGE
$ conda build PACKAGE
```
or
```terminal
$ conda pipbuild PACKAGE
```

### Delete the Environment
```terminal
$ conda remove -n <my_env> --all
```

### Reference
[conda で python の環境つくり](https://gist.github.com/aphlysia/d5fcee79ff81b8272faf)
