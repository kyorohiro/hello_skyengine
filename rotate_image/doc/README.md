# Rotate Image

https://github.com/kyorohiro/hello_skyengine/tree/master/rotate_image

![](screen.png)


```
// following code is checked in 2015/11/07
//
// need flutter.yaml from 2016/01/13
//
import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as sky;
import 'dart:async';
import 'package:flutter/services.dart';

main() async {
  runApp(new DrawImageWidget());
}

class ImageLoader {
  static Future<sky.Image> load(String url) async {
    AssetBundle bundle = getAssetBundle();
    ImageResource resource = bundle.loadImage(url);
    return resource.first;
  }

  static AssetBundle getAssetBundle() {
    if (rootBundle != null) {
      return rootBundle;
    } else {
      return new NetworkAssetBundle(new Uri.directory(Uri.base.origin));
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
  double sx = 1.0;
  double sy = 1.0;
  double radians = 0.0;
  sky.Image image = null;

  @override
  void performLayout() {
    size = constraints.biggest;
  }

  @override
  bool hitTest(HitTestResult result, {Point position}) {
    result.add(new BoxHitTestEntry(this, position));
    return true;
  }

  void loadImage() {
    if (image == null) {

      ImageLoader.load("assets/a.png").then((sky.Image img) {
        image = img;
        // "assets/icon.jpeg" is error 2015/12/13 's flutter
        this.markNeedsPaint();
      });
    }
  }

  void paint(PaintingContext context, Offset offset) {
    loadImage();
    Paint paint = new Paint()
      ..color = new Color.fromARGB(0xff, 0xff, 0xff, 0xff);
    if (image == null) {
      Rect rect = new Rect.fromLTWH(x, y, 50.0, 50.0);
      context.canvas.drawRect(rect, paint);
    } else {
      context.canvas.setMatrix(new Matrix4.identity().storage);
      context.canvas.translate(10.0, 10.0);
      for (int i = 0; i < 3; i++) {
        context.canvas.translate(x + 5, y + 5);
        context.canvas.rotate(0.3);
        context.canvas.scale(0.5, 0.5);
        context.canvas.drawImage(image, new Point(0.0, 0.0), paint);
      }
      context.canvas.setMatrix(new Matrix4.identity().storage);
      context.canvas.translate(10.0, 400.0);
      for (int i = 0; i < 3; i++) {
        context.canvas.translate(x - 5, y - 5);
        context.canvas.rotate(-0.3);
        context.canvas.scale(0.5, 0.5);
        context.canvas.drawImage(image, new Point(0.0, 0.0), paint);
      }
    }
  }
}

```


```
# flutter.yaml
assets:
  - assets/icon.jpeg
  - assets/a.png

```
