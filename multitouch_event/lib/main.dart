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

class TouchInfo {
  double x = 0.0;
  double y = 0.0;
  double pressure = 0.0;
  bool isTouch = false;
}

class DrawRectObject extends RenderBox {
  List<TouchInfo> touchInfos = [];
  @override
  void performLayout() {
    size = constraints.biggest;
    for (int i = 0; i < 100; i++) {
      touchInfos.add(new TouchInfo());
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    Paint p = new Paint();
    for (TouchInfo t in touchInfos) {
      if (t.isTouch) {
        p.color = new Color.fromARGB(0xff, 0xff, 0xff, 0xff);
        double size = 100*t.pressure;
        Rect r = new Rect.fromLTWH(t.x - size/2, t.y - size/2, size, size);
        context.canvas.drawRect(r, p);
      }
    }
  }

  @override
  void handleEvent(sky.Event event, BoxHitTestEntry entry) {
    if (event is sky.PointerEvent) {
      sky.PointerEvent e = event;
      switch (event.type) {
        case "pointerdown":
          touchInfos[e.pointer].x = entry.localPosition.x;
          touchInfos[e.pointer].y = entry.localPosition.y;
          touchInfos[e.pointer].pressure = e.pressure/e.pressureMax;
          touchInfos[e.pointer].isTouch = true;
          break;
        case "pointermove":
          touchInfos[e.pointer].x += e.dx;
          touchInfos[e.pointer].y += e.dy;
          touchInfos[e.pointer].pressure = e.pressure/e.pressureMax;
          break;
        case "pointerup":
          touchInfos[e.pointer].x += e.dx;
          touchInfos[e.pointer].y += e.dy;
          touchInfos[e.pointer].isTouch = false;
          break;
        case 'pointercancel':
          print("pointer cancel");
          break;
      }
      markNeedsPaint();
    }
  }
}
