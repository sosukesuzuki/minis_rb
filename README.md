# minis_rb

## 概要

minis_rb は [minis](https://github.com/kmizu/minis/tree/main/minis) の Ruby 実装です。筑波大学 の ソフトウェアサイエンス特別講義 A の課題として作成されました。

## 使い方

構文木を JSON で記述したファイルのパスを指定するとそのプログラムを評価し、結果を返します。たとえば以下の内容で `program.json` を作成します。

```json
[
    {
        "type": "+",
        "left": 3,
        "right": 4
    }
]
```

このとき、以下のコマンドを実行すると、7 と表示されます。

```sh
$ ./bin/minis program.json
7

```
