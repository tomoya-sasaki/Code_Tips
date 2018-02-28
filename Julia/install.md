# Install

## Use from Terminal
```terminal
$ vi .bashrc
```
and add
```txt
alias julia='exec '/Applications/Julia-***.app/Contents/Resources/julia/bin/julia''
```
then
```terminal
$ vi .bash_profile
```
and add
```txt
source ~/.bashrc
```
Lastly,
```terminal
$ source .bash_profile
```
