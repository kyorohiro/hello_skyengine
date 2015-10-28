import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import '../tinygame.dart';
import 'dart:math' as math;
import 'dart:async';
import 'package:flutter/services.dart';
import '../playscene.dart';
import '../programscene.dart';
import '../main.dart';
import '../glogic/game.dart';
import '../glogic/program.dart';

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
