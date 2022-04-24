# Azure


## SSH Access
```terminal
ssh -i /Users/KEY.pem <User Name>@<IP address>
```

## Set up
Check [this], but change `yum` to `apt-get`.

```
sudo apt-get install gcc
sudo apt-get install zlib-devel
sudo apt-get install openssl-devel
sudo apt-get install bzip2-devel
sudo apt-get install readline-devel
sudo apt-get -y install make automake gcc gcc-c++ kernel-devel git-core  # ビルドツールのインストール
sudo apt-get groupinstall "Development tools"
sudo apt-get install python-devel libpng-devel freetype-devel
```
One line:
```
sudo apt-get install gcc zlib-devel openssl-devel bzip2-devel readline-devel ; sudo apt-get -y install make automake gcc gcc-c++ kernel-devel git-core ; sudo apt-get groupinstall "Development tools" ; sudo apt-get install python-devel libpng-devel freetype-devel; sudo apt-get install gcc zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel
```
