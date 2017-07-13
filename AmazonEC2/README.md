# Amazon EC2

# Inbound Rules
* HTTP TCP 80
* SSH TCP 22
* HTTPS TCP 443

# Show full path
`readlink -f file.txt`

# Screen
ログアウトしても処理を続けるためには、screen内で回せばOK

screenでウィンドウに入ってコードを回す。[Control+a] + d で初めの画面に戻る。
またscreenと打てば新しいウィンドウに入れる。

`screen -list`とすれば、今作成されているのウィンドウ一覧が出てくる。
```
There are several suitable screens on:
3xxx.pts-x.ip-xxx-xx-xx-xxx (Detached)
3xxx.2 (Detached)
3xxx.pts-x.ip-xxx-xx-xx-xxx (Detached)
```

`screen -r 3xxx.pts-x.ip-xxx-xx-xx-xxx`のようにすることで、指定したscreenに入れる。一つしかスクリーンを作っていなければ、`screen -rD`でOK。

screenを開いた後で、その開いているスクリーンを閉じるには、[Control+a] + k

今回は、7つを同時にまわしたいから、一つscreenを作って、そこからタブを作るような感覚で広げていくと良さそう。
* Ctrl+a, cでスクリーンの新規作成を行う
* Ctrl+a, nで次のスクリーンへ
* Ctrl+a, pで前のスクリーン

# Storage
`$ df -h`
