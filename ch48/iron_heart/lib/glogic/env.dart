import 'dart:math' as math;
import 'dart:async';
import '../glogic/tip.dart';
import '../glogic/program.dart';
import '../glogic/target.dart';

class GameEnvirone {
  GameTarget targetRed;
  GameTarget targetBlue;
  double fieldX = 50.0;
  double fieldY = 50.0;
  double fieldWidth = 700.0;
  double fieldHeight = 500.0;

  GameEnvirone() {
    targetRed = new GameTargetSource(this, 50.0, "red");
    targetBlue = new GameTargetSource(this, 50.0, "blue");
  }

  void searchEnemy(GameTarget base, double starting, double ending) {
    double s = base.angle+starting;
    double e = base.angle+ending;
  }

  void red() {
    //
    targetRed.program.setTip(1, 1, new GameTip.advance(dx: 0, dy: 1));
    targetRed.program.setTip(1, 2, new GameTip.nop(dx: 0, dy: 1));
    targetRed.program.setTip(1, 3, new GameTip.nop(dx: 0, dy: 1));
    targetRed.program.setTip(1, 4, new GameTip.turning(dx: -1, dy: 0));

    //
    targetBlue.program.setTip(1, 1, new GameTip.advance(dx: 0, dy: 1));
    targetBlue.program.setTip(1, 2, new GameTip.nop(dx: 0, dy: 1));
    targetBlue.program.setTip(1, 3, new GameTip.nop(dx: 0, dy: 1));
    targetBlue.program.setTip(1, 4, new GameTip.turning(dx: -1, dy: 0));
  }
}
