# Draw Image

https://github.com/kyorohiro/hello_skyengine/tree/master/draw_image

![](screen.png)

This code is checked in 2015/11/05. but, failed to draw image!!

* check following code is drawable image.
[draw_image_from_assets](../../draw_image_from_assets/doc/README.md)


```
//
// following code is checked in 2015/11/05. but, failed to draw image!!
//
import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'dart:async';
import 'package:flutter/src/services/fetch.dart';
import 'dart:ui' as sky;
main() async {
  runApp(new DrawImageWidget());
}

class ImageLoader {
  static Future<sky.Image> load(String url) async {
    UrlResponse response = await fetchUrl(url);
    if (response.body == null) {
      throw "failed load ${url}";
    } else {
      // normally use following
      // import 'package:flutter/services.dart';
      // Future<ui.Image> decodeImageFromDataPipe(MojoDataPipeConsumer consumerHandle)
      // Future<ui.Image> decodeImageFromList(Uint8List list) {
      Completer<sky.Image> completer = new Completer();
      sky.decodeImageFromDataPipe(response.body.handle.h, (sky.Image image) {
        completer.complete(image);
      });
      return completer.future;
    }
  }
}

class DrawImageWidget extends OneChildRenderObjectWidget {
  double angle = 0.0;
  RenderObject createRenderObject() {
    return new DrawImageObject();
  }
}

class DrawImageObject extends RenderBox {
  double x = 50.0;
  double y = 50.0;
  sky.Image image = null;

  void loadImage() {
    if (image == null) {
      //"${Uri.base.origin}/");
      ImageLoader.load("icon.jpeg").then((sky.Image img) {
        image = img;
        this.markNeedsPaint();
      });
    }
  }

  @override
  void performLayout() {
    size = constraints.biggest;
  }

  void paint(PaintingContext context, Offset offset) {
    loadImage();
    Paint paint = new Paint()
      ..color = new Color.fromARGB(0xff, 0xff, 0xff, 0xff);
    Point point = new Point(x, y);
    if (image == null) {
      Rect rect = new Rect.fromLTWH(x, y, 50.0, 50.0);
      context.canvas.drawRect(rect, paint);
    } else {
      context.canvas.drawImage(image, point, paint);
    }
  }
}
```
