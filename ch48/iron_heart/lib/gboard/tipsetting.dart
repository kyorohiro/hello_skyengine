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
  GameTipShoot _shootTip;
  GameTipShoot get shootTip => _shootTip;
  TinyCircleDirection cd;
  void set shootTip(GameTipShoot v) {
    if(v != null) {
    _shootTip = v;
    cd.distance = v.distance;
    cd.angle = v.angle;
    cd.range = v.range;
  }
  }

  ShootTipSetting(this._shootTip, this.builder, this.parent, this.tipX, this.tipY, this.callback)
      : super(600.0, 600.0, 600.0, 840.0) {

    this.mat.translate(100.0, 0.0, 0.0);
    cd = new TinyCircleDirection("shoot",400.0, 100.0, 100.0, onTinyCircleDirectionCallback);
    this.child.add(cd);

    TinySeekbar sb = new TinySeekbar(400.0, 100.0);
    sb.mat.translate(0.0, 450.0, 0.0);
    this.child.add(sb);

    shootTip = _shootTip;
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
    return true;
  }

  void onTinyCircleDirectionCallback (
    String id,
    double angle,
    double range,
    double distance) {
      if(shootTip == null) {
        return;
      }
      shootTip.angle = angle;
      shootTip.range = range;
      shootTip.distance = distance;
    }
}
