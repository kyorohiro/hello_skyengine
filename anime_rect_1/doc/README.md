# Draw Rect Anime (use animation.dart)

https://github.com/kyorohiro/hello_skyengine/blob/master/anime_rect_1

![](screen.png)

```
// following code is checked in 2015/11/07
import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/animation.dart';
import 'dart:math';

void main() {
  runApp(new DrawRectWidget()..anime());
}

class DrawRectWidget extends OneChildRenderObjectWidget {
  double angle = 0.0;
  DrawRectObject o = new DrawRectObject();
  RenderObject createRenderObject() {
    return o;
  }

  int prevTimeStamp = 0;
  void anime() {
    scheduler.requestAnimationFrame((Duration timeStamp) {
      print("${timeStamp.inMilliseconds-prevTimeStamp}");
      prevTimeStamp = timeStamp.inMilliseconds;
      o.x = 100 * cos(PI * angle / 180.0) + 100.0;
      o.y = 100 * sin(PI * angle / 180.0) + 100.0;
      angle++;
      o.markNeedsPaint();
      anime();
    });
  }
}

class DrawRectObject extends RenderBox {
  double x = 50.0;
  double y = 50.0;
  void paint(PaintingContext context, Offset offset) {
    Paint p = new Paint();
    p.color = new Color.fromARGB(0xff, 0xff, 0xff, 0xff);
    Rect r = new Rect.fromLTWH(x, y, 25.0, 25.0);
    context.canvas.drawRect(r, p);
  }
}
```
