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
  GameProgram program;
  double fieldWidth = 700.0;
  double fieldHeight = 500.0;

  Game() {
    f = new TinyGameBuilderForFlutter();
    playScene = new PlayScene(this);
    startScene = new StartScreen(this);
    progScene = new ProgramScree(this);
    stage = f.createStage(new TinyGameRoot(800.0, 600.0));
    program = new GameProgram(10, 7);
  }
}


class GameEnvirone {

}

class GameTargetSource extends GameTarget {
  double angle = 0.0;
  double dx = 0.0;
  double dy = 0.0;
  double x = 0.0;
  double y = 0.0;

  void next() {
    x +=dx;
    y +=dy;
  }
  void advance(double speed) {
    dx = speed*math.cos(angle);
    dy = speed*math.sin(angle);
  }

  void turn(double a) {
    angle += a;
  }
}

abstract class GameTarget {
  double angle = 0.0;
  double dx = 0.0;
  double dy = 0.0;
  double x = 0.0;
  double y = 0.0;
  void advance(double speed);
  void turn(double a);
}

class GameProgram {
  GameTip startTip;
  GameTip currentTip;
  List<GameTip> raw;
  int w;
  int h;

  GameProgram(this.w, this.h) {
    raw = new List.filled(w*h, new GameTip.empty());
    for(int i=0;i<w;i++) {
      setTip(i, 0, new GameTip.frame());
      setTip(i, h-1, new GameTip.frame());
    }
    for(int i=0;i<h;i++) {
      setTip(0, i, new GameTip.frame());
      setTip(w-1, i, new GameTip.frame());
    }
    startTip = new GameTip.start();
    currentTip = startTip;
    setTip(1, 0, startTip);
    setTip(1, 1, new GameTip.advance(dx:0,dy:1));
    setTip(1, 2, new GameTip.nop(dx:0,dy:1));
    setTip(1, 3, new GameTip.nop(dx:0,dy:1));
    setTip(1, 4, new GameTip.turning(dx:-1,dy:0));
  }

  void next(GameEnvirone e, GameTarget t) {
     currentTip = currentTip.next(this, e, t);
  }

  GameTip getTip(int x, int y) {
    return raw[x+y*w];
  }

  void setTip(int x, int y, GameTip v) {
    raw[x+y*w] = v;
    v.curX = x;
    v.curY = y;
  }
}

class GameTip {
  static const int id_empty = 0xffffffff;
  static const int id_frame = 0xffaa6666;
  static const int id_start = 0xffff0000;
  static const int id_advance = 0xff0000ff;
  static const int id_nop = 0xffaaaaaa;
  static const int id_turning = 0xffffffaa;

  int id = 0;
  int curX;
  int curY;
  List<Next> dxys = [];

  GameTip next(GameProgram p, GameEnvirone e, GameTarget t) {
    if(id == id_empty || id == id_frame) {
      return p.startTip;
    }
    if(id == id_nop|| id == id_start) {
      return p.getTip(curX+dxys.first.dx, curY+dxys.first.dy);
    }
    if(id == id_advance) {
      t.advance(1.0);
      return p.getTip(curX+dxys.first.dx, curY+dxys.first.dy);
    }
  }

  GameTip.custom(this.id) {

  }

  GameTip.empty(){
    id = id_empty;
  }

  GameTip.frame(){
    id = id_frame;
  }

  GameTip.start(){
    id = id_start;
    dxys.add(new Next(0,1));
  }

  GameTip.advance({int dx:0,int dy:1}) {
    id = id_advance;
    dxys.add(new Next(dx,dy));
  }

  GameTip.nop({int dx:0,int dy:1}) {
    id = id_nop;
    dxys.add(new Next(dx,dy));
  }

  factory GameTip.turning({int dx:0,int dy:1}) {
    return new GameTipTurning(dx:dx, dy:dy);
  }

}

enum GameTipTurningDirection {
  right,left
}

class GameTipTurning extends GameTip {
  GameTipTurningDirection direction = GameTipTurningDirection.right;
  GameTipTurning({int dx:0,int dy:1}) :super.custom(GameTip.id_turning) {
    dxys.add(new Next(dx,dy));
  }
  GameTip next(GameProgram p, GameEnvirone e, GameTarget t) {
    t.turn(math.PI/10.0);
    return p.getTip(curX+dxys.first.dx, curY+dxys.first.dy);
  }
}

class GameTipSleep extends GameTip {
  GameTipSleep() :super.custom(GameTip.id_turning) {
    ;
  }
}

class Next {
  int dx = 1;
  int dy = 1;
  int color = 0xffff0000;
  Next(this.dx, this.dy) {}
}

class MoveTip extends GameTip {
  MoveTip():super.empty() {
    ;
  }
}
