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
  GameRoot({this.bkcolor}) {
    if(bkcolor == null) {
      bkcolor = new TinyColor.argb(0xff, 0xee, 0xee, 0xff);
    }
  }

  void onTick(TinyStage stage, int timeStamp) {
    ratioW = stage.w / w;
    ratioH = stage.h / h;
    radio = (ratioW < ratioH ? ratioW: ratioH);
    Matrix4 mat = new Matrix4.identity();
    mat.scale(radio, radio, 1.0);
    l = (stage.w-(w*radio))/2;
  }

  void onPaint(TinyStage stage, TinyCanvas canvas) {
    TinyRect rect = new TinyRect(l, t, w*radio, h*radio);
    TinyPaint paint = new TinyPaint();
    paint.color = bkcolor;
    int tmp = stage.coordinate;
    stage.coordinate = TinyStage.kScreenCoordinates;
    canvas.clipRect(stage, rect);
    canvas.drawRect(stage, rect, paint);
    stage.coordinate = tmp;
  }
}

class StartScreen extends TinyDisplayObject {
  
}
