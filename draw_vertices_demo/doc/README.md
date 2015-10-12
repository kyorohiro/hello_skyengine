# Draw Vertexs demo 3d cube

https://github.com/kyorohiro/hello_skyengine/tree/master/draw_vertices_1

![](screen.png)

```
import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as sky;
import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/src/services/fetch.dart';

sky.Image img = null;
main() async {
  img = await ImageLoader.load("icon.jpeg");
  runApp(new DrawVertexsWidget());
}

class DrawVertexsWidget extends OneChildRenderObjectWidget {
  RenderObject createRenderObject() {
    return new DrawVertexsObject();
  }
}

class DrawVertexsObject extends RenderBox {
  void paint(PaintingContext context, Offset offset) {
    context.canvas.translate(50.0, 50.0);
    context.canvas.scale(8.0, 8.0);
    paintWithImage(context, offset);
  }

  void paintWithImage(PaintingContext context, Offset offset) {
    Paint paint = new Paint();
    sky.VertexMode vertexMode = sky.VertexMode.triangleFan;
    List<Point> vertices = [
      new Point(0.0, 0.0),
      new Point(10.0, 50.0),
      new Point(50.0, 60.0),
      new Point(40.0, 10.0)
    ];
    List<Point> textureCoordinates = [
      new Point(0.0, 0.0),
      new Point(0.0, 1.0 * img.height),
      new Point(1.0 * img.width, 1.0 * img.height),
      new Point(1.0 * img.width, 0.0)
    ];
    List<Color> colors = [
      const Color.fromARGB(0xaa, 0x00, 0x00, 0xff),
      const Color.fromARGB(0xaa, 0x00, 0x00, 0xff),
      const Color.fromARGB(0xaa, 0x00, 0x00, 0xff),
      const Color.fromARGB(0xaa, 0x00, 0x00, 0xff)
    ];
    sky.TransferMode transferMode = sky.TransferMode.color;
    sky.TileMode tmx = sky.TileMode.clamp;
    sky.TileMode tmy = sky.TileMode.clamp;
    Float64List matrix4 = new Matrix4.identity().storage;
    sky.ImageShader imgShader = new sky.ImageShader(img, tmx, tmy, matrix4);
    paint.setShader(imgShader);
    List<int> indicies = [0, 1, 2, 3];
    context.canvas.drawVertices(vertexMode, vertices, textureCoordinates,
        colors, transferMode, indicies, paint);
  }
}

class ImageLoader {
  static Future<sky.Image> load(String url) async {
    UrlResponse response = await fetchUrl(url);
    if (response.statusCode >= 400) {
      throw "failed load ${url}";
    } else {
      Completer<sky.Image> completer = new Completer();
      new sky.ImageDecoder.consume(response.body.handle.h, completer.complete);
      return completer.future;
    }
  }
}
```