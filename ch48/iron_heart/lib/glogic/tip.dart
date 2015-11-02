import 'dart:math' as math;
import '../glogic/program.dart';
import '../glogic/target.dart';
import '../glogic/env.dart';

class GameTip {
  static const int id_empty = 0xffffffff;
  static const int id_frame = 0xffaa6666;
  static const int id_start = 0xffff0000;

  static const int id_front = 0xff0000f0;
  static const int id_right = 0xff0000f1;
  static const int id_left = 0xff0000f2;
  static const int id_back = 0xff0000f3;

  static const int id_nop = 0xffaaaaaa;
  static const int id_turning_right = 0xffffffaa;
  static const int id_turning_left = 0xffffffab;
  static const int id_search_enemy = 0xfffff100;
  static const int id_shoot = 0xfffff201;
  int id = 0;
  int curX;
  int curY;
  List<Next> dxys = [];

  GameTip next(GameProgram p, GameEnvirone e, GameTarget t) {
    switch(id) {
      case id_empty:
      case id_frame:
        return p.startTip;
      case id_nop:
      case id_start:
        return p.getTip(curX+dxys.first.dx, curY+dxys.first.dy);
      case id_front:
        t.advance(3.0);
        return p.getTip(curX+dxys.first.dx, curY+dxys.first.dy);
      case id_right:
        t.right(1.0);
        return p.getTip(curX+dxys.first.dx, curY+dxys.first.dy);
      case id_left:
        t.left(1.0);
        return p.getTip(curX+dxys.first.dx, curY+dxys.first.dy);
      case id_back:
        t.back(1.5);
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

  GameTip.front({int dx:0,int dy:1}) {
    id = id_front;
    dxys.add(new Next(dx,dy));
  }

  GameTip.back({int dx:0,int dy:1}) {
    id = id_back;
    dxys.add(new Next(dx,dy));
  }

  GameTip.right({int dx:0,int dy:1}) {
    id = id_right;
    dxys.add(new Next(dx,dy));
  }

  GameTip.left({int dx:0,int dy:1}) {
    id = id_left;
    dxys.add(new Next(dx,dy));
  }

  GameTip.nop({int dx:0,int dy:1}) {
    id = id_nop;
    dxys.add(new Next(dx,dy));
  }

  factory GameTip.turningRight({int dx:0,int dy:1}) {
    return new GameTipTurningRight(dx:dx, dy:dy);
  }

  factory GameTip.turningLeft({int dx:0,int dy:1}) {
    return new GameTipTurningLeft(dx:dx, dy:dy);
  }

  factory GameTip.searchEnemy({int yesDx:0,int yesDy:1, int noDx:1, int noDy:0}) {
    return new GameTipSearchEnemy(yesDx:yesDx, yesDy:yesDy, noDx:noDx, noDy:noDy);
  }

  factory GameTip.shoot({int dx:0,int dy:1}) {
    return new GameTipShoot(dx:dx, dy:dy);
  }

}

enum GameTipTurningDirection {
  right,left
}

class GameTipTurningRight extends GameTip {
  GameTipTurningDirection direction = GameTipTurningDirection.right;
  GameTipTurningRight({int dx:0,int dy:1}) :super.custom(GameTip.id_turning_right) {
    dxys.add(new Next(dx,dy));
  }
  GameTip next(GameProgram p, GameEnvirone e, GameTarget t) {
    t.turn(math.PI/40.0);
    return p.getTip(curX+dxys.first.dx, curY+dxys.first.dy);
  }
}

class GameTipTurningLeft extends GameTip {
  GameTipTurningDirection direction = GameTipTurningDirection.right;
  GameTipTurningLeft({int dx:0,int dy:1}) :super.custom(GameTip.id_turning_left) {
    dxys.add(new Next(dx,dy));
  }
  GameTip next(GameProgram p, GameEnvirone e, GameTarget t) {
    t.turn(-1*math.PI/40.0);
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


class GameTipShoot extends GameTip {
  double angle = 0.0;
  double range = math.PI/4;
  double distance = 0.8;
  double bullet = 1.0;
  GameTipShoot({int dx:0,int dy:1}) :super.custom(GameTip.id_shoot) {
    dxys.add(new Next(dx,dy));
  }
  GameTip next(GameProgram p, GameEnvirone e, GameTarget t) {
    //t.turn(math.PI/40.0);
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
