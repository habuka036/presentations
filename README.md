# presentations
documents and tools for my presentations

# コンテナイメージ habuka036:rabbit で提供する Rabbit 環境の使い方

各コマンドの値は参考値です。実際の環境の値に合わせて変更してください。

```
ホスト側(ターミナル1つ目)にて
$ export VERSION=latest
$ sudo -E docker pull habuka036/rabbit:${VERSION}
$ sudo -E docker run --rm -it -e DISPLAY=localhost:10.0 -v `pwd`:/var/slide habuka036/rabbit:${VERSION} bash
↑を実行後、このターミナルはホスト側ではなくコンテナ側になりますので、そのまま同じターミナルで↓以下を実行します。

コンテナ側(ターミナル1つ目)にて
# /etc/init.d/ssh start
# passwd
↑ホスト側からコンテナ側に ssh でログインするために root のパスワードを設定しておきます
# ifconfig | grep inet | head -n 1
↑ホスト側からコンテナ側に ssh でログインするためにコンテナ側の IP アドレスを確認しておきます

ホスト側(ターミナル2つ目)にて
$ ssh -X localhost
$ ssh -R 6010:localhost:6010 root@コンテナのIP

ホスト側(ターミナル3つ目)にて
$ xauth list | grep "unix:10" | cut -d'/' -f2
↑の xauth の出力を↓で使用

コンテナ側(ターミナル1つ目)にて
# xauth add unix:10  MIT-MAGIC-COOKIE-1  98b924b412dd76c2dced4f1b39d90aa2
# rabbit --size=960,540 /var/slide/資料.md
```
