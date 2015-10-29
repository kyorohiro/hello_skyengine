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
import '../glogic/target.dart';
import '../glogic/env.dart';

class GameTargetSource extends GameTarget {
  String groupName;
  double angle = 0.0;
  double dx = 0.0;
  double dy = 0.0;
  double x = 0.0;
  double y = 0.0;
  //radius
  double size;
  GameEnvirone game;

  GameTargetSource(this.game, this.size, this.groupName) {
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
