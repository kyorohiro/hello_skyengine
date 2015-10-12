# Draw Vertexs demo, 3d cube animation

https://github.com/kyorohiro/hello_skyengine/tree/master/draw_vertices_demo

![](screen.png)

```
import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/animation.dart';

import 'dart:ui' as sky;
import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/src/services/fetch.dart';
import 'package:vector_math/vector_math_64.dart';
import 'dart:math' as math;

sky.Image img = null;
main() async {
  img = await ImageLoader.load("icon.jpeg");
  runApp(new DrawVertexsWidget());
}

class DrawVertexsWidget extends OneChildRenderObjectWidget {
  RenderObject createRenderObject() {
    return new DrawVertexsObject()..anime();
  }
}

class DrawVertexsObject extends RenderBox {
  double angle = 0.0;
  void anime() {
    scheduler.requestAnimationFrame((Duration timeStamp) {
      angle += math.PI / 90.0;
      this.markNeedsPaint();
      anime();
    });
  }

  void paint(PaintingContext context, Offset offset) {
    context.canvas.scale(4.0, 4.0);
    context.canvas.translate(80.0, 80.0);
    Matrix4 mat = new Matrix4.identity();
    mat.rotateY(math.PI / 2.0 + angle);
    mat.rotateX(angle);
    drawSurface(context, offset, mat);
    mat.rotateY(math.PI / 2.0);
    drawSurface(context, offset, mat);
    mat.rotateY(math.PI / 2.0);
    drawSurface(context, offset, mat);
    mat.rotateY(math.PI / 2.0);
    drawSurface(context, offset, mat);
    mat.rotateX(math.PI / 2.0);
    drawSurface(context, offset, mat);
    mat.rotateX(math.PI / 1.0);
    drawSurface(context, offset, mat);
  }

  void drawSurface(PaintingContext context, Offset offset, Matrix4 mat) {
    Paint paint = new Paint();
    sky.VertexMode vertexMode = sky.VertexMode.triangleFan;
    Vector3 vec1 = mat * new Vector3(-25.0, -25.0, -25.0);
    Vector3 vec2 = mat * new Vector3(-25.0, 25.0, -25.0);
    Vector3 vec3 = mat * new Vector3(25.0, 25.0, -25.0);
    Vector3 vec4 = mat * new Vector3(25.0, -25.0, -25.0);
    Vector3 normal = (vec1 - vec2).cross(vec1 - vec3);
    if (normal.z < 0) {
      return;
    }
    List<Point> vertices = [
      new Point(vec1.x, vec1.y),
      new Point(vec2.x, vec2.y),
      new Point(vec3.x, vec3.y),
      new Point(vec4.x, vec4.y)
    ];
    List<Point> textureCoordinates = [
      new Point(0.0, 0.0),
      new Point(0.0, 1.0 * img.height),
      new Point(1.0 * img.width, 1.0 * img.height),
      new Point(1.0 * img.width, 0.0)
    ];
    List<Color> colors = [
      const Color.fromARGB(0xaa, 0xff, 0xff, 0xff),
      const Color.fromARGB(0xaa, 0xff, 0xff, 0xff),
      const Color.fromARGB(0xaa, 0xff, 0xff, 0xff),
      const Color.fromARGB(0xaa, 0xff, 0xff, 0xff)
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
    if (response.body == null) {
      throw "failed load ${url}";
    }
    Completer<sky.Image> completer = new Completer();
    new sky.ImageDecoder.consume(response.body.handle.h, completer.complete);
    return completer.future;
  }
}
```