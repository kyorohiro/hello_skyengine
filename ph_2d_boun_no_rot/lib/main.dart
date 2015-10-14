import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'tinyphysics2d.dart';
import 'tinygame.dart';
import 'dart:math' as math;

TinyGameBuilderForFlutter f = new TinyGameBuilderForFlutter();

void main() {
  runApp(new GameWidget());
}

class GameWidget extends OneChildRenderObjectWidget {
  RenderObject createRenderObject() {
    TinyStage stage = f.createStage(new PlanetWorld());
    stage.start();
    return (stage as TinyFlutterStage);
  }
}

class PlanetWorld extends TinyDisplayObject {
  World w = new World();
  PlanetWorld() {
    w.primitives.add(new CirclePrimitive()
      ..move(-100.0, 300.0)
      ..dxy.y = -1.0
      ..dxy.x = -5.0
      ..radius = 10.0);
    w.primitives.add(new CirclePrimitive()
      ..move(0.0, 300.0)
      ..dxy.y = -1.0
      ..dxy.x = -10.0
      ..radius = 15.0);
    w.primitives.add(new CirclePrimitive()
      ..move(-50.0, 300.0)
      ..dxy.y = -1.0
      ..dxy.x = -10.0
      ..radius = 15.0);
    for (int i = 0; i < 20; i++) {
      w.primitives.add(new CirclePrimitive()
        ..move(-200.0 + i * 20, 0.0)
        ..radius = 9.0
        ..isFixing = true);
    }
    for (int i = 0; i < 20; i++) {
      w.primitives.add(new CirclePrimitive()
        ..move(-200.0, 0.0 + i * 20)
        ..radius = 9.0
        ..isFixing = true);
    }
    for (int i = 0; i < 20; i++) {
      w.primitives.add(new CirclePrimitive()
        ..move(180.0, 0.0 + i * 20)
        ..radius = 9.0
        ..isFixing = true);
    }
    for (int i = 0; i < 20; i++) {
      w.primitives.add(new CirclePrimitive()
        ..move(-200.0 + i * 20, 400.0)
        ..radius = 9.0
        ..isFixing = true);
    }
  }
  void onTick(TinyStage stage, int timeStamp) {
    for (int i = 0; i < 10; i++) {
      w.next(0.1);
    }
    stage.markNeedsPaint();
  }

  void onPaint(TinyStage stage, TinyCanvas canvas) {
    TinyPaint pa = f.createPaint();
    pa.color = f.createColor(0xaa, 0xff, 0xff, 0xaa);
    for (Primitive p in w.primitives) {
      if (p is CirclePrimitive) {
        CirclePrimitive c = p;
        {
          double rd = 5.0;
          TinyRect r = f.createRect(c.xy.x - rd, c.xy.y + rd, rd * 2, rd * 2);
          canvas.drawOval(stage, r, pa);
        }
        {
          double rd = c.radius;
          TinyRect r = f.createRect(c.xy.x - rd, c.xy.y + rd, rd * 2, rd * 2);
          canvas.drawOval(stage, r, pa);
        }
      }
    }
  }
}
