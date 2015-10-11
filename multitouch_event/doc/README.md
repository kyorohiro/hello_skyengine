# MultiTouch Event

https://github.com/kyorohiro/hello_skyengine/tree/master/multitouch_event

![](screen.png)

```
import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as sky;

void main() {
  runApp(new DrawRectWidget());
}

class DrawRectWidget extends OneChildRenderObjectWidget {
  RenderObject createRenderObject() {
    return new DrawRectObject();
  }
}

class DrawRectObject extends RenderBox {
  double x = 100.0;
  double y = 100.0;

  @override
  void performLayout() {
    size = constraints.biggest;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    Paint p = new Paint();
    p.color = new Color.fromARGB(0xff, 0xff, 0xff, 0xff);
    Rect r = new Rect.fromLTWH(x - 50.0, y - 50.0, 100.0, 100.0);
    context.canvas.drawRect(r, p);
  }

  @override
  void handleEvent(sky.Event event, BoxHitTestEntry entry) {
    if (event is sky.PointerEvent) {
      sky.PointerEvent e = event;
      if (event.type == "pointerdown") {
        x = entry.localPosition.x;
        y = entry.localPosition.y;
      } else {
        x += e.dx;
        y += e.dy;
      }
      markNeedsPaint();
    }
  }
}

```