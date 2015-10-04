# HelloWorld

## 環境の設定
2015/10/1の時点では、Flutterの開発環境としてはAtomが良い感じです。ですが、まずはメモ帳から初めてみましょう。

* 公式サイトの[Getting Start with Flutter]( http://flutter.io/getting-started/)

### Dart SDKをインストール
コマンドラインから、pubコマンドとdartコマンドを使えるようにしましょう。

#### Macの場合
brew tap dart-lang/dart && brew install dart --devel


### Android SDKのインストール
adbコマンドが使えるようにしましょう。


## アプリを作成する。
#### pubspec.yamlを作成する
```
name: hello
dependencies:
  sky: any
  sky_tools: any
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
import 'package:sky/widgets.dart';

void main() {
  Text t = new Text("Hello World");
  Center c= new Center (child: t);
  runApp(c);
}
```

