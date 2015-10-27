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
    drawBoard(stage, canvas);
    drawTip(stage, canvas);
  }

  void drawBG(TinyStage stage, TinyCanvas canvas) {
    if (img != null) {
      TinyRect src = new TinyRect(0.0, 0.0, img.w.toDouble(), img.h.toDouble());
      TinyRect dst = new TinyRect(0.0, 0.0, 800.0, 600.0);
      TinyPaint p = new TinyPaint();
      canvas.drawImageRect(stage, img, src, dst, p);
    }
  }

  void drawBoard(TinyStage stage, TinyCanvas canvas) {
    TinyPaint p = new TinyPaint();
    p.color = new TinyColor.argb(0xaa, 0xff, 0xff, 0x00);
    p.strokeWidth = 2.5;
    p.style = TinyPaintStyle.stroke;
    TinyRect rect = new TinyRect(50.0, 5.0, 700.0, 400.0);
    canvas.drawRect(stage, rect, p);
  }

  void drawTip(TinyStage stage, TinyCanvas canvas) {
    TinyPaint p = new TinyPaint();
    p.color = new TinyColor.argb(0xaa, 0xff, 0x00, 0x00);
    p.strokeWidth = 2.5;
    p.style = TinyPaintStyle.stroke;
    TinyRect rect = new TinyRect(50.0, 5.0, 50.0, 50.0);
    for (int y = 0; y < game.program.h; y++) {
      for (int x = 0; x < game.program.w; x++) {
        p.color = new TinyColor(game.program.getTip(x, y).id);
        canvas.drawRect(stage, rect, p);
        rect.x += 50.0 + 20.0;
      }
      rect.x = 50.0;
      rect.y += 50.0 + 20.0;
    }
  }

  void onPush(String id) {
    game.stage.root.clearChild();
    game.stage.root.addChild(game.playScene);
  }
}
