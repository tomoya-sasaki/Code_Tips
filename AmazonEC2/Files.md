# Files

## Upload
```terminal
$ mkdir my_data
$ ls

scp -i [.pem File] [Upload file] ec2-user@ec2-xx-xxx-xxx-xxx.us-2.compute.amazonaws.com:~/my_data/
# [] --> file path
# You can use wild card: *.csv
```

## Download
```terminal
scp -i [.pem File] ec2-user@ec2-xx-xxx-xxx-xxx.us-2.compute.amazonaws.com:~/my_data/Donload.file [Download directory]
```
