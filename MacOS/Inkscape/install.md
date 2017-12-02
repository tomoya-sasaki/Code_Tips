# Install

## Latex Plug-in
Use [textext](https://pav.iki.fi/software/textext/).

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

**ERROR**
It does not work due to the error reported [here](https://github.com/Homebrew/homebrew-core/issues/13398).

### Alternative option
Use LaTexiT and save as `.svg`. `brew install pdf2svg` is required.
