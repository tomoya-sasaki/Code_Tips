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

### Set priority for multiple versions
[Reference](https://qiita.com/piyo_parfait/items/5abbe4bee2495a62acdc)

```terminal
$ python3 -V
Python 3.8.5

$ which python3
/usr/bin/python3

$ which update-alternatives
/usr/bin/update-alternatives

$ ls /usr/bin/ | grep python
python3
python3.8
python3.8-config
python3.9
python3.9-config
python3-config

$ sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.9 1   # first priority
update-alternatives: using /usr/bin/python3.9 to provide /usr/bin/python3 (python3) in auto mode

$ python3 -V
Python 3.9.5
```

### Installing packages
```terminal
$ sudo pip install XXX
```
