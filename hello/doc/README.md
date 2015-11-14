# HelloWorld

https://github.com/kyorohiro/hello_skyengine/tree/master/hello

![](screen.png)

```
import 'package:flutter/widgets.dart';

void main() {
  Text t = new Text("Hello World");
  Center c= new Center (child: t);
  runApp(c);
}

```

## 環境の設定
2015/10/1の時点では、Flutterの開発環境としてはAtomが良い感じです。ですが、まずはメモ帳から初めてみましょう。

* 公式サイトの[Getting Start with Flutter]( http://flutter.io/getting-started/)

### Dart SDKをインストール
コマンドラインから、pubコマンドとdartコマンドを使えるようにしましょう。

* [Macの場合]
```
brew tap dart-lang/dart && brew install dart --devel
```


### Android SDKのインストール
adbコマンドが使えるようにしましょう。
TODO
* [Android SDK](https://developer.android.com/sdk/installing/index.html?pkg=tools)


### Flutter のインストール

```
git clone https://github.com/flutter/flutter.git -b alpha

export PATH=`pwd`/flutter/bin:$PATH
```

~~pub get~~
~~pub global activate flutter~~

## アプリを作成する。
#### pubspec.yamlを作成する
```
name: hello
dependencies:
  sky: any
  flutter: any
  sky_tools: any
dependency_overrides:
  flutter:
    path: <cloneしたパス>/packages/flutter
```

#### libフォルダを作成する
```
./pubspec.yaml
./lib/
```
#### Pubコマンドでsky関連のライブラリをダウンロードする

"./" で、pubコマンドを入力する。
```
> pub get
..
..
> pub upgrade
..
..
``

```
#### mainプログラムを書く
"./lib/main.dart" を作成して以下を書く。
```
import 'package:flutter/widgets.dart';

void main() {
  Text t = new Text("Hello World");
  Center c= new Center (child: t);
  runApp(c);
}
```

#### アプリを起動する
"./" で、以下のコマンドを入力する。


```
flutter start --checked -t ./lib/main.dart
```

これで完了です。


