# Setting Environment for Apple Silicon

* Setting up with English
* Don't use Migration Assistant, manually move files from Time Machine

## Starting
```
# 1: XCode
$ xcode-select --install

# 2: Homebrew (check below)


# 3: gcc
$ brew install gcc
```

## Homebrew


## R
1. XQuartz
2. [Native R](https://cran.r-project.org/bin/macosx/)
3. [gfortran](https://mac.r-project.org/libs-arm64/) (move files to `opt/R/arm64`)

Add the following to `~/.bash_profile` and `souce ~/.bash_profile`
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


## Python


## Vim



## Inkscape
[via Homebrew](https://blog.looseknot.jp/mac/m1mac_inkscape_install.html)

