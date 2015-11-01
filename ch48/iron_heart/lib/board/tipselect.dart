import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import '../tinygame.dart';
import 'dart:math' as math;
import '../glogic/game.dart';
import '../glogic/tip.dart';
import 'programscene.dart';

typedef void TipSelectCallback(String id);

class TipSelect extends TinyScrollView {
  int tipX = 0;
  int tipY = 0;
  static const String actFront = "assets/act_front.png";
  static const String actRight = "assets/act_right.png";
  static const String actLeft = "assets/act_left.png";
  static const String actBack = "assets/act_back.png";
  static const String actRotateRight ="assets/act_rotate_right.png";
  static const String actRotateLeft ="assets/act_rotate_left.png";
  //ProgramScree parent;
  TinyDisplayObject parent;
  TinyGameBuilder builder;
  TipSelectCallback callback;

  TipSelect(this.builder, this.parent, this.tipX, this.tipY, this.callback)
      : super(600.0, 600.0, 600.0, 720.0) {
    TinyImageButton button1 = new TinyImageButton(builder, actFront, actFront, 100.0,100.0,selectTip);
    TinyImageButton button2 = new TinyImageButton(builder, actRight, actRight,  100.0,100.0,selectTip);
    TinyImageButton button3 = new TinyImageButton(builder, actLeft, actLeft,  100.0,100.0,selectTip);
    TinyImageButton button4 = new TinyImageButton(builder, actBack, actBack,  100.0,100.0,selectTip);
    TinyImageButton button5 = new TinyImageButton(builder, actRotateRight, actRotateRight,  100.0,100.0,selectTip);
    TinyImageButton button6 = new TinyImageButton(builder, actRotateLeft, actRotateLeft,  100.0,100.0,selectTip);

    this.mat.translate(100.0, 0.0, 0.0);
    button1.mat.translate(0.0, 0.0, 0.0);
    button2.mat.translate(0.0, 120.0, 0.0);
    button3.mat.translate(0.0, 240.0, 0.0);
    button4.mat.translate(0.0, 360.0, 0.0);
    button5.mat.translate(0.0, 480.0, 0.0);
    button6.mat.translate(0.0, 600.0, 0.0);
    child.add(button1);
    child.add(button2);
    child.add(button3);
    child.add(button4);
    child.add(button5);
    child.add(button6);
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

  void selectTip(String id) {
    print("## selectTip ########## ${id}");
    callback(id);
    parent.rmChild(this);
  }
}
