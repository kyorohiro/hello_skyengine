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
    TinyStage stage = f.createStage(new GameRoot());
    stage.start();
    return (stage as TinyFlutterStage);
  }
}

class GameRoot extends TinyDisplayObject {
  double w = 800.0;
  double h = 600.0;
  double ratioW = 1.0;
  double ratioH = 1.0;
  double radio = 1.0;
  double l = 0.0;
  double t = 0.0;
  TinyColor bkcolor;
  Matrix4 mat = new Matrix4.identity();

  GameRoot({this.bkcolor}) {
    if (bkcolor == null) {
      bkcolor = new TinyColor.argb(0xff, 0xee, 0xee, 0xff);
    }
    child.add(new TinyButton(100.0, 100.0));
  }

  void onTick(TinyStage stage, int timeStamp) {
    ratioW = stage.w / w;
    ratioH = stage.h / h;
    radio = (ratioW < ratioH ? ratioW : ratioH);
    l = (stage.w - (w * radio)) / 2;
    mat = new Matrix4.identity();
    mat.scale(radio, radio, 1.0);
    mat.translate(l, t, 0.0);
  }

  void paint(TinyStage stage, TinyCanvas canvas) {
    canvas.pushMulMatrix(mat);
    super.paint(stage, canvas);
    canvas.popMatrix();
  }
  void onPaint(TinyStage stage, TinyCanvas canvas) {
//    TinyRect rect = new TinyRect(l, t, w * radio, h * radio);
    TinyRect rect = new TinyRect(0.0, 0.0, w, h);
    TinyPaint paint = new TinyPaint();
    paint.color = bkcolor;

    canvas.clipRect(stage, rect);
    canvas.drawRect(stage, rect, paint);
  }
}

class TinyButton extends TinyDisplayObject {
  double w;
  double h;
  TinyColor bgcolor = new TinyColor.argb(0xaa, 0xff, 0xaa, 0xcc);

  TinyButton(this.w, this.h) {
    ;
  }

  void onTouch(TinyStage stage, int id, String type, double x, double y) {
    ;
  }
  void onPaint(TinyStage stage, TinyCanvas canvas) {
    TinyPaint paint = new TinyPaint();
    paint.color = bgcolor;
    canvas.drawRect(stage, new TinyRect(0.0, 0.0, w, h), paint);
  }
}

class StartScreen extends TinyDisplayObject {}
