# VSCodeの開発コンテナ

VSCodeの開発コンテナです。

``Ubuntu``をベースに、開発コンテナに必要な下記が設定されています。

* Git
* sudo
* vscodeユーザの作成

開発コンテナは、ホストOSが下記のいずれかを前提としています。

* EC2/Ubuntu+docker
* Mac/MacOS+rancher

開発コンテナは、ホストOSのディレクトリをマウントしますが、ファイルオーナ（UID/GID）は、ホストOSに合わせる必要があります。

## 作成手順

EC2用は、下記の手順です。

```
$ make -n
docker build  -t devcontainer .
```

Mac用は、下記の手順です。

```
$ make OPTS="--build-arg USER_GID=20 --build-arg USER_UID=501" -n
docker build --build-arg USER_GID=20 --build-arg USER_UID=501 -t devcontainer .
```
