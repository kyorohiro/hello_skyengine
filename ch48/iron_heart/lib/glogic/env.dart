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
    targetRed = new GameTargetSource(this, 50.0, "red");
    targetBlue = new GameTargetSource(this, 50.0, "blue");
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
