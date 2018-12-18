# Settings

## Table of Contents
* [Japanese](#japanese)
* [Keymappings](#keymappings)
* [Install softwares](#install-softwares)
    * [gcc](#gcc)
    * [R](#r)

## Japanese
### Change input method
`ConfigureFcitx` -> `Global Config` -> `Trigger Input Method`. After that, go to the system keyboard setting and disable `Alt-Space` keymapping.

### Size of window
`ConfigureFcitx` -> `Addon` -> Check `Advanced` -> Disable `kimpanel`

If you reboot, you can use `Appearence` tab in `Ficix configuration` (you may need to search it from the menu).

[Reference](https://linux.just4fun.biz/?Ubuntu/HiDPI%E3%83%9E%E3%82%B7%E3%83%B3%E3%81%A7Mozc%E3%82%92%E8%B5%B7%E5%8B%95%E3%81%99%E3%82%8B%E3%81%A8%E5%A4%89%E6%8F%9B%E5%80%99%E8%A3%9C%E3%82%A6%E3%82%A4%E3%83%B3%E3%83%89%E3%82%A6%E3%81%8C%E5%B0%8F%E3%81%95%E3%81%84%E5%A0%B4%E5%90%88%E3%81%AE%E5%AF%BE%E5%87%A6)

### Japanese locale
`ConfigureFcitx` -> `Addon` -> `Classic` -> `Configure` -> `Advanced`.

Locale shoud be `ja_JP.UTF-8`.

## Keymappings
### Home and end
Remap home and end to page up and page down. Keyboard keycode values might be different between JP keyboards and US keyboards. Use `$ xev` and find keycodes.

You can check current keymappings with `$ xmodmap -pke`. `keycode 10 = 1 exclam` shows that if you press the key, it is `1` but if you press it with Shift key, it becomes `exclam`.

Create `~/.Xmodmap` and edit. For example,
```
keycode 111 = Prior
keycode 115 = Next
```

You can now `$ xmodmap ~/.Xmodmap` and enjoy your keymappings! Lastly, add an command `/usr/bin/xmodmap /home/YOURUSERNAME/.Xmodmap` in Startup Applications with a delay of 15-20 seconds.

[Reference 1](https://nonsensej.xyz/?p=1226)  
[Reference 2](http://x68000.q-e-d.net/~68user/unix/pickup?xmodmap)  
[Reference 3](http://www.dzhaworks.com/blog/remapping-thinkpads-pageback-and-pageforward-keys-in-mint-linux/)


## Install Softwares
### gcc
```terminal
$ sudo apt update
$ sudo apt install build-essential
```

### R
```terminal
$ apt install r-base
```

If you encounter error, try
```terminal
$ sudo rm -v /etc/apt/sources.list.d/additional-repositories.list
```
[Reference](https://forums.linuxmint.com/viewtopic.php?t=281017)

You many need to packages additionally.
```terminal
$ apt install libcurl4-openssl-dev
$ apt install libxml2-dev
$ apt install libssl-dev
$ apt install libz-dev
```
