import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import '../tinygame.dart';
import 'dart:math' as math;
import '../glogic/game.dart';
import '../glogic/tip.dart';
import 'programscene.dart';

class TipDO extends TinyButton {
  TinyImage img = null;
  TipDO(TinyGameBuilder b, String buttonName, String resPath, TinyButtonCallback onTouchCallback)
  : super(buttonName,100.0,100.0, onTouchCallback){
    bgcolorOff = new TinyColor.argb(0xff, 0xaa, 0xaa, 0xaa);
    b.loadImage(resPath).then((TinyImage i) {
      img = i;
    });
  }

  void onPaint(TinyStage stage, TinyCanvas canvas) {
    super.onPaint(stage, canvas);
    TinyPaint p = new TinyPaint();
    p.color = new TinyColor.argb(0x66, 0xaa, 0xaa, 0xaa);
    TinyRect rect = new TinyRect(100.0, 0.0, 600.0, 600.0);
    canvas.drawRect(stage, rect, p);

    TinyRect src = new TinyRect(0.0, 0.0, img.w.toDouble(), img.h.toDouble());
    TinyRect dst = new TinyRect(0.0, 0.0, img.w.toDouble(), img.h.toDouble());
    canvas.drawImageRect(stage, img, src, dst, p);
  }
}

class TipSelect extends TinyScrollView  {
  int tipX = 0;
  int tipY = 0;
  ProgramScree parent;

  TipSelect(this.parent, this.tipX, this.tipY) : super(600.0, 600.0, 600.0, 720.0){
    TinyButton button1 = new TipDO(parent.game.f, "click","assets/act_front.png",(String id){parent.rmChild(this);});
    TinyButton button2 = new TipDO(parent.game.f, "click","assets/act_right.png",(String id){parent.rmChild(this);});
    TinyButton button3 = new TipDO(parent.game.f, "click","assets/act_left.png",(String id){parent.rmChild(this);});
    TinyButton button4 = new TipDO(parent.game.f, "click","assets/act_back.png",(String id){parent.rmChild(this);});
    TinyButton button5 = new TipDO(parent.game.f, "click","assets/act_rotate_right.png",(String id){parent.rmChild(this);});
    TinyButton button6 = new TipDO(parent.game.f, "click","assets/act_rotate_left.png",(String id){parent.rmChild(this);});
    this.mat.translate(100.0,0.0,0.0);
    button1.mat.translate(0.0,0.0,0.0);
    button2.mat.translate(0.0,120.0,0.0);
    button3.mat.translate(0.0,240.0,0.0);
    button4.mat.translate(0.0,360.0,0.0);
    button5.mat.translate(0.0,480.0,0.0);
    button6.mat.translate(0.0,600.0,0.0);
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

  bool onTouch(TinyStage stage, int id, String type, double x, double y, double globalX, globalY) {
    if( type == "pointerup" &&(x<0.0 || 600<x )){
      parent.rmChild(this);
    }
    //if(x<100&&x<700) {
      return true;
    //} else {
    //  return false;
    //}
  }
}
