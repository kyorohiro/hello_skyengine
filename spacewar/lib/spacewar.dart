library spacewar;

import 'package:sky/widgets.dart';
import 'package:sky/rendering.dart';
import 'package:sky/animation.dart';
import 'dart:math' as math;
import 'dart:sky' as sky;
part 'sun.dart';

class DisplayObject {
  List<DisplayObject> child = [];
  DisplayObject({this.child:null}){
    if(child == null) {
      child = [];
    }
  }
  void onTick(Stage stage, double timeStamp){

  }
  void tick(Stage stage, double timeStamp) {
    onTick(stage, timeStamp);
    for(DisplayObject d in child) {
      d.onTick(stage, timeStamp);
    }
  }

  void onPaint(Stage stage, PaintingCanvas canvas){;}
  void paint(Stage stage, PaintingCanvas canvas) {
    onPaint(stage, canvas);
    for(DisplayObject d in child) {
      d.paint(stage, canvas);
    }
  }
}

class Stage extends RenderBox {
  double get x => paintBounds.left;
  double get y => paintBounds.top;
  double get w => paintBounds.width;
  double get h => paintBounds.height;
  int animationId = null;
  DisplayObject root;
  Stage(this.root){}

  void start() {
    if(animationId != null) {
      throw "already run";
    }
    animationId = scheduler.requestAnimationFrame((double timeStamp){
    });

  }

  void stop() {
    scheduler.cancelAnimationFrame(animationId);
    animationId = null;
  }

  @override
  void performLayout() {
    size = constraints.biggest;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    //print("paint");
    root.paint(this, context.canvas);
    /*
    Paint p = new Paint();
    p.color = new Color.fromARGB(0xff, 0xff, 0xff, 0xff);
    Rect r = new Rect.fromLTWH(x - 50.0, y - 50.0, 100.0, 100.0);
    context.canvas.drawRect(r, p);
    */
  }

  @override
  void handleEvent(sky.Event event, BoxHitTestEntry entry) {
  }
}
