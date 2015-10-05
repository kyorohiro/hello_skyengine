import 'package:sky/widgets.dart';
import 'package:sky/rendering.dart';
//import 'package:sky/gestures.dart';
//import 'package:sky/services.dart';
import 'dart:sky' as sky;

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

  DrawRectObject() {
    this.size = new Size(1000.0, 1000.0);
  }
  @override
  void paint(PaintingContext context, Offset offset) {
    print("paint!-----");
    Paint p = new Paint();
    p.color = new Color.fromARGB(0xff, 0xff, 0xff, 0xff);
    Rect r = new Rect.fromLTWH(x - 50.0, y - 50.0, 100.0, 100.0);
    context.canvas.drawRect(r, p);
  }

  @override
  void handleEvent(sky.Event event, BoxHitTestEntry entry) {
    //print("event : ---${event} --- ${entry}");
    if (event != null) {
      //print("${entry.localPosition.toOffset().toPoint().x}");
    }
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
