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


## Disk
[Reference](https://docs.microsoft.com/en-us/azure/virtual-machines/linux/attach-disk-portal)

```terminal
$ lsblk -o NAME,HCTL,SIZE,MOUNTPOINT | grep -i "sd"
sda     0:0:0:0      30G
├─sda1             29.9G /
├─sda14               4M
└─sda15             106M /boot/efi
sdb     0:0:0:1      75G
└─sdb1               75G /mnt
sdc     1:0:0:0     128G

# Only for the first time: partitioning
$ sudo parted /dev/sdc --script mklabel gpt mkpart xfspart xfs 0% 100%
$ sudo mkfs.xfs /dev/sdc1
$ sudo partprobe /dev/sdc1

# Mounting
$ sudo mkdir /mydata
$ sudo mount /dev/sdc1 /mydata
$ sudo blkid
/dev/sda1: LABEL="cloudimg-rootfs" UUID="11111111-1b1b-1c1c-1d1d-1e1e1e1e1e1e" TYPE="ext4" PARTUUID="1a1b1c1d-11aa-1234-1a1a1a1a1a1a"
/dev/sda15: LABEL="UEFI" UUID="BCD7-96A6" TYPE="vfat" PARTUUID="1e1g1cg1h-11aa-1234-1u1u1a1a1u1u"
/dev/sdb1: UUID="22222222-2b2b-2c2c-2d2d-2e2e2e2e2e2e" TYPE="ext4" TYPE="ext4" PARTUUID="1a2b3c4d-01"
/dev/sda14: PARTUUID="2e2g2cg2h-11aa-1234-1u1u1a1a1u1u"
/dev/sdc1: UUID="33333333-3b3b-3c3c-3d3d-3e3e3e3e3e3e" TYPE="xfs" PARTLABEL="xfspart" PARTUUID="c1c2c3c4-1234-cdef-asdf3456ghjk"

$ sudo nano /etc/fstab
   # Edit following the reference manual
   UUID=33333333-3b3b-3c3c-3d3d-3e3e3e3e3e3e   /datadrive   xfs   defaults,nofail   1   2
      
# Verification
lsblk -o NAME,HCTL,SIZE,MOUNTPOINT | grep -i "sd"
```

### Memo
* `/dev/sdb1`: temporary disk
