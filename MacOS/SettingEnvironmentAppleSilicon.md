# Setting Environment for Apple Silicon

* Setting up in English, area is Japan
* Don't use Migration Assistant, manually move files from Time Machine

Be careful:
* Terminal uses `zsh` so make `.zprofile` instead of `.bash_profile` ([Reference](https://leico.github.io/TechnicalNote/Mac/catalina-zsh))

## Starting
```
# 1: XCode
$ xcode-select --install

# 2: Homebrew (check below)

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


## LaTeX
```
$ brew install wget xz
$ brew install --cask mactex
$ sudo tlmgr update --self --all
```

* TeXShop: TeXShopの環境設定の［書類］タブの左下の［設定プロファイル］から「upTeX (ptex2pdf)」を選択


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



## Other softwares
* Skim
* Adobe Acrobat Reader
