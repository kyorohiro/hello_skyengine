import 'dart:math' as math;
import '../glogic/program.dart';
import '../glogic/target.dart';
import '../glogic/env.dart';

class GameTip {
  static const int id_empty = 0xffffffff;
  static const int id_frame = 0xffaa6666;
  static const int id_start = 0xffff0000;
  static const int id_advance = 0xff0000ff;
  static const int id_nop = 0xffaaaaaa;
  static const int id_turning = 0xffffffaa;
  static const int id_search_enemy = 0xfffff100;

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
      t.advance(3.0);
      return p.getTip(curX+dxys.first.dx, curY+dxys.first.dy);
    }

    return null;
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

  factory GameTip.searchEnemy({int yesDx:0,int yesDy:1, int noDx:1, int noDy:0}) {
    return new GameTipSearchEnemy(yesDx:yesDx, yesDy:yesDy, noDx:noDx, noDy:noDy);
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
    t.turn(math.PI/40.0);
    return p.getTip(curX+dxys.first.dx, curY+dxys.first.dy);
  }
}

class GameTipSearchEnemy extends GameTip {
  GameTipSearchEnemy({int yesDx:0,int yesDy:1, int noDx:1, int noDy:0}) :super.custom(GameTip.id_search_enemy) {
    dxys.add(new Next(yesDx,yesDy));
    dxys.add(new Next(noDx,noDy));
  }

  GameTip next(GameProgram p, GameEnvirone e, GameTarget t) {
    bool ret = e.searchEnemy(t, t.angle, math.PI/4, 0.0, 500.0);
    if(ret == true) {
      return p.getTip(curX+dxys[0].dx, curY+dxys[0].dy);
    } else {
      return p.getTip(curX+dxys[1].dx, curY+dxys[1].dy);
    }
  }
}

class GameTipSleep extends GameTip {
  GameTipSleep() :super.custom(GameTip.id_turning) {
    ;
  }

  GameTip next(GameProgram p, GameEnvirone e, GameTarget t) {
    //
    //
    //
    return p.getTip(curX+dxys.first.dx, curY+dxys.first.dy);
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
