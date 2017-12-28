# PHP
* [Tutorial](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/install-LAMP.html)

## Allow connections
SSH (port 22), HTTP (port 80), and HTTPS (port 443)

## Connect to the instance
Set key (first time)
```terminal
$ chmod 400 KEY.pem
```

Access
```terminal
$ ssh -i /Users/KEY.pem ec2-user@ec2-**-***-**-**.***.compute.amazonaws.com
```

## Set up

Update
```terminal
$ sudo yum update -y
```

Set password
```terminal
$ sudo passwd
```

Install software packages
```terminal
$ sudo yum install -y httpd24 php70 mysql56-server php70-mysqlnd
```

Start web server
```terminal
$ sudo service httpd start
```

Configure the Apache web server
```terminal
$ sudo chkconfig httpd on
$ chkconfig --list httpd
httpd           0:off   1:off   2:on    3:on    4:on    5:on    6:off
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
