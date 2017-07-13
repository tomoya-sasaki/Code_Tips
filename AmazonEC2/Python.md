# Amazon EC2 Python

# Access
## 1. Set key
`chmod 400 KEY.pem`

## 2. Access
`ssh -i /Users/KEY.pem ec2-user@ec2-**-***-**-**.***.compute.amazonaws.com`

## 3. Exit
`exit`

# Setup
## 1. Update
`sudo yum update`

## 2. Set password
`sudo passwd`

## 3. Install Dependencies
```terminal
sudo yum install gcc
sudo yum install zlib-devel
sudo yum install openssl-devel
sudo yum install bzip2-devel
sudo yum install readline-devel
sudo yum -y install make automake gcc gcc-c++ kernel-devel git-core  # ビルドツールのインストール
sudo yum groupinstall "Development tools"
sudo yum install python-devel libpng-devel freetype-devel

#sudo yum install zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel
```

## 4. Install Python
```termial
sudo wget https://www.python.org/ftp/python/3.6.1/Python-3.6.1.tgz
sudo tar zxfv Python-3.6.1.tgz

mkdir usr ; cd usr ; mkdir local ; cd ; cd Python-3.6.1
sudo ./configure --prefix=/usr/local

sudo make ; sudo make install

# If you cannot use pip, try this:
sudo passwd root # ここでrootを弄っているみたいだから注意 (yumとかもsuでrootに入らないとできない)
su
visudo
ここで、Defaults secure_path = /sbin:/bin:/usr/sbin:/usr/bin:/usr/local/binと/usr/local/binを追加、:wqで保存して終了
exit # rootから出る
curl -kL https://raw.github.com/pypa/pip/master/contrib/get-pip.py | python3  #pipのインストール (もしかしたら不要だったかも)
```

Use virtual environments (`deactivate` to exit)
```terminal
cd
python3 -m venv my_venv
source my_venv/bin/activate
```

Note:
```terminal
# lxmlのインストールの前には次をsuして(rootとして)実行した
sudo yum install libxml2-devel libxslt-devel python-devel
```


# References
* [Python 開発用サーバの構築手順（AWS + Anaconda）](http://qiita.com/Salinger/items/c7b87d7000e48be6ebe2)
* [Amazon Linux (EC2)上でPython3とDjangoをインストールして、Webサーバを動かす](http://qiita.com/KeijiYONEDA/items/f9cf37cfc359aa893797)
  * Use built-in Python on Amazon Linux
