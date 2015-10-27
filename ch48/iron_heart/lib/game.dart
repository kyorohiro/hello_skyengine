import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'tinygame.dart';
import 'dart:math' as math;
import 'dart:async';
import 'package:flutter/services.dart';
import 'playscene.dart';
import 'programscene.dart';
import 'main.dart';

class Game {
  TinyGameBuilderForFlutter f;
  PlayScene playScene;
  StartScreen startScene;
  ProgramScree progScene;
  TinyStage stage;
  Program program;

  Game() {
    f = new TinyGameBuilderForFlutter();
    playScene = new PlayScene(this);
    startScene = new StartScreen(this);
    progScene = new ProgramScree(this);
    stage = f.createStage(new TinyGameRoot(800.0, 600.0));
    program = new Program(6, 6);
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

class Program {
  List<Tip> raw;
  int w;
  int h;
  Program(this.w, this.h) {
    raw = new List.filled((w+2)*(h+2), new Tip.empty());
  }

}

class Tip {
  Tip.empty(){}
}

class MoveTip extends Tip {
  MoveTip():super.empty() {
    ;
  }
}
