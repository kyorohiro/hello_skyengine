import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'tinygame.dart';
import 'dart:math' as math;
import 'dart:async';
import 'package:flutter/services.dart';

TinyGameBuilderForFlutter f = new TinyGameBuilderForFlutter();

void main() {
  runApp(new GameWidget());
}

class GameWidget extends OneChildRenderObjectWidget {
  RenderObject createRenderObject() {
    TinyStage stage = f.createStage(new TinyGameRoot(800.0, 600.0));
    stage.start();
    stage.root.child.add(new StartScreen());
    return (stage as TinyFlutterStage);
  }
}

class StartScreen extends TinyDisplayObject {
  TinyImage img = null;
  StartScreen() {
    child.add(new TinyButton("start_button", 600.0, 200.0, onPush)..mat=new Matrix4.translationValues(100.0,300.0,0.0));
    f.loadImage("assets/bg_start.png").then((TinyImage i){img=i;}) ;
  }
  void onPaint(TinyStage stage, TinyCanvas canvas) {
    TinyRect src = new TinyRect(0.0, 0.0, img.w.toDouble(), img.h.toDouble());
    TinyRect dst = new TinyRect(0.0, 0.0, 800.0, 600.0);
    TinyPaint p = new TinyPaint();
    if(img != null) {
      canvas.drawImageRect(stage, img, src, dst, p);
    }
  }
  void onPush(String id) {
    print("### ${id}");
  }
}

class GameScree extends TinyDisplayObject {
  GameScree() {
    ;
  }
}
