import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import '../tinygame.dart';
import 'dart:math' as math;
import 'dart:async';
import 'package:flutter/services.dart';
import '../playscene.dart';
import '../programscene.dart';
import '../main.dart';
import '../glogic/tip.dart';
import '../glogic/program.dart';
import '../glogic/game.dart';
import '../glogic/target.dart';

class GameEnvirone {
  GameProgram programRed;
  GameTarget targetRed;
  GameProgram programBlue;
  GameTarget targetBlue;
  double fieldX = 50.0;
  double fieldY = 50.0;
  double fieldWidth = 700.0;
  double fieldHeight = 500.0;

  GameEnvirone() {
    programRed = new GameProgram(10, 7);
    programBlue = new GameProgram(10, 7);
    targetRed = new GameTargetSource(this, 50.0);
    targetBlue = new GameTargetSource(this, 50.0);
  }
  void red() {
    //
    programRed.setTip(1, 1, new GameTip.advance(dx: 0, dy: 1));
    programRed.setTip(1, 2, new GameTip.nop(dx: 0, dy: 1));
    programRed.setTip(1, 3, new GameTip.nop(dx: 0, dy: 1));
    programRed.setTip(1, 4, new GameTip.turning(dx: -1, dy: 0));

    //
    programBlue.setTip(1, 1, new GameTip.advance(dx: 0, dy: 1));
    programBlue.setTip(1, 2, new GameTip.nop(dx: 0, dy: 1));
    programBlue.setTip(1, 3, new GameTip.nop(dx: 0, dy: 1));
    programBlue.setTip(1, 4, new GameTip.turning(dx: -1, dy: 0));
  }
}

class GameTargetSource extends GameTarget {
  double angle = 0.0;
  double dx = 0.0;
  double dy = 0.0;
  double x = 0.0;
  double y = 0.0;
  //radius
  double size;
  GameEnvirone game;

  GameTargetSource(this.game, this.size) {
    ;
  }

  void next() {
    x += dx;
    y += dy;
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
