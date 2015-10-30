import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'tinygame.dart';
import 'dart:math' as math;
import 'glogic/game.dart';
import 'glogic/tip.dart';

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

  int selectTipX = 0;
  int selectTipY = 0;
  void onTouch(TinyStage stage, int id, String type, double x, double y) {
    print("###### x=${x}   y=${y}");
    double x1 =x - 50.0;
    double y1 =y - 5.0;
    double xx = x1/(50+20);
    double yy = y1/(50+20);
    print("###### x:y=${xx}:${yy}   x=${x}   y=${y}");
    selectTipX = xx.toInt();
    selectTipY = yy.toInt();
  }

  void drawTips(TinyStage stage, TinyCanvas canvas) {
    for (int y = 0; y < game.environ.targetRed.program.h; y++) {
      for (int x = 0; x < game.environ.targetRed.program.w; x++) {
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
    GameTip tip = game.environ.targetRed.program.getTip(x, y);
    p.color = new TinyColor(tip.id);

    if(x == selectTipX && y == selectTipY) {
      p.style = TinyPaintStyle.fill;
    } else {
      p.style = TinyPaintStyle.stroke;
    }
    canvas.drawRect(stage, rect, p);
    for(Next n in tip.dxys) {
      double angle = 0.0;
      if(n.dx==1 &&n.dy==0) {angle =   0.0;}
      if(n.dx==1 &&n.dy==1) {angle =  45.0;}
      if(n.dx==0 &&n.dy==1) {angle =  90.0;}
      if(n.dx==-1 &&n.dy==1){angle = 135.0;}
      if(n.dx==-1&&n.dy==0) {angle =  180.0;}
      if(n.dx==-1&&n.dy==-1) {angle =  215.0;}
      if(n.dx==0&&n.dy==-1) {angle =  260.0;}
      if(n.dx==1&&n.dy==-1) {angle =  315.0;}
      drawArrow(stage, canvas, x, y, math.PI*2.0*((angle-90.0)/360.0));
    }
  }

  void drawArrow(TinyStage stage, TinyCanvas canvas, int x, int y, double angle) {
    TinyPaint p = new TinyPaint();
    p.strokeWidth = 2.5;
    p.style = TinyPaintStyle.stroke;
    p.color = new TinyColor(game.environ.targetRed.program.getTip(x, y).id);

    double xx = 50.0+x*(50+20);
    double yy = 5.0+y*(50+20);
    double ww = 50.0;
    double hh = 50.0;

    //
    // allow
    TinyPoint p1 = new TinyPoint(-10.0, 0.0);
    TinyPoint p2 = new TinyPoint(-10.0, hh/2+(20.0*5/6.0));
    TinyPoint p3 = new TinyPoint(-10.0-ww*1/5, hh/2+(20.0*2/3.0));
    TinyPoint p4 = new TinyPoint(-10.0+ww*1/5, hh/2+(20.0*2/3.0));
    Matrix4 mat = new Matrix4.identity();

    mat.translate(xx+ww/2,yy+hh/2,0.0);
    mat.rotateZ(angle);
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
