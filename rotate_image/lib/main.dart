import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as sky;
import 'dart:async';
import 'package:flutter/src/services/fetch.dart';

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
  double sx = 1.0;
  double sy = 1.0;
  double radians = 0.0;
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
