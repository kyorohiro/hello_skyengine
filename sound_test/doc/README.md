# Sound Test

https://github.com/kyorohiro/hello_skyengine/tree/master/draw_image

![](screen.png)

```
import 'package:sky/widgets.dart';
import 'package:sky/rendering.dart';
import 'dart:sky' as sky;
import 'dart:async';
import 'package:sky/src/services/fetch.dart';

main() async {
  runApp(new DrawImageWidget());
}

class ImageLoader {
  static Future<sky.Image> load(String url) async {
    UrlResponse response = await fetchUrl(url);
    if (response.statusCode >= 400) {
      throw "failed load ${url}";
    } else {
      Completer<sky.Image> completer = new Completer();
      sky.ImageDecoder decoder = new sky.ImageDecoder.consume(
          response.body.handle.h, completer.complete);
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
      ImageLoader.load("icon.jpeg").then((sky.Image img) {
        image = img;
        this.markNeedsPaint();
      });
    }
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