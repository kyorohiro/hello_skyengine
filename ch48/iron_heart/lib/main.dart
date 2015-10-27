import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'tinygame.dart';
import 'dart:math' as math;
import 'dart:async';
import 'package:flutter/services.dart';

TinyGameBuilderForFlutter f = new TinyGameBuilderForFlutter();
TinyStage stage = null;
GameScree playScene = new GameScree();
StartScreen startScene = new StartScreen();
void main() {
  runApp(new GameWidget());
}

class GameWidget extends OneChildRenderObjectWidget {
  RenderObject createRenderObject() {
    stage = f.createStage(new TinyGameRoot(800.0, 600.0));
    stage.start();
    stage.root.child.add(startScene);
    return (stage as TinyFlutterStage);
  }
}

class StartScreen extends TinyDisplayObject {
  TinyImage img = null;
  StartScreen() {
    TinyButton button = new TinyButton("start_button", 600.0, 200.0, onPush);
    button.mat = new Matrix4.translationValues(100.0,300.0,0.0);
    button.bgcolorOn = new TinyColor.argb(0x22, 0xFF, 0x00, 0x00);
    button.bgcolorOff = new TinyColor.argb(0x00, 0x00, 0x00, 0xff);
    button.bgcolorFocus = new TinyColor.argb(0x11, 0x00, 0xff, 0x00);
    child.add(button);
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
    stage.root.clearChild();
    stage.root.addChild(playScene);
  }
}

class GameScree extends TinyDisplayObject {
  TinyImage img = null;
  GameScree() {
    f.loadImage("assets/bg_play.png").then((TinyImage i){img=i;}) ;
    {
    TinyButton button = new TinyButton("back_button", 200.0, 120.0, onPush);
    button.mat = new Matrix4.translationValues(30.0,480.0,0.0);
    button.bgcolorOn = new TinyColor.argb(0x22, 0xFF, 0x00, 0x00);
    button.bgcolorOff = new TinyColor.argb(0x55, 0x00, 0x00, 0xff);
    button.bgcolorFocus = new TinyColor.argb(0x11, 0x00, 0xff, 0x00);
    child.add(button);
  }
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
    stage.root.clearChild();
    stage.root.addChild(startScene);
  }
}
