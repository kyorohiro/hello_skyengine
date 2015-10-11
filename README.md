# Flutter (skyengine)

本書は、kyorohiroがFlutterについて試行錯誤した時のメモです。

### Flutterがリリースされた
Dart Mobile として、Flutterがリリースされました。｀
Dart Mobile といえば、Chrome Mobile を利用したフレームワークを思い浮かぶかも知れません。
残念ながら別物です。

Chrome Mobileは一度Javascriptに変換してあげて、Phonegapを利用してiOS、Android上で動作させる仕組みてした。
FlutterはMojoをベースとしてDart VM上で動作する別物のフレームワークです。

### 内容

各機能のサンプルアプリ


## REF
* http://flutter.io/
* https://github.com/domokit/mojo

## CONTENT

* [hello](doc/hello/README.md)
  * [helloworld](hello/doc/README.md)
* [rendering](doc/rendering/README.md)
  * [draw_rect](draw_rect/doc/README.md)
  * [anime_rect](anime_rect/doc/README.md)
  * [anime_rect(use animation.dart)](anime_rect_1/doc/README.md)
  * [draw_image](draw_image/doc/README.md)
  * [rotate_image](rotate_image/doc/README.md)
  * [sound_test](sound_test/doc/README.md)
  * [touch_test](touch_event/doc/README.md)
  * [multitouch_test](multitouch_event/doc/README.md)
  * [try to make a mini game(spacewar!)](spacewar/doc/README.md)
  * [draw_text](draw_text/doc/README.md)
  * [draw_path](draw_path/doc/README.md)
  * [draw_vertexs](draw_vertices/doc/README.md)
  * [draw_vertexs_with_image](draw_vertices_1/doc/README.md)
  * [try to make a mini game 3d like]
  * [input text from ime(RenderObject)](edit_text_1/doc/README.md)
* [widget](doc/widgets/README.md)
  * [input text from ime(EditableText)](edit_text/doc/README.md)
* [mojo](doc/mojo/README.md)
  * [get and post request](mojo_urlRequest/doc/README.md)
  * [sensor test](mojo_sensor/doc/README.md)
  * [gravity sensor demo](mojo_sensor_demo/doc/README.md)
