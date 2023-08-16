# presentations
documents and tools for my presentations

# コンテナイメージ habuka036:rabbit で提供する Rabbit 環境の使い方

各コマンドの値は参考値です。実際の環境の値に合わせて変更してください。

```
ホスト側にて
$ export VERSION=latest
$ sudo -E docker pull habuka036/rabbit:${VERSION}
$ sudo -E docker run --rm -it -e DISPLAY=localhost:10.0 -v `pwd`:/var/slide habuka036/rabbit:${VERSION} bash

コンテナ側にて
# /etc/init.d/ssh start
# passwd

ホスト側にて
$ ssh -X localhost
$ ssh -R 6010:localhost:6010 root@コンテナのIP
$ xauth list | grep "unix:10" | cut -d'/' -f2
↑の xauth の出力を↓のコンテナ側のコマンドで使用

コンテナ側にて
# xauth add unix:10  MIT-MAGIC-COOKIE-1  98b924b412dd76c2dced4f1b39d90aa2
# rabbit --size=960,540 /var/slide/資料.md
```

