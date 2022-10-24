# Setting Environment for Apple Silicon

* Setting up in English, area is Japan
* Don't use Migration Assistant, manually move files from Time Machine

Be careful:
* Terminal uses `zsh` so make `.zprofile` instead of `.bash_profile` ([Reference](https://leico.github.io/TechnicalNote/Mac/catalina-zsh))

## Starting
```
# 1: XCode
$ xcode-select --install

# 2: Homebrew (following the official website)

# 3: gcc
$ brew install gcc
```


## R
1. XQuartz
2. [Native R](https://cran.r-project.org/bin/macosx/)
3. [gfortran](https://mac.r-project.org/libs-arm64/) (move files to `opt/R/arm64`)

Add the following to `~/.zprofile` and `souce ~/.zprofile`
```
export LC_ALL=en_US.UTF-8
```

([Source](https://mpopov.com/blog/2021/10/10/even-faster-matrix-math-in-r-on-macos-with-m1/))

### Trouble shooting

#### gfortran error 1
Add a symbolic link:
```
$ ln -s /opt/R/arm64/opt/R/arm64/gfortran/lib/ /opt/R/arm64/gfortran/lib/
```
You have to make `/opt/R/arm64/gfortran/` manually.

#### gfortran error 2
```
ld: warning: directory not found for option '-L/opt/R/arm64/gfortran/lib/gcc/aarch64-apple-darwin20.2.0/11.0.0'
ld: warning: directory not found for option '-L/opt/R/arm64/gfortran/lib'
ld: library not found for -lgfortran
```

Find `gfortran/lib` and add the path to `~/.R/Makevars` ([reference](https://stackoverflow.com/a/69883911/4357279))
```
FLIBS=-L/opt/R/arm64/opt/R/arm64/gfortran/lib
```

Alternative setting from the reference:
```
# homebrew gfortran
FLIBS=-L/opt/homebrew/opt/gfortran/lib

# gfortran included in R
FLIBS=-L/opt/R/arm64/gfortran/lib

# In addition one might want to also define F77 and FC as
F77     = /opt/R/arm64/gfortran/bin/gfortran
FC      = /opt/R/arm64/gfortran/bin/gfortran
```

### data.table
[Reference](https://investcookies.ru/post/datatable_m1/data_table_arm/)

1. If you already installed it
```r
> remove.packages("data.table")
```

2. After installing command line tools, get clang
```terminal
$ xcode-select --install
$ brew update && brew install llvm
```

3. Edit `~/.R/Makevars` (it's taken from the referenced website)
```
# if you downloaded llvm manually above, replace with your chosen NEW_PATH/clang
LLVM_LOC = /opt/homebrew/opt/llvm
CC=$(LLVM_LOC)/bin/clang -fopenmp
CXX=$(LLVM_LOC)/bin/clang++ -fopenmp
# -O3 should be faster than -O2 (default) level optimisation ..
CFLAGS=-g -O3 -Wall -pedantic -std=gnu99 -mtune=native -pipe
CXXFLAGS=-g -O3 -Wall -pedantic -std=c++11 -mtune=native -pipe
LDFLAGS=-L/opt/homebrew/opt/gettext/lib -L$(LLVM_LOC)/lib -Wl,-rpath,$(LLVM_LOC)/lib
CPPFLAGS=-I/opt/homebrew/opt/gettext/include -I$(LLVM_LOC)/include
```

4. Install
```r
> install.packages("data.table", type = "source", repos = "https://Rdatatable.gitlab.io/data.table")
```


## LaTeX
```
$ brew install wget xz
$ brew install --cask mactex
$ sudo tlmgr update --self --all  # you may need to relaunch the terminal
```

* TeXShop: TeXShopの環境設定の［書類］タブの左下の［設定プロファイル］から「upTeX (ptex2pdf)」を選択
* [latexmkrc](https://github.com/Shusei-E/Code_Tips/blob/master/MacOS/MacVim/IntelMac/.latexmkrc)


## Pandoc
```
$ brew install pandoc
```

## Python

1. Installing pyenv: `brew install pyenv`

2. Setting file (the last two lines are from [the official guide](https://github.com/pyenv/pyenv#homebrew-in-macos))
```
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zprofile
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zprofile
echo 'eval "$(pyenv init --path)"' >> ~/.zprofile
echo 'eval "$(pyenv init -)"' >> ~/.zshrc
```

Add this to `.zprofile`: `export PYENV_VIRTUALENV_DISABLE_PROMPT=1`

Quit and reopen the terminal app

3. virtual env `brew install pyenv-virtualenv`

4. Without Rosetta 2
```
$ pyenv install 3.9.6
$ pyenv virtualenv 3.9.6 NAME
$ pyenv activate NAME
$ pyenv deactivate
$ pyenv uninstall NAME
$ pyenv versions  # list versions
```

Older versions -> [Docker](#docker)

### Tensorflow
* [tensorflow-metal](https://developer.apple.com/metal/tensorflow-plugin/)


## Git
1. Git CLI
```
$ brew install gh
$ gh auth login   # Use HTTPS
```

2. Git configulation file
Edit by `git config --global --edit`
```
#This is Git's per-user configuration file.
[user]
email = Email address registered at GitHub
```


## Inkscape
[via Homebrew](https://blog.looseknot.jp/mac/m1mac_inkscape_install.html)

```
$ brew tap homebrew/cask
$ brew install inkscape
$ inkscape  # launch (to use built-in LaTeX extension)
```

## Docker
Install docker following the official website (with Rosetta 2).

[More details on Docker](https://github.com/Shusei-E/Code_Tips/tree/master/Docker)

## Vim
Install from MacVim's official website. Other settings are [here](https://github.com/Shusei-E/Code_Tips/tree/master/MacOS/MacVim).


## VSCode
1. Check [this foler](https://github.com/Shusei-E/Code_Tips/tree/master/MacOS/VSCode)
2. You need `Remote-Containers` for Docker

Spell checking: Check [this](https://github.com/satokaz/hitorigoto/issues/29).



## Other softwares
* Skim
* Adobe Acrobat Reader
