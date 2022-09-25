# PHP
* [Tutorial 1](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/install-LAMP.html)
* [Tutorial 2](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-lamp-amazon-linux-2.html)

* Amazon Linux 1
* Amazon Linux 2: We should use this now.

## Allow connections
SSH (port 22), HTTP (port 80), and HTTPS (port 443)
* SSH: My IP
* HTTP/HTTPS: `0.0.0.0/0`and `::/0`

## Connect to the instance
Set key (first time)
```terminal
$ chmod 400 KEY.pem  # 600を使わないといけないかも
```

Access
```terminal
$ ssh -i /Users/KEY.pem ec2-user@ec2-**-***-**-**.***.compute.amazonaws.com
```

Security groupのSSHのIPアドレスの設定が正しくなっているか注意 (Custom IPの場合)

## Set up

### Update
```terminal
$ sudo yum update -y
```

### Set password
```terminal
$ sudo passwd
```

### Install software packages
Amazon Linux 1
```terminal
$ sudo yum install -y httpd24 php70 mysql56-server php70-mysqlnd
```
Amazon Linux 2
```terminal
$ sudo amazon-linux-extras install lamp-mariadb10.2-php7.2
$ sudo yum install -y httpd php mariadb-server php-mysqlnd
```

### Start web server
Amazon Linux 1
```terminal
$ sudo service httpd start
```

Amazon Linux 2
```terminal
$ sudo systemctl start httpd
```

### Configure the Apache web server
Amazon Linux 1
```terminal
$ sudo chkconfig httpd on
$ chkconfig --list httpd
httpd           0:off   1:off   2:on    3:on    4:on    5:on    6:off
```

Amazon Linux 2
```terminal
$ sudo systemctl enable httpd  # configure the Apache web server
$ sudo systemctl is-enabled httpd  # verify that httpd is on
```

Test. Access Public DNS. You'll see "Amazon Linux AMI Test Page"
```
ec2-54-***-***-**.***.compute.amazonaws.com
```

## Set file permissions

Add use to the Apache group
```terminal
$ sudo usermod -a -G apache ec2-user
```

Log out and log in again to choose the new group
```terminal
$ exit
$ ssh -i ... # log in again
$ groups
ec2-user wheel apache
```

Change the ownership of `/var/www` and its contents to the apache group
```terminal
$ sudo chown -R ec2-user:apache /var/www
$ sudo chmod 2775 /var/www
$ find /var/www -type d -exec sudo chmod 2775 {} \;
$ find /var/www -type f -exec sudo chmod 0664 {} \;
```

Make it writable:
```terminal
$ chmod u=rw,g=rw,o=rw test.txt
$ ls -l text.txt
```

## Use HTTPS
Haven't tried: [website](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/SSL-on-an-instance.html)

## Upload PHP
```terminal
$ scp -i /Users/***/***.pem /Users/***/test.php ec2-user@ec2-**-***-***-***.***.compute.amazonaws.com:/var/www/html/
```
Access: http://ec2-**-***-***-***.***.compute.amazonaws.com/test.php (Use public DNS)
