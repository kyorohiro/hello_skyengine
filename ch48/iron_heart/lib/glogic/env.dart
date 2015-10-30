import 'dart:math' as math;
import 'dart:async';
import '../glogic/tip.dart';
import '../glogic/program.dart';
import '../glogic/target.dart';

import '../tinyphysics2d.dart';

class GameEnvirone {
  World world = new World();

  GameTarget _targetRed;
  GameTarget _targetBlue;
  GameTarget get targetRed => _targetRed;
  GameTarget get targetBlue => _targetBlue;
  double fieldX = 50.0;
  double fieldY = 50.0;
  double fieldWidth = 700.0;
  double fieldHeight = 500.0;

  GameEnvirone() {
    _targetRed = new GameTargetSource(this, 50.0, "red");
    _targetBlue = new GameTargetSource(this, 50.0, "blue");
    world.primitives.add(_targetRed);
    world.primitives.add(_targetBlue);
  }

  List<GameTarget> getEnemy(GameTarget own) {
    List<GameTarget> l = [];
    if (own.groupName != targetRed.groupName) {
      l.add(targetRed);
    } else if (own.groupName != targetBlue.groupName) {
      l.add(targetBlue);
    }
    return l;
  }

  void next(int timeStamp) {
    List<GameTarget> l = [targetRed, targetBlue];
    for (GameTarget t in l) {
      t.program.next(this, t);
    //  t.next(1.0);
    }
    world.next(1.0);
  }

  bool searchEnemy(GameTarget base, double direction, double range,
      double startDist, double endDist) {
    double s2 = normalizeAngle(direction);
    double starting = s2 - math.PI / 1.5;
    double ending = s2 + math.PI / 1.5;
    double s = base.angle + starting;
    double e = base.angle + ending;
    List<GameTarget> l = getEnemy(base);
    for (GameTarget t in l) {
      double d = distance(base, t);
      double a = angleFromP2(t, base);
      //print("## a=${a}   d=${d} n=${normalizeAngle(base.angle)}");

      double s1 = normalizeAngle(a - direction);

      double ss = a - starting;
      double ee = a - ending;

      double xx = t.x - base.x;
      double yy = t.y - base.y;
      if (ss >= 0 && ee <= 0) {
        //  print("find true!! tar=${s1}   dir=${s2} ## xx/yy=${xx}/${yy} ######${targetRed.groupName} ${targetBlue.y}## ${ss} ${ee}");
        return true;
      } else {
        //  print("find false!! tar=${s1}  dir=${s2} ## xx/yy=${xx}/${yy} ######${targetRed.groupName} ${targetBlue.y}## ${ss} ${ee}");
      }
    }
    return false;
  }

  static double normalizeAngle(double a) {
    a += math.PI * 2 * 4;
    a = a % (2 * math.PI);
    if (a < math.PI) {
      return a;
    } else {
      return -math.PI + (a - math.PI);
    }
  }

  static double distance(GameTarget p1, GameTarget p2) {
    double x = p1.x - p2.x;
    double y = p1.y - p2.y;
    return math.sqrt(x * x + y * y);
  }

  static double angleFromP2(GameTarget p1, GameTarget p2) {
    double x = p1.x - p2.x;
    double y = p1.y - p2.y;
    return math.atan2(y, x); //+math.PI/2;
  }

  void init() {
    targetRed.angle = 0.0; //-math.PI/1.4;
    targetRed.dx = 0.0;
    targetRed.dy = 0.0;
    targetRed.x = 200.0;
    targetRed.y = 300.0;

    targetBlue.angle = math.PI;
    targetBlue.dx = 0.0;
    targetBlue.dy = 0.0;
    targetBlue.x = 700.0;
    targetBlue.y = 300.0;
  }

  void red() {
    //
    targetBlue.program.setTip(1, 1, new GameTip.nop(dx: 0, dy: 1));
    targetBlue.program.setTip(1, 2, new GameTip.nop(dx: 0, dy: 1));
    targetBlue.program.setTip(1, 3, new GameTip.nop(dx: 0, dy: 1));
    targetBlue.program.setTip(1, 4, new GameTip.turning(dx: -1, dy: 0));

    //
    targetRed.program.setTip(1, 1, new GameTip.nop(dx: 0, dy: 1));
    targetRed.program.setTip(1, 2, new GameTip.nop(dx: 0, dy: 1));
    targetRed.program.setTip(1, 3, new GameTip.nop(dx: 0, dy: 1));
    targetRed.program.setTip(1, 4, new GameTip.nop(dx: 0, dy: 1));
    targetRed.program.setTip(
        1, 5, new GameTip.searchEnemy(yesDx: 1, yesDy: 0, noDx: -1, noDy: 0));
    targetRed.program.setTip(2, 5, new GameTip.advance(dx: 1, dy: 0));
    targetRed.program.setTip(3, 5, new GameTip.advance(dx: 1, dy: 0));
    targetRed.program.setTip(4, 5, new GameTip.advance(dx: 0, dy: 1));
  }
}
