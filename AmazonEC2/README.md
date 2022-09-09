# Amazon EC2

# Inbound Rules
* HTTP TCP 80
* SSH TCP 22
* HTTPS TCP 443

# Show full path
`readlink -f file.txt`

## Current path
`pwd`

# Screen
ログアウトしても処理を続けるためには、screen内で回す必要がある。

`screen`でウィンドウに入ってコードを回す。`[Control+a] + d`で初めの画面に戻る。
また`screen`と打てば新しいウィンドウに入れる。

`screen -list`とすれば、今作成されているのウィンドウ一覧が出てくる。
```
There are several suitable screens on:
3xxx.pts-x.ip-xxx-xx-xx-xxx (Detached)
3xxx.2 (Detached)
3xxx.pts-x.ip-xxx-xx-xx-xxx (Detached)
```

`screen -r 3xxx.pts-x.ip-xxx-xx-xx-xxx`のようにすることで、指定したscreenに入れる。一つしかスクリーンを作っていなければ、`screen -rD`でOK。

Screen with a name:
```terminal
$ screen -S NAME
$ screen -r NAME  /  screen -xS NAME
```


screenを開いた後で、その開いているスクリーンを閉じるには、`[Control+a] + k`

複数のスクリーンが必要な場合は、一つscreenを作って、そこからタブを作るような感覚で広げていくと良い。
* `Ctrl+a, c`でスクリーンの新規作成を行う
* `Ctrl+a, n`で次のスクリーンへ
* `Ctrl+a, p`で前のスクリーン

# Status
## Storage
`$ df -h .`

## Memory
`$ free -m`

Free memory:
`echo 3 | sudo tee /proc/sys/vm/drop_caches > /dev/null`

## Use swap
Create 1.5GB:
```terminal
$ free -m
             total       used       free     shared    buffers     cached
Mem:          3714       3010        703          0         10         72
-/+ buffers/cache:       2927        786
Swap:            0          0          0
$ swapon -s
$ df -h
$ sudo dd if=/dev/zero of=/swapfile bs=1024 count=1500k
$ sudo chmod 600 /swapfile
$ sudo mkswap /swapfile
$ sudo swapon /swapfile    # Turn on swap
$ swapon -s
$ echo 3 | sudo tee /proc/sys/vm/drop_caches > /dev/null
```

Turn off:
```
$ sudo swapoff /swapfile 
```

Automatically turn on:
```
$ sudo vi /etc/fstab
```


# Try Later
* `awe.s3`: R package to access ASW S3
