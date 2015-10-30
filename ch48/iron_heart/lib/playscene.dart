import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'tinygame.dart';
import 'glogic/game.dart';
import 'playchara.dart';

class PlayScene extends TinyDisplayObject {
  Game game;
  TinyImage img = null;

  TinyButton createBackButton() {
    TinyButton button = new TinyButton("back_button", 200.0, 120.0, onPush);
    button.mat = new Matrix4.translationValues(30.0, 480.0, 0.0);
    button.bgcolorOn = new TinyColor.argb(0x22, 0xFF, 0x00, 0x00);
    button.bgcolorOff = new TinyColor.argb(0x00, 0x00, 0x00, 0xff);
    button.bgcolorFocus = new TinyColor.argb(0x11, 0x00, 0xff, 0x00);
    return button;
  }

  TinyButton createNextButton() {
    TinyButton button = new TinyButton("prog_button", 200.0, 120.0, onPush);
    button.mat = new Matrix4.translationValues(600.0 - 30.0, 480.0, 0.0);
    button.bgcolorOn = new TinyColor.argb(0x22, 0xFF, 0x00, 0x00);
    button.bgcolorOff = new TinyColor.argb(0x00, 0x00, 0x00, 0xff);
    button.bgcolorFocus = new TinyColor.argb(0x11, 0x00, 0xff, 0x00);
    return button;
  }

  PlayChara charaBlue;
  PlayChara charaRed;
  PlayScene(this.game) {
    game.f.loadImage("assets/bg_play.png").then((TinyImage i) {
      img = i;
    });
    {
      charaBlue = new PlayChara(game, game.environ.targetBlue,
        iconSrc:"assets/ch_iron.png");
      charaRed = new PlayChara(game, game.environ.targetRed,
        iconSrc:"assets/ch_iron2.png");
      child.add(charaBlue);
      child.add(charaRed);
    }
    child.add(createBackButton());
    child.add(createNextButton());
  }
  void onConnect() {
    print("--------------------------init()");
    game.environ.init();
  }

  void onPaint(TinyStage stage, TinyCanvas canvas) {
    if (img != null) {
      TinyRect src = new TinyRect(0.0, 0.0, img.w.toDouble(), img.h.toDouble());
      TinyRect dst = new TinyRect(0.0, 0.0, 800.0, 600.0);
      TinyPaint p = new TinyPaint();
      canvas.drawImageRect(stage, img, src, dst, p);
    }
    {
      TinyRect rect = new TinyRect(50.0, 50.0, game.environ.fieldWidth, game.environ.fieldHeight);
      TinyPaint p = new TinyPaint();
      p.color = new TinyColor.argb(0xaa, 0xff, 0xff, 0x00);
      p.style = TinyPaintStyle.stroke;
      p.strokeWidth = 5.0;
      canvas.drawRect(stage, rect, p);
    }
  }

  void onTick(TinyStage stage, int timeStamp) {
    this.game.environ.next(timeStamp);
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
