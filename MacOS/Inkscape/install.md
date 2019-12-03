# Install

## Latex Plug-in
Use [textext](https://pav.iki.fi/software/textext/).

## Install
We can follow [the instruction](https://textext.github.io/textext/install/macos.html) (using Homebrew to install). However, I had to copy files that `setup.py` generates to `/Users/***/.config/inkscape/extensions`. `textext.inx` should be outside of the `textext` folder.

## Old Info

### postoedit
```terminal
$ brew install pstoedit
```
### texttext
Download `tar.gz` from the website. Move `textext.inx` and `textext.py` to `~/.config/inkscape/extensions/`.

### Put symbolic link
By creating symolic link, you can use `cd` command.
```terminal
$ ln -s /Library/TeX/texbin/pdflatex /usr/local/bin/
```
You can find pdflatex by
```terminal
$ which pdflatex
```
You need to restart the application (including X11).

### Setting
Prepare `textext.ini`
```
\usepackage{amsmath}
\usepackage{amsfonts}
```

### Alternative option
Use LaTexiT and save as `.svg`. `brew install pdf2svg` is required.
