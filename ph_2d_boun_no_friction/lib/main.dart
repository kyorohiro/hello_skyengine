import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'tinyphysics2d.dart';
import 'tinygame.dart';
import 'dart:math' as math;
import 'dart:async';
//
import 'package:flutter/services.dart';
import 'package:mojo_services/sensors/sensors.mojom.dart';

TinyGameBuilderForFlutter f = new TinyGameBuilderForFlutter();

double worldDx = 0.0;
double worldDy = 0.0;
double worldDz = 0.0;

void intiSensor() {
  print("######====================####s##");
  SensorServiceProxy sensor = new SensorServiceProxy.unbound();
  shell.connectToService("h", sensor);

  SensorListenerStub stub = new SensorListenerStub.unbound();
  stub.impl = new MySensorListener();
  sensor.ptr.addListener(SensorType.GRAVITY, stub);
  print("######====================###s###");
}

class MySensorListener extends SensorListener {
  void onAccuracyChanged(int accuracy) {
    //print("accuracy: ${accuracy}");
  }

  void onSensorChanged(SensorData data) {
    //  print("data: ${data.accuracy} ${data.values}");
    worldDx = data.values[0];
    worldDy = data.values[1];
    worldDz = data.values[2];
  }
}

void main() {
  runApp(new GameWidget());
  intiSensor();
}

class GameWidget extends OneChildRenderObjectWidget {
  RenderObject createRenderObject() {
    TinyStage stage = f.createStage(new PlanetWorld());
    stage.start();
    return (stage as TinyFlutterStage);
  }
}

class PlanetWorld extends TinyDisplayObject {
  math.Random rand = new math.Random();
  World w = new World();
  PlanetWorld() {
    // ball
    for (int i = 0; i < 40; i++) {
      double size = rand.nextDouble() * 12.0 + 5.0;
      w.primitives.add(new CirclePrimitive()
        ..move(0.0, 250.0)
        ..dxy.y = (0.5 - rand.nextDouble()) * 5.0
        ..dxy.x = (0.5 - rand.nextDouble()) * 5.0
        ..radius = size
        ..mass = size / 10.0);
    }
    w.primitives.add(new CirclePrimitive()
      ..move(-50.0, 200.0)
      ..dxy.y = 5.0
      ..dxy.x = -10.0
      ..mass = 50.0
      ..radius = 50.0);

    // frame
    for (int i = 0; i < 20; i++) {
      w.primitives.add(new CirclePrimitive()
        ..move(-200.0 + i * 20, 0.0)
        ..radius = 9.0
        ..mass = 50.0
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
    w.gravity.x = -1.0 * worldDx / 50.0;
    w.gravity.y = -1.0 * worldDy / 50.0;
    for (int i = 0; i < 20; i++) {
      w.next(0.05);
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
        {
          TinyPoint p1 = f.createPoint(c.xy.x, c.xy.y);
          TinyPoint p2 = f.createPoint(
              c.xy.x + c.radius * math.cos(math.PI * c.angle),
              c.xy.y + c.radius * math.sin(math.PI * c.angle));
          canvas.drawLine(stage, p1, p2, pa);
        }
      }
    }
  }
}
