import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'dart:math';
import 'dart:async';

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
    //
    // 2016/1/13 add following code
    //  Scheduller == null situation
    if(Scheduler.instance == null) {
      new Future.delayed(new Duration(seconds: 1)).then((_){
        anime();
      });
      return;
    }

    //
    Scheduler.instance.scheduleFrameCallback((Duration timeStamp) {
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

  @override
  void performLayout() {
    size = constraints.biggest;
  }

  void paint(PaintingContext context, Offset offset) {
    Paint p = new Paint();
    p.color = new Color.fromARGB(0xff, 0xff, 0xff, 0xff);
    Rect r = new Rect.fromLTWH(x, y, 25.0, 25.0);
    context.canvas.drawRect(r, p);
  }
}
