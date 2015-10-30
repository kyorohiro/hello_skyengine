import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import '../tinygame.dart';
import 'dart:math' as math;
import '../glogic/game.dart';
import '../glogic/tip.dart';

class TipSelect extends TinyDisplayObject {
  int tipX = 0;
  int tipY = 0;
  TinyDisplayObject parent;

  TipSelect(this.parent, this.tipX, this.tipY) {
    TinyButton button1 = new TinyButton("click", 600.0, 100.0, (String id){});
    TinyButton button2 = new TinyButton("click", 600.0, 100.0, (String id){});
    button1.mat.translate(100.0,0.0,0.0);
    button2.mat.translate(100.0,120.0,0.0);
    child.add(button1);
    child.add(button2);
  }

  void onPaint(TinyStage stage, TinyCanvas canvas) {
    TinyPaint p = new TinyPaint();
    p.color = new TinyColor.argb(0x66, 0x00, 0x00, 0xff);
    TinyRect rect = new TinyRect(100.0, 0.0, 600.0, 600.0);
    canvas.drawRect(stage, rect, p);
  }

  void onTouch(TinyStage stage, int id, String type, double x, double y, double globalX, globalY) {
    if(x<100.0 || 700<x) {
      parent.rmChild(this);
    }
  }
}
