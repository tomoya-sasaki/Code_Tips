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
  * Make a new environment: `$ pyenv virtualenv 3.5.2 NAME`
  * Activate the environment: `$ pyenv activate NAME`
  * Deactivate the environment: `$ pyenv deactivate`
  * Delete the environment:　`$ pyenv uninstall NAME`
  
## pip
`pip install jupyter pandas matplotlib beautifulsoup4`

   
## In R
### RStan
* `install.packages('rstan', dependencies=T)`
