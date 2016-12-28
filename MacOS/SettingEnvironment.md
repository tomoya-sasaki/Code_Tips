# Setting Environment

## 2016/12/28
### Homebrew
#### R
* `brew upgrade xxx`

### Manual Install
#### XCode
* From AppStore

#### RStudio
* From website

#### Python
* `$ brew install pyenv`
* `$ pyenv install 3.5.2`
 * If error occures, try `xcode-select --install` and install again
* `$ brew install pyenv-virtualenv`
* Usage of pyenv-virtualenv
  * It's easier to use virtualenv than pyenv to use multiuple versions of Python
  * Make a new environment: `$ pyenv virtualenv 3.5.2 NAME`
  * Activate the environment: `$ pyenv activate NAME`
  * Deactivate the environment: `$ pyenv deactivate`
  * Delete the environment:　`$ pyenv uninstall NAME`

   
### In R
#### RStan
* `install.packages('rstan', dependencies=T)`
