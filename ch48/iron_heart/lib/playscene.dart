import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'tinygame.dart';
import 'dart:math' as math;
import 'dart:async';
import 'package:flutter/services.dart';
import './main.dart';

class PlayScene extends TinyDisplayObject {
  Game game;
  TinyImage img = null;

  PlayScene(this.game) {
    game.f.loadImage("assets/bg_play.png").then((TinyImage i) {
      img = i;
    });
    {
      Chara chara = new Chara(game);
      child.add(chara);
    }
    {
      TinyButton button = new TinyButton("back_button", 200.0, 120.0, onPush);
      button.mat = new Matrix4.translationValues(30.0, 480.0, 0.0);
      button.bgcolorOn = new TinyColor.argb(0x22, 0xFF, 0x00, 0x00);
      button.bgcolorOff = new TinyColor.argb(0x55, 0x00, 0x00, 0xff);
      button.bgcolorFocus = new TinyColor.argb(0x11, 0x00, 0xff, 0x00);
      child.add(button);
    }

    {
      TinyButton button = new TinyButton("prog_button", 200.0, 120.0, onPush);
      button.mat = new Matrix4.translationValues(600.0 - 30.0, 480.0, 0.0);
      button.bgcolorOn = new TinyColor.argb(0x22, 0xFF, 0x00, 0x00);
      button.bgcolorOff = new TinyColor.argb(0x55, 0x00, 0x00, 0xff);
      button.bgcolorFocus = new TinyColor.argb(0x11, 0x00, 0xff, 0x00);
      child.add(button);
    }
  }
  void onPaint(TinyStage stage, TinyCanvas canvas) {
    TinyRect src = new TinyRect(0.0, 0.0, img.w.toDouble(), img.h.toDouble());
    TinyRect dst = new TinyRect(0.0, 0.0, 800.0, 600.0);
    TinyPaint p = new TinyPaint();
    if (img != null) {
      canvas.drawImageRect(stage, img, src, dst, p);
    }
  }

  void onPush(String id) {
    print("### ${id}");
    switch (id) {
      case "back_button":
        game.stage.root.clearChild();
        game.stage.root.addChild(game.startScene);
        break;
      case "prog_button":
        game.stage.root.clearChild();
        game.stage.root.addChild(game.progScene);
        break;
    }
  }
}

class Chara extends TinyDisplayObject {
  Game game;
  TinyImage img = null;

  Chara(this.game) {
    game.f.loadImage("assets/ch_iron.png").then((TinyImage i) {
      img = i;
    });
  }

  void onPaint(TinyStage stage, TinyCanvas canvas) {
    TinyRect src = new TinyRect(0.0, 0.0, img.w.toDouble(), img.h.toDouble());
    TinyRect dst = new TinyRect(0.0, 0.0, 100.0, 100.0);
    TinyPaint p = new TinyPaint();
    if (img != null) {
      canvas.drawImageRect(stage, img, src, dst, p);
    }
  }

}
