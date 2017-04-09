# Setting Environment 2016/12/28

## Homebrew
### R
* `brew upgrade xxx`

## Manual Install
### XCode
* From AppStore

### RStudio
* From website

### Python
* `$ brew install pyenv`

Update `bash_profile`:
```
vi ~/.bash_profile
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
* `$ pyenv install 3.5.2` 
 * If error occures, try `xcode-select --install` and install again
* `$ brew install pyenv-virtualenv`
* Usage of pyenv-virtualenv
  * It's easier to use virtualenv than pyenv to use multiuple versions of Python
  * List Available Versions: `$ pyenv install -l`
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

## Keyboard Shortcuts
* Keyboard -> Shortcuts -> App Shortcuts -> Add(+)
* Help: Create keyboard shortcuts for apps
