library spacewar;

import 'package:sky/widgets.dart';
import 'package:sky/rendering.dart';
import 'package:sky/animation.dart';
import 'dart:math' as math;
import 'dart:sky' as sky;
part 'sun.dart';
part 'spaceship.dart';

class DisplayObject {
  double x = 0.0;
  double y = 0.0;
  String objectName = "none";
  List<DisplayObject> child = [];
  DisplayObject({this.child: null}) {
    if (child == null) {
      child = [];
    }
  }

  DisplayObject fincObjectFromObjectName(String objectName) {
    if(this.objectName == objectName) {
      return this;
    }
    for(DisplayObject d in child) {
      DisplayObject t = d.fincObjectFromObjectName(objectName);
      if(t != null) {
        return t;
      }
    }
    return null;
  }

  void onTick(Stage stage, double timeStamp) {

  }

  void tick(Stage stage, double timeStamp) {
    onTick(stage, timeStamp);
    for (DisplayObject d in child) {
      d.onTick(stage, timeStamp);
    }
  }

  void onPaint(Stage stage, PaintingCanvas canvas) {
    ;
  }

  void paint(Stage stage, PaintingCanvas canvas) {
    onPaint(stage, canvas);
    for (DisplayObject d in child) {
      d.paint(stage, canvas);
    }
  }
}

class Stage extends RenderBox {
  double get x => paintBounds.left;
  double get y => paintBounds.top;
  double get w => paintBounds.width;
  double get h => paintBounds.height;
  bool animeIsStart = false;
  int animeId = 0;
  DisplayObject _root;
  DisplayObject get root => _root;
  Stage(this._root) {}

  void start() {
    if (animeIsStart == true) {
      return;
    }
    animeIsStart = true;
    innerTick(double timeStamp) {
      if (animeIsStart == true) {
        animeId = scheduler.requestAnimationFrame(innerTick);
        if(_root != null){
          _root.tick(this, timeStamp);
        }
      }
      this.markNeedsPaint();
    }
    animeId = scheduler.requestAnimationFrame(innerTick);
  }

  void stop() {
    if (animeIsStart == true) {
      scheduler.cancelAnimationFrame(animeId);
    }
    animeIsStart = false;
  }

  @override
  void performLayout() {
    size = constraints.biggest;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    root.paint(this, context.canvas);
  }

  @override
  void handleEvent(sky.Event event, BoxHitTestEntry entry) {}
}
