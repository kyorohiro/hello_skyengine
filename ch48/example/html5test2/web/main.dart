import 'dart:html';
import 'dart:web_gl';
import 'dart:math' as math;
import 'package:ch48/tinygame.dart';
import 'package:ch48/tinygame_webgl.dart';
import 'package:vector_math/vector_math_64.dart';

void main() {
  print("--------1-dart hello ( 1 )");
  // TinyGameBuilderForWebgl gl = new TinyGameBuilderForWebgl();
  // TinyStage stage = gl.createStage(new TinyGameRoot(400.0, 400.0));
  // stage.start();
  TinyGameBuilderForWebgl builder = new TinyGameBuilderForWebgl();
  TinyGameRoot root = new TinyGameRoot(400.0, 300.0);
  TinyStage stage = builder.createStage(root);
  stage.start();
  
  root.addChild(new PlayScreen());
  print("--------1-dart hello ( 2 ) ");
}

class PlayScreen extends TinyDisplayObject {
  double x = 0.0;
  double y = 0.0;
  bool isTouch = false;
  PlayScreen() {
    this.mat.rotateZ(math.PI/10);
  }
  void onPaint(TinyStage stage, TinyCanvas canvas) {
    TinyPaint p = new TinyPaint();
    if(isTouch) {
      p.color = new TinyColor.argb(0xaa, 0x00, 0x00, 0xff);
    } else {
      p.color = new TinyColor.argb(0xaa, 0xff, 0xaa, 0xaa);      
    }
    canvas.drawRect(stage, new TinyRect(50.0,50.0, 300.0, 200.0), p);
    p.color = new TinyColor.argb(0xff, 0xff, 0x00, 0x00);
    canvas.drawOval(stage, new TinyRect(this.x-15.0,this.y-15.0, 30.0, 30.0), p);
  }

  bool onTouch(TinyStage stage, int id, String type, double x, double y,
      double globalX, globalY) {
    this.x = x;
    this.y = y;
    isTouch = false;
    if(50.0 < this.x && this.x < 350.0) {
      if(50.0 < this.y && this.y < 250.0) {
        isTouch = true;
      }
    }
    return false;
  }
}
