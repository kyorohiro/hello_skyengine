import 'dart:math' as math;
import '../glogic/program.dart';
import '../glogic/env.dart';
import '../tinyphysics2d.dart';

class GameTargetSource extends GameTarget {

  //radius
  void set size(double v) {radius = v;}
  double get size => radius;
  GameEnvirone game;

  GameTargetSource(this.game,  double s, String groupName) {
    program = new GameProgram(10, 7);
    radius = s;
    this.groupName = groupName;
  }


  void next(double t) {
    super.next(t);

    //x += dx;
    //y += dy;
    if (game.fieldX > x - size) {
      x = game.fieldX + size;
    }
    if (game.fieldX + game.fieldWidth < x + size) {
      x = game.fieldX + game.fieldWidth - size;
    }

    if (game.fieldY > y - size) {
      y = game.fieldY + size;
    }
    if (game.fieldY + game.fieldHeight < y + size) {
      y = game.fieldY + game.fieldHeight - size;
    }
  }

  void advance(double speed) {
    dx = speed * math.cos(angle);
    dy = speed * math.sin(angle);
  }

  void right(double speed) {
    dx = -1*speed * math.sin(angle);
    dy = speed * math.cos(angle);
  }

  void left(double speed) {
    dx = speed * math.sin(angle);
    dy = -1*speed * math.cos(angle);
  }
  void back(double speed) {
    dx = -1*speed * math.cos(angle);
    dy = -1*speed * math.sin(angle);
  }
  void turn(double a) {
    angle += a;
  }
}

abstract class GameTarget extends CirclePrimitive{//Primitive {
  double angle = 0.0;
  double get dx => dxy[0];//0.0;
  double get dy => dxy[1];//0.0;
  double get x => xy[0];//0.0;
  double get y => xy[1];// 0.0;
  void set x(double v) {xy[0] = v;}
  void set y(double v) {xy[1] = v;}
  void set dx(double v) {dxy[0] = v;}
  void set dy(double v) {dxy[1] = v;}
  GameProgram program;
  String groupName;

  void next(double t);
  void advance(double speed);
  void right(double speed);
  void left(double speed);
  void back(double speed);
  void turn(double a);
}
