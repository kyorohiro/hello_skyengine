import 'package:mojo_services/mojo/camera.mojom.dart';
import 'package:mojo_services/mojo/animations.mojom.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';

import 'dart:typed_data';
import 'dart:async';
import 'dart:ui' as sky;

CameraServiceProxy camera = new CameraServiceProxy.unbound();

main() async {
  shell.requestService("c", camera);
  runApp(new DrawImageWidget());
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

  loadImage() async {
    if (image == null) {
      CameraServiceGetLatestFrameResponseParams param = await camera.ptr.getLatestFrame();
      if(param.content != null) {
        Completer<sky.Image> completer = new Completer();
        sky.ImageDecoder decoder = new sky.ImageDecoder.consume(
          param.content.handle.h, completer.complete);
        image = await completer.future;
      }
      this.markNeedsPaint();
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
