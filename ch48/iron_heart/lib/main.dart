import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'tinygame.dart';
import 'dart:math' as math;
import 'dart:async';
import 'package:flutter/services.dart';
import 'playscene.dart';

void main() {
  Game game = new Game();
  runApp(new GameWidget(game));
}

class Game {
  TinyGameBuilderForFlutter f;
  PlayScene playScene;
  StartScreen startScene;
  ProgramScree progScene;
  TinyStage stage;

  Game() {
    f = new TinyGameBuilderForFlutter();
    playScene = new PlayScene(this);
    startScene = new StartScreen(this);
    progScene = new ProgramScree(this);
    stage = f.createStage(new TinyGameRoot(800.0, 600.0));
  }
}

class GameWidget extends OneChildRenderObjectWidget {
  Game game;
  GameWidget(this.game) {}
  RenderObject createRenderObject() {
    game.stage.start();
    game.stage.root.child.add(game.startScene);
    return (game.stage as TinyFlutterStage);
  }
}


class StartScreen extends TinyDisplayObject {
  Game game;
  TinyImage img = null;
  StartScreen(this.game) {
    TinyButton button = new TinyButton("start_button", 600.0, 200.0, onPush);
    button.mat = new Matrix4.translationValues(100.0, 300.0, 0.0);
    button.bgcolorOn = new TinyColor.argb(0x22, 0xFF, 0x00, 0x00);
    button.bgcolorOff = new TinyColor.argb(0x00, 0x00, 0x00, 0xff);
    button.bgcolorFocus = new TinyColor.argb(0x11, 0x00, 0xff, 0x00);
    child.add(button);
    game.f.loadImage("assets/bg_start.png").then((TinyImage i) {
      img = i;
    });
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
    game.stage.root.clearChild();
    game.stage.root.addChild(game.playScene);
  }
}


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
    game.stage.root.clearChild();
    game.stage.root.addChild(game.playScene);
  }
}
