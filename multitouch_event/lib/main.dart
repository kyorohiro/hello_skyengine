import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(new DrawRectWidget());
}

class DrawRectWidget extends OneChildRenderObjectWidget {
  RenderObject createRenderObject() {
    return new DrawRectObject();
  }

  @override
  void updateRenderObject(
      RenderObject renderObject, RenderObjectWidget oldWidget) {}
}

class TouchInfo {
  double x = 0.0;
  double y = 0.0;
  double pressure = 0.0;
  bool isTouch = false;
}

class DrawRectObject extends RenderBox {
  Map<int, TouchInfo> touchInfos = {};
  @override
  void performLayout() {
    size = constraints.biggest;
  }

  @override
  bool hitTest(HitTestResult result, {Point position}) {
    result.add(new BoxHitTestEntry(this, position));
    return true;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    Paint p = new Paint();
    for (TouchInfo t in touchInfos.values) {
      if (t.isTouch) {
        p.color = new Color.fromARGB(0xff, 0xff, 0xff, 0xff);
        double size = 100 * t.pressure;
        Rect r = new Rect.fromLTWH(t.x - size / 2, t.y - size / 2, size, size);
        context.canvas.drawRect(r, p);
      }
    }
  }

  @override
  void handleEvent(PointerEvent event, HitTestEntry entry) {
    if (!attached) {
      return;
    }
    if (entry is BoxHitTestEntry) {
      if(event is PointerDownEvent) {
          touchInfos[event.pointer] = new TouchInfo();
          touchInfos[event.pointer].x = entry.localPosition.x;
          touchInfos[event.pointer].y = entry.localPosition.y;
          touchInfos[event.pointer].pressure = event.pressure / event.pressureMax;
          touchInfos[event.pointer].isTouch = true;
      } else if(event is PointerMoveEvent) {
          touchInfos[event.pointer].x = event.position.x;
          touchInfos[event.pointer].y = event.position.y;
          touchInfos[event.pointer].pressure = event.pressure / event.pressureMax;
      } else if(event is PointerUpEvent) {
          touchInfos[event.pointer].x = event.position.x;
          touchInfos[event.pointer].y = event.position.y;
          touchInfos[event.pointer].isTouch = false;
      } else if(event is PointerCancelEvent) {
          print("pointer cancel");
      }
      markNeedsPaint();
    }
  }
}
