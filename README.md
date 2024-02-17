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

## 機能

### 二項演算子

以下の二項演算子をサポートしています。

- `+`
- `-`
- `*`
- `/`
- `<`
- `<=`
- `>`
- `>=`
- `==`
- `!=`

例:

```json
{
    "type": "+",
    "left": 3,
    "right": 4
}
```

### 変数の宣言と代入

変数の宣言と代入をサポートしています。どちらも代入演算子によって行われます。

代入は式であり、代入された値が結果になります。以下の例では、`x`に`3`を代入し、式全体の結果は`3`です。

例:

```json
{
    "type": "assign",
    "name": "x",
    "value": 3
}
```

### if 式

if 式をサポートしています。

例:

```json
{
    "type": "if",
    "condition": {
        "type": "==",
        "left": 1,
        "right": 2
    },
    "then": 1,
    "else": 2
}
```

このJSONをJavaScript風の構文で表すと以下のようになります:

```js
if (1 == 2) {
    1;
} else {
    2;
}
```

### while 式

while 式をサポートしています。while 式は常に `nil` を返します。

例:

```json
[
    {
        "type": "assign",
        "name": "x",
        "value": 0
    },
    {
        "type": "while",
        "condition": {
            "type": "!=",
            "left": {
                "type": "id",
                "name": "x"
            },
            "right": 10
        },
        "body": {
            "type": "assign",
            "name": "x",
            "value": {
                "type": "+",
                "left": {
                    "type": "id",
                    "name": "x"
                },
                "right": 1
            }
        }
    },
    {
        "type": "id",
        "name": "x"
    }
]
```

このJSONをJavaScript風の構文で表すと以下のようになります:

```js
let x = 0;
while (x != 10) {
    x++;
}
x;
```

### 関数宣言と関数呼び出し

関数の宣言と呼び出しをサポートしています。

例:

```json
[
    {
        "type": "def",
        "name": "f",
        "params": [
            "x"
        ],
        "body": {
            "type": "+",
            "left": {
                "type": "id",
                "name": "x"
            },
            "right": 1
        }
    },
    {
        "type": "call",
        "name": "f",
        "args": [
            2
        ]
    }
]
```

このJSONをJavaScript風の構文で表すと以下のようになります:

```js
function f(x) {
  return x + 1;
}
f(2);
```

### 配列

配列と、インデックスを使った要素へのアクセスをサポートしています。

例:

```json
[
    {
        "type": "assign",
        "name": "x",
        "value": [1, 2, 3, 4]
    },
    {
        "type": "index",
        "array": {
            "type": "id",
            "name": "x"
        },
        "index": 3
    }
]
```

このJSONをJavaScript風の構文で表すと以下のようになります:

```js
const x = [1, 2, 3, 4];
x[3];
```
