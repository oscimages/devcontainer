# 開発コンテナ

開発用のコンテナです。

``Ubuntu``をベースに、開発コンテナに必要な下記が設定されています。

* git
* sudo
* asdf

## ビルド

```
make build
```

## 実行

```
make run
```

## リリース

mainブランチが最新か確認します。

```
git fetch -p
git checkout main
git status
```

バージョンを設定します。

```
SEM_VER=1.0.0
```

タグをつけます。

```
git tag -a -m "v$SEM_VER=1.0.0" v$SEM_VER
```

リリースします。

```
git push
```
