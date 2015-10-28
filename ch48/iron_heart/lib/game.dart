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
    program = new Program(10, 7);
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


class Environe {

}

class Target {

}

class Program {
  Tip startTip;
  List<Tip> raw;
  int w;
  int h;

  Program(this.w, this.h) {
    raw = new List.filled(w*h, new Tip.empty());
    for(int i=0;i<w;i++) {
      setTip(i, 0, new Tip.frame());
      setTip(i, h-1, new Tip.frame());
    }
    for(int i=0;i<h;i++) {
      setTip(0, i, new Tip.frame());
      setTip(w-1, i, new Tip.frame());
    }
    startTip = new Tip.start();
    setTip(1, 0, startTip);
    setTip(1, 1, new Tip.advance());
    setTip(1, 2, new Tip.nop(dx:-1,dy:0));
  }

  Tip getTip(int x, int y) {
    return raw[x+y*w];
  }

  void setTip(int x, int y, Tip v) {
    raw[x+y*w] = v;
  }
}

class Tip {
  static const int id_empty = 0xffffffff;
  static const int id_frame = 0xffaa6666;
  static const int id_start = 0xffff0000;
  static const int id_advance = 0xff0000ff;
  static const int id_nop = 0xffaaaaaa;
  int id = 0;
  List<Next> dxys = [];

  Tip next(Program p, Environe e, Target t) {
    ;
  }

  Tip.empty(){
    id = id_empty;
  }

  Tip.frame(){
    id = id_frame;
  }

  Tip.start(){
    id = id_start;
    dxys.add(new Next(0,1));
  }

  Tip.advance({int dx:0,int dy:1}) {
    id = id_advance;
    dxys.add(new Next(dx,dy));
  }
  Tip.nop({int dx:0,int dy:1}) {
    id = id_nop;
    dxys.add(new Next(dx,dy));
  }
}

class Next {
  int dx = 1;
  int dy = 1;
  int color = 0xffff0000;
  Next(this.dx, this.dy) {}
}

class MoveTip extends Tip {
  MoveTip():super.empty() {
    ;
  }
}
