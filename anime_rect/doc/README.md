# Draw Rect Anime

https://github.com/kyorohiro/hello_skyengine/tree/master/anime_rect

![](screen.png)

```
import 'package:sky/widgets.dart';
import 'package:sky/rendering.dart';
import 'dart:async';
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

  Future anime() async {
    while (true) {
      await new Future.delayed(new Duration(milliseconds: 20));
      o.x = 100 * cos(PI * angle / 180.0) + 100.0;
      o.y = 100 * sin(PI * angle / 180.0) + 100.0;
      angle++;
      o.markNeedsPaint();
    }
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