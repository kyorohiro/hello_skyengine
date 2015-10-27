import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'tinygame.dart';
import 'dart:math' as math;
import 'dart:async';
import 'package:flutter/services.dart';
import 'playscene.dart';
import 'game.dart';

class ProgramScree extends TinyDisplayObject {
  Game game;
  TinyImage img = null;

  ProgramScree(this.game) {
    game.f.loadImage("assets/bg_prog.png").then((TinyImage i) {
      img = i;
    });
    {
      TinyButton button = new TinyButton("back_button", 200.0, 120.0, onPush);
      button.mat = new Matrix4.translationValues(30.0, 480.0, 0.0);
      button.bgcolorOn = new TinyColor.argb(0x22, 0xFF, 0x00, 0x00);
      button.bgcolorOff =  new TinyColor.argb(0x00, 0x00, 0x00, 0xff);
      button.bgcolorFocus = new TinyColor.argb(0x11, 0x00, 0xff, 0x00);
      child.add(button);
    }
  }

  void onPaint(TinyStage stage, TinyCanvas canvas) {
    drawBG(stage, canvas);
    drawTips(stage, canvas);
  }

  void drawBG(TinyStage stage, TinyCanvas canvas) {
    if (img != null) {
      TinyRect src = new TinyRect(0.0, 0.0, img.w.toDouble(), img.h.toDouble());
      TinyRect dst = new TinyRect(0.0, 0.0, 800.0, 600.0);
      TinyPaint p = new TinyPaint();
      canvas.drawImageRect(stage, img, src, dst, p);
    }
  }

  void drawTips(TinyStage stage, TinyCanvas canvas) {
    for (int y = 0; y < game.program.h; y++) {
      for (int x = 0; x < game.program.w; x++) {
        drawTip(stage, canvas, x, y);
      }
    }
  }

  void drawTip(TinyStage stage, TinyCanvas canvas, int x, int y) {
    TinyPaint p = new TinyPaint();
    p.strokeWidth = 2.5;
    p.style = TinyPaintStyle.stroke;
    double xx = 50.0+x*(50+20);
    double yy = 5.0+y*(50+20);
    double ww = 50.0;
    double hh = 50.0;
    TinyRect rect = new TinyRect(xx, yy, ww, hh);
    p.color = new TinyColor(game.program.getTip(x, y).id);
    canvas.drawRect(stage, rect, p);

    //
    // allow
    TinyPoint p1 = new TinyPoint(0.0, 0.0);
    TinyPoint p2 = new TinyPoint(0.0, hh/2+20.0);
    TinyPoint p3 = new TinyPoint(-ww*1/3, hh/2+(20.0*2/3));
    TinyPoint p4 = new TinyPoint(ww*1/3, hh/2+(20.0*2/3));
    Matrix4 mat = new Matrix4.identity();

    mat.translate(xx+ww/2,yy+hh/2,0.0);
    mat.rotateZ(math.PI/5);
    canvas.pushMulMatrix(mat);
    canvas.drawLine(stage, p1, p2, p);
    canvas.drawLine(stage, p2, p3, p);
    canvas.drawLine(stage, p3, p4, p);
    canvas.popMatrix();
  }


  void onPush(String id) {
    game.stage.root.clearChild();
    game.stage.root.addChild(game.playScene);
  }
}
