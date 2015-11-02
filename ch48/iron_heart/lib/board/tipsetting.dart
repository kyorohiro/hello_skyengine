import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import '../tinygame.dart';
import 'dart:math' as math;
import '../glogic/game.dart';
import '../glogic/tip.dart';
import 'programscene.dart';

typedef void ShootTipSettingCallback(String id);

class ShootTipSetting extends TinyScrollView {
  int tipX = 0;
  int tipY = 0;

  //ProgramScree parent;
  TinyDisplayObject parent;
  TinyGameBuilder builder;
  ShootTipSettingCallback callback;

  ShootTipSetting(this.builder, this.parent, this.tipX, this.tipY, this.callback)
      : super(600.0, 600.0, 600.0, 840.0) {

    this.mat.translate(100.0, 0.0, 0.0);
    TinyCircleDirection cd = new TinyCircleDirection(400.0, 100.0);
    this.child.add(cd);
  }

  void onPaint(TinyStage stage, TinyCanvas canvas) {
    TinyPaint p = new TinyPaint();
    p.color = new TinyColor.argb(0x66, 0xaa, 0xaa, 0xaa);
    TinyRect rect = new TinyRect(0.0, 0.0, 600.0, 600.0);
    canvas.drawRect(stage, rect, p);
  }

  bool onTouch(TinyStage stage, int id, String type, double x, double y,
      double globalX, globalY) {
    if (type == "pointerup" && (x < 0.0 || 600 < x)) {
      parent.rmChild(this);
    }
    //print("------------touch ####+++++++++");
    return false;
  }
}
