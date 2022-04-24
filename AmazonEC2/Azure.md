# Azure


## SSH Access
```terminal
ssh -i /Users/KEY.pem <User Name>@<IP address>
```

## Set up: Python
Check [this], but change `yum` to `apt-get`.

```
sudo apt-get install gcc
sudo apt-get install zlib1g-dev
sudo apt-get install libssl-dev
sudo apt-get install bzip2
sudo apt-get install libreadline-dev
sudo apt-get install -y build-essential git-core cmake doxygen  # ビルドツールのインストール
sudo apt-get install -y autoconf automake gdb git libffi-dev
sudo apt-get install -y python3.9-dev libpng-dev libfreetype6-dev
sudo apt-get install -y tk-dev 
```
One line:
```
sudo apt-get install gcc zlib1g-dev libssl-dev bzip2 libreadline-dev ; sudo apt-get install -y build-essential git-core cmake doxygen ; sudo apt-get install -y autoconf automake gdb git libffi-dev ; sudo apt-get install -y python3.9-dev libpng-dev libfreetype6-dev
;
# sudo apt-get install sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel
```
