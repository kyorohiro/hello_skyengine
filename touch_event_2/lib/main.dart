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
  @override
  void performLayout() {
    size = constraints.biggest;
  }

  @override
  void handleEvent(InputEvent event, HitTestEntry entry) {
    if (event is PointerInputEvent && entry is BoxHitTestEntry) {
      PointerInputEvent e = event;
      if (event.type == "pointerup") {
        // 2015/10/18 return null
        if (e.dx == null || e.dy == null) {
          print("### ${e.dx} ${e.dy}");
        }
      }
    }
  }
}
