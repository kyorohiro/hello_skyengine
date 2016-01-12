# Touch Event

https://github.com/kyorohiro/hello_skyengine/tree/master/touch_event

![](screen.png)

```
//
// following code is checked in 2016/01/13
//  from  2015/11/07 need override
//    need bool hitTest(HitTestResult result, {Point position})
//
import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';


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
  bool hitTest(HitTestResult result, {Point position}) {
    result.add(new BoxHitTestEntry(this, position));
    return true;
  }

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
  void handleEvent(PointerEvent event, HitTestEntry entry) {
    if (entry is BoxHitTestEntry) {
      if (event is PointerDownEvent) {
        x = entry.localPosition.x;
        y = entry.localPosition.y;
      } else {
        x = event.position.x;
        y = event.position.y;
      }
      markNeedsPaint();
    }
  }
}

```
