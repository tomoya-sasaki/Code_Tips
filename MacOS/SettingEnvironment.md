# Setting Environment 

* 2016/12/28
* 2019/07/16

## Using Homebrew
### R
* `brew upgrade xxx`
* `brew upgrade r` will update your R
* Old packages: `/usr/local/lib/R/`
* **Use normall installer from the website from the next time**
  * Now I use `homebrew` again. I am not sure which is better.

### Tensorflow
It is always better to check the latest information on the official website. *Radeon Pro 450 2048 MB* is not for this instruction (or I could not find a way).

#### If you use NVIDIA
Cuda:
```terminal
$ brew install coreutils
$ brew cask install cuda
$ brew cask info cuda  # version check
```
cuDNN v5.1 Library for OSX:<br>
Download from the official page and copy to corresponding folders `/usr/local/cuda/`.

.bash_profile:
```bash
export CUDA_HOME=/usr/local/cuda
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/cuda/lib"
export DYLD_LIBRARY_PATH="$DYLD_LIBRARY_PATH:$CUDA_HOME/lib"
export PATH="$CUDA_HOME/bin:$PATH"
```
After editing, `source ~/.bash_profile`.

Set Link:
```terminal
$ cd /usr/local/cuda/lib
$ sudo ln -s libcuda.dylib libcuda.1.dylib
$ ln -s /usr/local/cuda/lib/* /usr/local/lib
```
Delete ailiases in `/Developer/NVIDIA/CUDA-8.0/lib`.

Install:
```terminal
$ pip install tensorflow-gpu
```

Reference (check comments as well): [TensorflowでOSXのGPUが対応されたよ](http://qiita.com/tawago/items/15160c6aa0ebd1c61715)

#### CPU version
```terminal
$ brew install bazel swig
$ git clone -b master --recurse-submodules https://github.com/tensorflow/tensorflow
$ cd tensorflow
$ git checkout master
$ ./configure # use default or select N
$ bazel build -c opt --copt=-mavx --copt=-msse4.1 --copt=-msse4.2 --copt=-mavx2 --copt=-mfma //tensorflow/tools/pip_package:build_pip_package
          # --copt=-mの後に拡張命令 (check tensorflow warining)
$ bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/tensorflow_pkg
$ ls /tmp/tensorflow_pkg 
$ pip uninstall -y tensorflow
$ pip install /tmp/tensorflow_pkg/tensorflow-1.1.1-cp36-cp36m-macosx_10_12_x86_64.whl # check you version
```

## Manual Install
### XCode
* From AppStore

### RStudio
* From website

### Python
* `$ brew install pyenv`

Update `bash_profile`:
```
$ vi ~/.bash_profile
```
In `bash_profile`,
```terminal
export PYENV_ROOT="/usr/local/var/pyenv"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi
```
Do not forget to `source ~/.bash_profile` after editing!!
  
Then, you can install python:
* List Available Versions: `$ pyenv install -l`
* `$ pyenv install 3.5.2` 
 * If error occures, try `xcode-select --install` and install again
* `$ brew install pyenv-virtualenv`
* Usage of pyenv-virtualenv
  * It's easier to use virtualenv than pyenv to use multiuple versions of Python
  * Make a new environment: `$ pyenv virtualenv 3.5.2 NAME`
  * Activate the environment: `$ pyenv activate NAME` or `source activate NAME`
  * Deactivate the environment: `$ pyenv deactivate`
  * Delete the environment:　`$ pyenv uninstall NAME`
  * List Current Environments: `$ pyenv versions`
  
### Tex
[Reference](http://qiita.com/hideaki_polisci/items/3afd204449c6cdd995c9)

##### Install Ghostscript
`brew install ghostscript`

##### Download MacTex
https://tug.org/mactex/mactex-download.html

##### Install
Do not forget to select custom install and **clear the checkbox for Ghostscript**

##### Update TexLive
`sudo tlmgr update --self --all`   
If there is an error, relaunch Terminal.

##### Set Japanse Fonts
Enter the following commands line by line.
```
cd /usr/local/texlive/2016/texmf-dist/scripts/cjk-gs-integrate
sudo perl cjk-gs-integrate.pl --link-texmf --force
sudo mktexlsr
sudo kanji-config-updmap-sys hiragino-elcapitan-pron
```

##### Set TexShop
1. Update Software
2. TeXShopの環境設定の［書類］タブの左下の［設定プロファイル］から「pTeX (ptex2pdf)」を選択

##### Update
`sudo tlmgr update --self --all`

  
## pip
`pip install jupyter pandas matplotlib beautifulsoup4`

   
## In R
### RStan
* `install.packages('rstan', dependencies=T)`

## Chrome Extension
[Change Tab Size](https://github.com/Shusei-E/tab-size-on-github)

## Office
Check Amazon's 「ゲーム&PCソフトダウンロードライブラリ」

## Vim
* Kaoriya-version
* use `homebrew` from the next time?
  * We want to install it with Python 3

## Pandoc
* `$ brew install pandoc`
* `$ brew install pandoc-citeproc`

## Keyboard Shortcuts
* Keyboard -> Shortcuts -> App Shortcuts -> Add(+)
* Help: Create keyboard shortcuts for apps
